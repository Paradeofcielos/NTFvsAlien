
/obj/structure/xeno/silo
	name = "Resin silo"
	icon = 'icons/Xeno/resin_silo.dmi'
	icon_state = "weed_silo"
	desc = "A slimy, oozy resin bed filled with foul-looking egg-like ...things."
	bound_width = 96
	bound_height = 96
	max_integrity = 1000
	resistance_flags = UNACIDABLE | DROPSHIP_IMMUNE | PLASMACUTTER_IMMUNE
	xeno_structure_flags = IGNORE_WEED_REMOVAL|CRITICAL_STRUCTURE
	///How many larva points one silo produce in one minute
	var/larva_spawn_rate = 0.5
	var/turf/center_turf
	var/number_silo
	///For minimap icon change if silo takes damage or nearby hostile
	var/warning
	COOLDOWN_DECLARE(silo_damage_alert_cooldown)
	COOLDOWN_DECLARE(silo_proxy_alert_cooldown)

/obj/structure/xeno/silo/Initialize(mapload, _hivenumber)
	. = ..()
	center_turf = get_step(src, NORTHEAST)
	if(!istype(center_turf))
		center_turf = loc

	if(SSticker.mode?.flags_round_type & MODE_SILO_RESPAWN)
		for(var/turfs in RANGE_TURFS(XENO_SILO_DETECTION_RANGE, src))
			RegisterSignal(turfs, COMSIG_ATOM_ENTERED, PROC_REF(resin_silo_proxy_alert))

	if(SSticker.mode?.flags_round_type & MODE_SILOS_SPAWN_MINIONS)
		SSspawning.registerspawner(src, INFINITY, GLOB.xeno_ai_spawnable, 0, 0, null)
		SSspawning.spawnerdata[src].required_increment = 2 * max(45 SECONDS, 3 MINUTES - SSmonitor.maximum_connected_players_count * SPAWN_RATE_PER_PLAYER)/SSspawning.wait
		SSspawning.spawnerdata[src].max_allowed_mobs = max(1, MAX_SPAWNABLE_MOB_PER_PLAYER * SSmonitor.maximum_connected_players_count * 0.5)
	update_minimap_icon()

	return INITIALIZE_HINT_LATELOAD


/obj/structure/xeno/silo/LateInitialize()
	. = ..()
	var/siloprefix = GLOB.hive_datums[hivenumber].name
	number_silo = length(GLOB.xeno_resin_silos_by_hive[hivenumber]) + 1
	name = "[siloprefix == "Normal" ? "" : "[siloprefix] "][name] [number_silo]"
	LAZYADDASSOC(GLOB.xeno_resin_silos_by_hive, hivenumber, src)

	if(!locate(/obj/alien/weeds) in center_turf)
		new /obj/alien/weeds/node(center_turf)
	if(GLOB.hive_datums[hivenumber])
		RegisterSignals(GLOB.hive_datums[hivenumber], list(COMSIG_HIVE_XENO_MOTHER_PRE_CHECK, COMSIG_HIVE_XENO_MOTHER_CHECK), PROC_REF(is_burrowed_larva_host))
		if(length(GLOB.xeno_resin_silos_by_hive[hivenumber]) == 1)
			GLOB.hive_datums[hivenumber].give_larva_to_next_in_queue()
	var/turf/tunnel_turf = get_step(center_turf, NORTH)
	if(tunnel_turf.can_dig_xeno_tunnel())
		var/obj/structure/xeno/tunnel/newt = new(tunnel_turf, hivenumber)
		newt.tunnel_desc = "[AREACOORD_NO_Z(newt)]"
		newt.name += " [name]"

/obj/structure/xeno/silo/obj_destruction(damage_amount, damage_type, damage_flag)
	if(GLOB.hive_datums[hivenumber])
		UnregisterSignal(GLOB.hive_datums[hivenumber], list(COMSIG_HIVE_XENO_MOTHER_PRE_CHECK, COMSIG_HIVE_XENO_MOTHER_CHECK))
		GLOB.hive_datums[hivenumber].xeno_message("A resin silo has been destroyed at [AREACOORD_NO_Z(src)]!", "xenoannounce", 5, FALSE,src.loc, 'sound/voice/alien_help2.ogg',FALSE , null, /atom/movable/screen/arrow/silo_damaged_arrow)
		notify_ghosts("\ A resin silo has been destroyed at [AREACOORD_NO_Z(src)]!", source = get_turf(src), action = NOTIFY_JUMP)
		playsound(loc,'sound/effects/alien_egg_burst.ogg', 75)
	return ..()

/obj/structure/xeno/silo/Destroy()
	GLOB.xeno_resin_silos_by_hive[hivenumber] -= src

	for(var/i in contents)
		var/atom/movable/AM = i
		AM.forceMove(get_step(center_turf, pick(CARDINAL_ALL_DIRS)))
	center_turf = null

	STOP_PROCESSING(SSslowprocess, src)
	return ..()

/obj/structure/xeno/silo/examine(mob/user)
	. = ..()
	var/current_integrity = (obj_integrity / max_integrity) * 100
	switch(current_integrity)
		if(0 to 20)
			. += span_warning("It's barely holding, there's leaking oozes all around, and most eggs are broken. Yet it is not inert.")
		if(20 to 40)
			. += span_warning("It looks severely damaged, its movements slow.")
		if(40 to 60)
			. += span_warning("It's quite beat up, but it seems alive.")
		if(60 to 80)
			. += span_warning("It's slightly damaged, but still seems healthy.")
		if(80 to 100)
			. += span_info("It appears in good shape, pulsating healthily.")

//*******************
//Corpse recyclinging and larva force burrow
//*******************
/obj/structure/xeno/silo/attackby(obj/item/I, mob/user, params)
	. = ..()

	if(!istype(I, /obj/item/grab))
		return

	var/obj/item/grab/G = I
	if(!iscarbon(G.grabbed_thing))
		return
	var/mob/living/carbon/victim = G.grabbed_thing
	if(!ishuman(victim) && !isxenolarva(victim)) //humans and monkeys only for now
		to_chat(user, "<span class='notice'>[src] can only process humanoid anatomies or larvas!</span>")
		return

	if(ishuman(victim))
		if(victim.stat != DEAD)
			to_chat(user, "<span class='notice'>[victim] is not dead!</span>")
			return

		if(issynth(victim))
			to_chat(user, "<span class='notice'>[victim] has no useful biomass for us.</span>")
			return

		visible_message("[user] starts putting [victim] into [src].", 3)

		if(!do_after(user, 20, FALSE, victim, BUSY_ICON_DANGER) || QDELETED(src))
			return

		victim.forceMove(src)

		shake(4 SECONDS)

		var/datum/job/xeno_job = SSjob.GetJobType(/datum/job/xenomorph)
		xeno_job.add_job_points(4.5) //4.5 corpses per burrowed; 8 points per larva

		log_combat(victim, user, "was consumed by a resin silo")
		log_game("[key_name(victim)] was consumed by a resin silo at [AREACOORD(victim.loc)].")

	else
		if(isxenolarva(victim))
			if(victim.stat == DEAD)
				to_chat(user, "<span class='notice'>[victim] is dead!</span>")
				return
			var/mob/living/carbon/xenomorph/larva/larba = G.grabbed_thing
			if(isxenolarva(larba))
				if(!larba.issamexenohive(user))
					to_chat(user, "<span class='notice'>[larba] is not of our hive!</span>")
					return

			visible_message("[user] starts making [victim] burrow into [src].", 3)

			if(!do_after(user, 1 SECONDS, FALSE, victim, BUSY_ICON_DANGER) || QDELETED(src))
				return

			larba.burrow()
			shake(4 SECONDS)

/// Make the silo shake
/obj/structure/xeno/silo/proc/shake(duration)
	/// How important should be the shaking movement
	var/offset = prob(50) ? -2 : 2
	/// Track the last position of the silo for the animation
	var/old_pixel_x = pixel_x
	/// Sound played when shaking
	var/shake_sound = rand(1, 100) == 1 ? 'sound/machines/blender.ogg' : 'sound/machines/juicer.ogg'
	if(prob(1))
		playsound(src, shake_sound, 25, TRUE)
	animate(src, pixel_x = pixel_x + offset, time = 2, loop = -1) //start shaking
	addtimer(CALLBACK(src, .proc/stop_shake, old_pixel_x), duration)

/// Stop the shaking animation
/obj/structure/xeno/silo/proc/stop_shake(old_px)
	animate(src)
	pixel_x = old_px

/obj/structure/xeno/silo/take_damage(damage_amount, damage_type, damage_flag, sound_effect, attack_dir, armour_penetration)
	. = ..()

	//We took damage, so it's time to start regenerating if we're not already processing
	if(!CHECK_BITFIELD(datum_flags, DF_ISPROCESSING))
		START_PROCESSING(SSslowprocess, src)

	resin_silo_damage_alert()

/obj/structure/xeno/silo/proc/resin_silo_damage_alert()
	if(!COOLDOWN_CHECK(src, silo_damage_alert_cooldown))
		return
	warning = TRUE
	update_minimap_icon()
	GLOB.hive_datums[hivenumber].xeno_message("Our [name] at [AREACOORD_NO_Z(src)] is under attack! It has [obj_integrity]/[max_integrity] Health remaining.", "xenoannounce", 5, FALSE, src, 'sound/voice/alien_help1.ogg',FALSE, null, /atom/movable/screen/arrow/silo_damaged_arrow)
	COOLDOWN_START(src, silo_damage_alert_cooldown, XENO_SILO_HEALTH_ALERT_COOLDOWN) //set the cooldown.
	addtimer(CALLBACK(src, PROC_REF(clear_warning)), XENO_SILO_HEALTH_ALERT_COOLDOWN) //clear warning

///Alerts the Hive when hostiles get too close to their resin silo
/obj/structure/xeno/silo/proc/resin_silo_proxy_alert(datum/source, atom/movable/hostile, direction)
	SIGNAL_HANDLER

	if(!COOLDOWN_CHECK(src, silo_proxy_alert_cooldown)) //Proxy alert triggered too recently; abort
		return

	if(!isliving(hostile))
		return

	var/mob/living/living_triggerer = hostile
	if(living_triggerer.stat == DEAD) //We don't care about the dead
		return

	if(isxeno(hostile))
		var/mob/living/carbon/xenomorph/X = hostile
		if(X.hive == GLOB.hive_datums[hivenumber]) //Trigger proxy alert only for hostile xenos
			return

	warning = TRUE
	update_minimap_icon()
	GLOB.hive_datums[hivenumber].xeno_message("Our [name] has detected a nearby hostile [hostile] at [get_area(hostile)] (X: [hostile.x], Y: [hostile.y]).", "xenoannounce", 5, FALSE, hostile, 'sound/voice/alien_help1.ogg', FALSE, null, /atom/movable/screen/arrow/leader_tracker_arrow)
	COOLDOWN_START(src, silo_proxy_alert_cooldown, XENO_SILO_DETECTION_COOLDOWN) //set the cooldown.
	addtimer(CALLBACK(src, PROC_REF(clear_warning)), XENO_SILO_DETECTION_COOLDOWN) //clear warning

///Clears the warning for minimap if its warning for hostiles
/obj/structure/xeno/silo/proc/clear_warning()
	warning = FALSE
	update_minimap_icon()

/obj/structure/xeno/silo/process()
	//Regenerate if we're at less than max integrity
	if(obj_integrity < max_integrity)
		obj_integrity = min(obj_integrity + 25, max_integrity) //Regen 5 HP per sec

/obj/structure/xeno/silo/proc/is_burrowed_larva_host(datum/source, list/mothers, list/silos)
	SIGNAL_HANDLER
	if(GLOB.hive_datums[hivenumber])
		silos += src

///Change minimap icon if silo is under attack or not
/obj/structure/xeno/silo/proc/update_minimap_icon()
	SSminimaps.remove_marker(src)
	SSminimaps.add_marker(src, MINIMAP_FLAG_XENO, image('icons/UI_icons/map_blips.dmi', null, "silo[warning ? "_warn" : "_passive"]"))
