/datum/job/terragov/command
	job_category = JOB_CAT_COMMAND
	selection_color = "#ddddff"
	supervisors = "the acting captain"
	exp_type_department = EXP_TYPE_COMMAND
	shadow_languages = list(/datum/language/xenocommon)

//Captain
/datum/job/terragov/command/captain
	title = CAPTAIN
	req_admin_notify = TRUE
	paygrade = "COL"
	comm_title = "CMDR"
	supervisors = "NTC high command"
	selection_color = "#ccccff"
	total_positions = 1
	skills_type = /datum/skills/captain
	access = ALL_MARINE_ACCESS
	minimal_access = ALL_MARINE_ACCESS
	display_order = JOB_DISPLAY_ORDER_CAPTAIN
	outfit = /datum/outfit/job/command/captain
	multiple_outfits = TRUE
	outfits = list(
		/datum/outfit/job/command/captain,
		/datum/outfit/job/command/captain/robot,
	)
	exp_requirements = XP_REQ_EXPERT
	exp_type = EXP_TYPE_REGULAR_ALL
	job_flags = JOB_FLAG_LATEJOINABLE|JOB_FLAG_ROUNDSTARTJOINABLE|JOB_FLAG_ALLOWS_PREFS_GEAR|JOB_FLAG_PROVIDES_BANK_ACCOUNT|JOB_FLAG_ADDTOMANIFEST|JOB_FLAG_ISCOMMAND|JOB_FLAG_BOLD_NAME_ON_SELECTION|JOB_FLAG_PROVIDES_SQUAD_HUD|JOB_FLAG_ALWAYS_VISIBLE_ON_MINIMAP|JOB_FLAG_LOUDER_TTS
	jobworth = list(
		/datum/job/xenomorph = LARVA_POINTS_SHIPSIDE,
		/datum/job/terragov/squad/smartgunner = SMARTIE_POINTS_REGULAR,
		/datum/job/terragov/silicon/synthetic = SYNTH_POINTS_REGULAR,
		/datum/job/terragov/command/mech_pilot = MECH_POINTS_REGULAR,
	)
	html_description = {"
		<b>Difficulty</b>: Hard<br /><br />
		<b>You answer to</b> NTC High Command<br /><br />
		<b>Unlock Requirement</b>: Starting Role<br /><br />
		<b>Gamemode Availability</b>: Nuclear War<br /><br /><br />
		<b>Duty</b>: Lead the NTF platoon and complete your mission. Support the marines and communicate with your command staff, execute orders.
	"}
	minimap_icon = "captain"

/datum/job/terragov/command/captain/radio_help_message(mob/M)
	. = ..()
	to_chat(M, {"As the Commander of the [SSmapping.configs[SHIP_MAP].map_name] you are held by higher standard and are expected to act competently.
While you may support Ninetails, you report to the NTC High Command, the corporate office.
Your first order of business should be briefing the marines on the mission they are about to undertake.
And remember, you are not above the law."})

/datum/job/terragov/command/captain/after_spawn(mob/living/new_mob, mob/user, latejoin)
	. = ..()
	if(!ishuman(new_mob))
		return
	var/mob/living/carbon/human/new_human = new_mob
	var/playtime_mins = user?.client?.get_exp(title)
	if(!playtime_mins || playtime_mins < 1 )
		return
	switch(playtime_mins)
		if(0 to 1500) // starting
			new_human.wear_id.paygrade = "COL"
		if(1501 to 7500) // 25hrs
			new_human.wear_id.paygrade = "MGEN"
		if(7501 to INFINITY) //125 hrs
			new_human.wear_id.paygrade = "GEN"

/datum/job/terragov/command/captain/campaign
	outfit = /datum/outfit/job/command/captain_campaign
	multiple_outfits = FALSE

/datum/outfit/job/command/captain
	name = CAPTAIN
	jobtype = /datum/job/terragov/command/captain

	id = /obj/item/card/id/gold
	belt = /obj/item/storage/holster/belt/mateba/officer/full
	ears = /obj/item/radio/headset/mainship/mcom
	w_uniform = /obj/item/clothing/under/marine/officer/command
	shoes = /obj/item/clothing/shoes/marinechief/captain
	gloves = /obj/item/clothing/gloves/marine/techofficer/captain
	head = /obj/item/clothing/head/tgmcberet/tan
	r_store = /obj/item/storage/pouch/general/large/command
	l_store = /obj/item/hud_tablet/leadership

/datum/outfit/job/command/captain/robot
	species = SPECIES_COMBAT_ROBOT

	w_uniform = /obj/item/clothing/under/marine/robotic
	shoes = null
	gloves = null
	head = /obj/item/clothing/head/modular/robot
	r_store = /obj/item/storage/pouch/general/large/command
	l_store = /obj/item/hud_tablet/leadership

/datum/outfit/job/command/captain_campaign
	name = CAPTAIN
	jobtype = /datum/job/terragov/command/captain

	id = /obj/item/card/id/gold

//Field Commander
/datum/job/terragov/command/fieldcommander
	title = FIELD_COMMANDER
	req_admin_notify = TRUE
	paygrade = "O3"
	comm_title = "FCDR"
	total_positions = 1
	skills_type = /datum/skills/fo
	access = ALL_MARINE_ACCESS
	minimal_access = ALL_MARINE_ACCESS
	display_order = JOB_DISPLAY_ORDER_EXECUTIVE_OFFICER
	outfit = /datum/outfit/job/command/fieldcommander
	multiple_outfits = TRUE
	outfits = list(
		/datum/outfit/job/command/fieldcommander,
		/datum/outfit/job/command/fieldcommander/robot,
	)
	exp_requirements = XP_REQ_EXPERIENCED
	exp_type = EXP_TYPE_REGULAR_ALL
	job_flags = JOB_FLAG_LATEJOINABLE|JOB_FLAG_ROUNDSTARTJOINABLE|JOB_FLAG_ALLOWS_PREFS_GEAR|JOB_FLAG_PROVIDES_BANK_ACCOUNT|JOB_FLAG_ADDTOMANIFEST|JOB_FLAG_ISCOMMAND|JOB_FLAG_BOLD_NAME_ON_SELECTION|JOB_FLAG_PROVIDES_SQUAD_HUD|JOB_FLAG_CAN_SEE_ORDERS|JOB_FLAG_ALWAYS_VISIBLE_ON_MINIMAP|JOB_FLAG_LOUDER_TTS
	jobworth = list(
		/datum/job/xenomorph = LARVA_POINTS_REGULAR,
		/datum/job/terragov/squad/smartgunner = SMARTIE_POINTS_REGULAR,
		/datum/job/terragov/silicon/synthetic = SYNTH_POINTS_REGULAR,
		/datum/job/terragov/command/mech_pilot = MECH_POINTS_REGULAR,
	)
	html_description = {"
		<b>Difficulty</b>:Very Hard<br /><br />
		<b>You answer to the</b> Captain<br /><br />
		<b>Unlock Requirement</b>: Starting Role<br /><br />
		<b>Gamemode Availability</b>: Crash, Nuclear War<br /><br /><br />
		<b>Duty</b>: Lead your platoon on the field. Take advantage of the military staff and assets you will need for the mission, keep good relations between command and the marines. Assist the captain if available.
	"}
	minimap_icon = "fieldcommander"

/datum/job/terragov/command/fieldcommander/radio_help_message(mob/M)
	. = ..()
	to_chat(M, {"You are charged with overseeing the operation on the ground, and are the highest-ranked deployed marine.
Your duties are to ensure marines hold when ordered, and push when they are cowering behind barricades.
Do not ask your men to do anything you would not do side by side with them.
Make the NTC proud!"})

/datum/job/terragov/command/fieldcommander/after_spawn(mob/living/carbon/new_mob, mob/user, latejoin = FALSE)
	. = ..()
	if(!ishuman(new_mob))
		return
	SSdirection.set_leader(TRACKING_ID_MARINE_COMMANDER, new_mob)
	var/mob/living/carbon/human/new_human = new_mob
	var/playtime_mins = user?.client?.get_exp(title)
	if(!playtime_mins || playtime_mins < 1 )
		return
	switch(playtime_mins)
		if(0 to 1500) //starting
			new_human.wear_id.paygrade = "O3"
		if(1500 to 7500) // 25 hrs
			new_human.wear_id.paygrade = "MO4"
		if(7501 to INFINITY) // 125 hrs
			new_human.wear_id.paygrade = "MO5"


/datum/outfit/job/command/fieldcommander
	name = FIELD_COMMANDER
	jobtype = /datum/job/terragov/command/fieldcommander

	id = /obj/item/card/id/dogtag/fc
	belt = /obj/item/storage/holster/blade/officer/full
	ears = /obj/item/radio/headset/mainship/mcom
	w_uniform = /obj/item/clothing/under/marine/officer/exec
	wear_suit = /obj/item/clothing/suit/modular/xenonauten
	shoes = /obj/item/clothing/shoes/marine/sneakingboots
	gloves = /obj/item/clothing/gloves/marine/officer
	head = /obj/item/clothing/head/tgmcberet/fc
	r_store = /obj/item/storage/pouch/general/large/command
	l_store = /obj/item/hud_tablet/fieldcommand
	suit_store = /obj/item/storage/holster/belt/pistol/m4a3/fieldcommander

/datum/outfit/job/command/fieldcommander/robot
	species = SPECIES_COMBAT_ROBOT

	w_uniform = /obj/item/clothing/under/marine/robotic
	wear_suit = /obj/item/clothing/suit/modular/robot
	shoes = null
	gloves = null
	head = /obj/item/clothing/head/modular/robot
	r_store = /obj/item/storage/pouch/general/large/command
	l_store = /obj/item/hud_tablet/fieldcommand
	suit_store = /obj/item/storage/holster/belt/pistol/m4a3/fieldcommander

//Campaign version with specific loadout
/datum/job/terragov/command/fieldcommander/campaign
	outfit = /datum/outfit/job/command/fieldcommander_campaign
	multiple_outfits = FALSE

/datum/outfit/job/command/fieldcommander_campaign
	name = FIELD_COMMANDER
	jobtype = /datum/job/terragov/command/fieldcommander/campaign

	id = /obj/item/card/id/dogtag/fc

//CEO
/datum/job/terragov/command/ceo
	title = CHIEF_EXECUTIVE_OFFICER
	req_admin_notify = TRUE
	paygrade = "CEO"
	comm_title = "CEO"
	supervisors = "Your conscience."
	total_positions = 1
	skills_type = /datum/skills/ceo
	access = ALL_ACCESS
	minimal_access = ALL_ACCESS
	display_order = JOB_DISPLAY_ORDER_CHIEF_EXECUTIVE_OFFICER
	outfit = /datum/outfit/job/command/ceo
	exp_requirements = XP_REQ_EXPERT
	exp_type = EXP_TYPE_REGULAR_ALL
	job_flags = JOB_FLAG_LATEJOINABLE|JOB_FLAG_ROUNDSTARTJOINABLE|JOB_FLAG_ALLOWS_PREFS_GEAR|JOB_FLAG_PROVIDES_BANK_ACCOUNT|JOB_FLAG_ADDTOMANIFEST|JOB_FLAG_ISCOMMAND|JOB_FLAG_BOLD_NAME_ON_SELECTION|JOB_FLAG_PROVIDES_SQUAD_HUD|JOB_FLAG_ALWAYS_VISIBLE_ON_MINIMAP
	jobworth = list(
		/datum/job/xenomorph = LARVA_POINTS_SHIPSIDE,
		/datum/job/terragov/squad/smartgunner = SMARTIE_POINTS_REGULAR,
		/datum/job/terragov/silicon/synthetic = SYNTH_POINTS_REGULAR,
		/datum/job/terragov/command/mech_pilot = MECH_POINTS_REGULAR,
	)
	html_description = {"
		<b>Difficulty</b>: Hard<br /><br />
		<b>You answer to</b> NTC High Command<br /><br />
		<b>Unlock Requirement</b>: Being the CEO in lore.<br /><br />
		<b>Gamemode Availability</b>: All<br /><br /><br />
		<b>Duty</b>: Lead your corporation to ensure the operations go flawlessly
		"}
	minimap_icon = "CEO"

/datum/outfit/job/command/ceo
	name = CHIEF_EXECUTIVE_OFFICER
	jobtype = /datum/job/terragov/command/ceo

	id = /obj/item/card/id/gold
	belt = /obj/item/storage/holster/belt/mateba/officer/full
	ears = /obj/item/radio/headset/mainship/mcom
	w_uniform = /obj/item/clothing/under/spec_operative/armoredsuit
	shoes = /obj/item/clothing/shoes/marine/sneakingboots
	gloves = /obj/item/clothing/gloves/marine/officer
	r_store = /obj/item/storage/pouch/general/large/command
	l_store = /obj/item/hud_tablet/leadership
	back = /obj/item/storage/backpack/satchel

//Corpsec Commander
/datum/job/terragov/command/corpseccommander
	title = CORPSEC_COMMANDER
	req_admin_notify = TRUE
	paygrade = "O3"
	comm_title = "CCDR"
	total_positions = 1
	selection_color = "#80000"
	skills_type = /datum/skills/fo
	access = ALL_MARINE_ACCESS
	minimal_access = ALL_MARINE_ACCESS
	display_order = JOB_DISPLAY_ORDER_CORPSEC_COMMANDER
	outfit = /datum/outfit/job/command/corpseccommander
	exp_requirements = XP_REQ_EXPERIENCED
	exp_type = EXP_TYPE_REGULAR_ALL
	job_flags = JOB_FLAG_LATEJOINABLE|JOB_FLAG_ROUNDSTARTJOINABLE|JOB_FLAG_ALLOWS_PREFS_GEAR|JOB_FLAG_PROVIDES_BANK_ACCOUNT|JOB_FLAG_ADDTOMANIFEST|JOB_FLAG_ISCOMMAND|JOB_FLAG_BOLD_NAME_ON_SELECTION|JOB_FLAG_PROVIDES_SQUAD_HUD|JOB_FLAG_CAN_SEE_ORDERS|JOB_FLAG_ALWAYS_VISIBLE_ON_MINIMAP
	jobworth = list(
		/datum/job/xenomorph = LARVA_POINTS_SHIPSIDE,
		/datum/job/terragov/squad/smartgunner = SMARTIE_POINTS_REGULAR,
		/datum/job/terragov/silicon/synthetic = SYNTH_POINTS_REGULAR,
		/datum/job/terragov/command/mech_pilot = MECH_POINTS_REGULAR,
	)
	html_description = {"
		<b>Difficulty</b>:Very Hard<br /><br />
		<b>You answer to the</b> Captain and the CEO<br /><br />
		<b>Unlock Requirement</b>: Starting Role<br /><br />
		<b>Gamemode Availability</b>: Crash, Distress<br /><br /><br />
		<b>Duty</b>: Ensure base security, enforce the law, make sure corpsec is not acting like a legal gang.
	"}
	minimap_icon = "corpseccomm"

/datum/job/terragov/command/corpseccommander/after_spawn(mob/living/L, mob/M, latejoin)
	. = ..()
	SSdirection.set_leader(TRACKING_ID_MARINE_COMMANDER, L)


/datum/job/terragov/command/corpseccommander/radio_help_message(mob/M)
	. = ..()
	to_chat(M, {"You are a veteran, elite operative with leadership skills and experience
	trusted to keep the law and base protection within the front operations of Ninetails Corporation,
	do not let them down."})

/datum/job/terragov/command/corpseccommander/after_spawn(mob/living/carbon/new_mob, mob/user, latejoin = FALSE)
	. = ..()
	if(!ishuman(new_mob))
		return
	var/mob/living/carbon/human/new_human = new_mob
	var/playtime_mins = user?.client?.get_exp(title)
	if(!playtime_mins || playtime_mins < 1 )
		return
	switch(playtime_mins)
		if(0 to 1500) //starting
			new_human.wear_id.paygrade = "O4"
		if(1500 to 7500) // 25 hrs
			new_human.wear_id.paygrade = "MO4"
		if(7501 to INFINITY) // 125 hrs
			new_human.wear_id.paygrade = "MO5"


/datum/outfit/job/command/corpseccommander
	name = CORPSEC_COMMANDER
	jobtype = /datum/job/terragov/command/corpseccommander

	id = /obj/item/card/id/dogtag
	belt = /obj/item/storage/holster/blade/officer/full
	glasses = /obj/item/clothing/glasses/hud/security
	ears = /obj/item/radio/headset/mainship/mcom
	w_uniform = /obj/item/clothing/under/hosformalmale
	wear_suit = /obj/item/clothing/suit/armor/hos
	shoes = /obj/item/clothing/shoes/swat
	gloves = /obj/item/clothing/gloves/marine/officer
	head = /obj/item/clothing/head/beret/sec/hos
	r_store = /obj/item/storage/pouch/general/large/command
	l_store = /obj/item/hud_tablet/fieldcommand
	back = /obj/item/storage/backpack/security
	suit_store = /obj/item/storage/holster/belt/pistol/m4a3/fieldcommander

/datum/outfit/job/command/corpseccomander/robot
	species = SPECIES_COMBAT_ROBOT

	w_uniform = /obj/item/clothing/under/marine/robotic
	wear_suit = /obj/item/clothing/suit/modular/robot
	shoes = null
	gloves = null
	head = /obj/item/clothing/head/modular/robot
	r_store = /obj/item/storage/pouch/general/large/command
	l_store = /obj/item/hud_tablet/fieldcommand
	suit_store = /obj/item/storage/holster/belt/pistol/m4a3/fieldcommander

//Staff Officer
/datum/job/terragov/command/staffofficer
	title = STAFF_OFFICER
	paygrade = "O3"
	comm_title = "SO"
	total_positions = 4
	access = ALL_MARINE_ACCESS
	minimal_access = ALL_MARINE_ACCESS
	skills_type = /datum/skills/so
	display_order = JOB_DISPLAY_ORDER_STAFF_OFFICER
	outfit = /datum/outfit/job/command/staffofficer
	multiple_outfits = TRUE
	outfits = list(
		/datum/outfit/job/command/staffofficer,
		/datum/outfit/job/command/staffofficer/robot,
	)
	exp_requirements = XP_REQ_INTERMEDIATE
	exp_type = EXP_TYPE_REGULAR_ALL
	job_flags = JOB_FLAG_LATEJOINABLE|JOB_FLAG_ROUNDSTARTJOINABLE|JOB_FLAG_ALLOWS_PREFS_GEAR|JOB_FLAG_PROVIDES_BANK_ACCOUNT|JOB_FLAG_ADDTOMANIFEST|JOB_FLAG_ISCOMMAND|JOB_FLAG_PROVIDES_SQUAD_HUD|JOB_FLAG_CAN_SEE_ORDERS|JOB_FLAG_ALWAYS_VISIBLE_ON_MINIMAP
	jobworth = list(
		/datum/job/xenomorph = LARVA_POINTS_SHIPSIDE,
		/datum/job/terragov/squad/smartgunner = SMARTIE_POINTS_REGULAR,
		/datum/job/terragov/silicon/synthetic = SYNTH_POINTS_REGULAR,
		/datum/job/terragov/command/mech_pilot = MECH_POINTS_REGULAR,
	)
	html_description = {"
		<b>Difficulty</b>: Medium<br /><br />
		<b>You answer to the</b> Captain<br /><br />
		<b>Unlock Requirement</b>: Starting Role<br /><br />
		<b>Gamemode Availability</b>: Nuclear War<br /><br /><br />
		<b>Duty</b>: Take charge of one of the four squads, be their eyes and ears providing intel and additional shipside support via Orbital Bombardments.
	"}

	minimap_icon = "staffofficer"

/datum/job/terragov/command/staffofficer/radio_help_message(mob/M)
	. = ..()
	to_chat(M, {"Your job is to monitor the marines, man the CIC, and listen to your superior officers.
You are in charge of logistics and the overwatch system. You are also in line to take command after the captain."})

/datum/job/terragov/command/staffofficer/after_spawn(mob/living/carbon/new_mob, mob/user, latejoin = FALSE)
	. = ..()
	if(!ishuman(new_mob))
		return
	var/mob/living/carbon/human/new_human = new_mob
	var/playtime_mins = user?.client?.get_exp(title)
	if(!playtime_mins || playtime_mins < 1 )
		return
	switch(playtime_mins)
		if(0 to 1500) // starting
			new_human.wear_id.paygrade = "O3"
		if(1501 to 3000) // 25 hrs
			new_human.wear_id.paygrade = "O4"
		if(3001 to INFINITY) // 50 hrs
			new_human.wear_id.paygrade = "O5"

/datum/job/terragov/command/staffofficer/campaign
	outfit = /datum/outfit/job/command/staffofficer_campaign
	multiple_outfits = FALSE

/datum/outfit/job/command/staffofficer
	name = STAFF_OFFICER
	jobtype = /datum/job/terragov/command/staffofficer

	id = /obj/item/card/id/silver
	belt = /obj/item/storage/holster/belt/pistol/smart_pistol/full
	ears = /obj/item/radio/headset/mainship/mcom
	w_uniform = /obj/item/clothing/under/marine/officer/bridge
	shoes = /obj/item/clothing/shoes/marine/full
	head = /obj/item/clothing/head/tgmccap/ro
	r_store = /obj/item/storage/pouch/general/large
	l_store = /obj/item/binoculars/tactical


/datum/outfit/job/command/staffofficer/robot
	species = SPECIES_COMBAT_ROBOT

	w_uniform = /obj/item/clothing/under/marine/robotic
	shoes = null
	gloves = null
	head = /obj/item/clothing/head/modular/robot
	r_store = /obj/item/storage/pouch/general/large
	l_store = /obj/item/binoculars/tactical

/datum/outfit/job/command/staffofficer_campaign
	name = STAFF_OFFICER
	jobtype = /datum/job/terragov/command/staffofficer

	id = /obj/item/card/id/silver

//Command Doll
/datum/job/terragov/command/commanddoll
	title = COMMAND_DOLL
	paygrade = "O1"
	comm_title = "CDoll"
	total_positions = 4
	access = ALL_MARINE_ACCESS
	minimal_access = ALL_MARINE_ACCESS
	display_order = JOB_DISPLAY_ORDER_STAFF_OFFICER
	skills_type = /datum/skills/specialist/commanddoll
	outfit = /datum/outfit/job/command/commanddoll
	multiple_outfits = TRUE
	outfits = list(
		/datum/outfit/job/command/commanddoll,
		/datum/outfit/job/command/commanddoll/robot,
	)
	exp_requirements = XP_REQ_INTERMEDIATE
	exp_type = EXP_TYPE_REGULAR_ALL
	job_flags = JOB_FLAG_LATEJOINABLE|JOB_FLAG_ROUNDSTARTJOINABLE|JOB_FLAG_ALLOWS_PREFS_GEAR|JOB_FLAG_PROVIDES_BANK_ACCOUNT|JOB_FLAG_ADDTOMANIFEST|JOB_FLAG_ISCOMMAND|JOB_FLAG_PROVIDES_SQUAD_HUD|JOB_FLAG_CAN_SEE_ORDERS|JOB_FLAG_ALWAYS_VISIBLE_ON_MINIMAP
	jobworth = list(
		/datum/job/xenomorph = LARVA_POINTS_SHIPSIDE,
		/datum/job/terragov/squad/smartgunner = SMARTIE_POINTS_REGULAR,
		/datum/job/terragov/silicon/synthetic = SYNTH_POINTS_REGULAR,
		/datum/job/terragov/command/mech_pilot = MECH_POINTS_REGULAR,
	)
	minimap_icon = "commanddoll"

/datum/job/terragov/command/commanddoll/radio_help_message(mob/M)
	. = ..()
	to_chat(M, {"\nYou are a Command Doll, fancy name for a premium free-use slut and an elite bodyguard hired by the corporation to serve the command staff in any way possible, mostly sexual...
	do your job and try not to stain the bridge too much. You are the lowest command, surprising you are even command but you can lead if all the other command mysteriously died or something...
	Though it also means you failed your job to be a bodyguard."})

/datum/job/terragov/command/commanddoll/after_spawn(mob/living/carbon/new_mob, mob/user, latejoin = FALSE)
	. = ..()
	if(!ishuman(new_mob))
		return
	var/mob/living/carbon/human/new_human = new_mob
	var/playtime_mins = user?.client?.get_exp(title)
	if(!playtime_mins || playtime_mins < 1 )
		return
	switch(playtime_mins)
		if(0 to 1000) // starting
			new_human.wear_id.paygrade = "O2"
		if(1001 to 2500) // 25 hrs
			new_human.wear_id.paygrade = "O3"
		if(2501 to INFINITY) // 50 hrs
			new_human.wear_id.paygrade = "O4"
/datum/outfit/job/command/commanddoll
	name = COMMAND_DOLL
	jobtype = /datum/job/terragov/command/commanddoll

	id = /obj/item/card/id/card/silver/commanddoll
	ears = /obj/item/radio/headset/mainship/mcom
	w_uniform = /obj/item/clothing/under/spec_operative/tback
	shoes = /obj/item/clothing/shoes/marine/sneakingboots
	r_store = /obj/item/storage/pouch/general/large


/datum/outfit/job/command/commanddoll/robot
	species = SPECIES_COMBAT_ROBOT

	w_uniform = /obj/item/clothing/under/marine/robotic
	shoes = null
	gloves = null
	head = /obj/item/clothing/head/modular/robot
	r_store = /obj/item/storage/pouch/general/large

//Pilot Officer
/datum/job/terragov/command/pilot
	title = PILOT_OFFICER
	paygrade = "WO"
	comm_title = "PO"
	total_positions = 2
	access = list(ACCESS_MARINE_BRIDGE, ACCESS_MARINE_DROPSHIP, ACCESS_MARINE_PILOT, ACCESS_MARINE_LOGISTICS, ACCESS_MARINE_CARGO, ACCESS_MARINE_RO, ACCESS_MARINE_MEDBAY)
	minimal_access = list(ACCESS_MARINE_BRIDGE, ACCESS_MARINE_DROPSHIP, ACCESS_MARINE_PILOT, ACCESS_MARINE_LOGISTICS, ACCESS_MARINE_CARGO, ACCESS_MARINE_RO, ACCESS_MARINE_MEDBAY)
	skills_type = /datum/skills/pilot
	display_order = JOB_DISPLAY_ORDER_PILOT_OFFICER
	outfit = /datum/outfit/job/command/pilot
	exp_requirements = XP_REQ_EXPERT
	exp_type = EXP_TYPE_REGULAR_ALL
	job_flags = JOB_FLAG_LATEJOINABLE|JOB_FLAG_ROUNDSTARTJOINABLE|JOB_FLAG_ALLOWS_PREFS_GEAR|JOB_FLAG_PROVIDES_BANK_ACCOUNT|JOB_FLAG_ADDTOMANIFEST|JOB_FLAG_PROVIDES_SQUAD_HUD
	jobworth = list(
		/datum/job/xenomorph = LARVA_POINTS_SHIPSIDE_STRONG,
		/datum/job/terragov/squad/smartgunner = SMARTIE_POINTS_REGULAR,
		/datum/job/terragov/silicon/synthetic = SYNTH_POINTS_REGULAR,
		/datum/job/terragov/command/mech_pilot = MECH_POINTS_REGULAR,
	)
	html_description = {"
		<b>Difficulty</b>: Medium<br /><br />
		<b>You answer to the</b> acting Command Staff<br /><br />
		<b>Unlock Requirement</b>: Starting Role<br /><br />
		<b>Gamemode Availability</b>: Nuclear War<br /><br /><br />
		<b>Duty</b>: Choose between the Condor, a modular attack aircraft that provides close air support with a variety of weapons ranging from the inbuilt gatling to wing mounted rockets; or the Tadpole, a versatile dropship capable of fulfilling roles ranging from ambulance to mobile bunker.
	"}
	minimap_icon = "pilot"

/datum/job/terragov/command/pilot/after_spawn(mob/living/carbon/new_mob, mob/user, latejoin = FALSE)
	. = ..()
	if(!ishuman(new_mob))
		return
	var/mob/living/carbon/human/new_human = new_mob
	var/playtime_mins = user?.client?.get_exp(title)
	if(!playtime_mins || playtime_mins < 1 )
		return
	switch(playtime_mins)
		if(0 to 600) // starting
			new_human.wear_id.paygrade = "WO"
		if(601 to 3000) // 10 hrs
			new_human.wear_id.paygrade = "CWO"
		if(3001 to 6000) // 50 hrs
			new_human.wear_id.paygrade = "O1"
		if(6001 to INFINITY) // 100 hrs
			new_human.wear_id.paygrade = "O2"

/datum/job/terragov/command/pilot/radio_help_message(mob/M)
	. = ..()
	to_chat(M, {"Your job is to support marines with either close air support via the Condor, or mobile dropship support with the Tadpole.
While you are in charge of all aerial crafts the Alamo does not require supervision outside of turning automatic mode on or off at crucial times, and you are expected to choose between the Condor and Tadpole.
Though you are a warrant officer, your authority is limited to the dropship and your chosen aerial craft, where you have authority over the enlisted personnel.
"})


/datum/outfit/job/command/pilot
	name = PILOT_OFFICER
	jobtype = /datum/job/terragov/command/pilot

	id = /obj/item/card/id/silver
	belt = /obj/item/storage/holster/belt/pistol/m4a3/vp70
	ears = /obj/item/radio/headset/mainship/mcom
	w_uniform = /obj/item/clothing/under/marine/officer/pilot
	wear_suit = /obj/item/clothing/suit/modular/xenonauten/pilot
	shoes = /obj/item/clothing/shoes/marine/full
	gloves = /obj/item/clothing/gloves/insulated
	glasses = /obj/item/clothing/glasses/sunglasses/aviator
	head = /obj/item/clothing/head/helmet/marine/pilot
	r_store = /obj/item/storage/pouch/general/large
	l_store = /obj/item/hud_tablet/pilot

//Mech pilot
/datum/job/terragov/command/mech_pilot
	title = MECH_PILOT
	req_admin_notify = TRUE
	paygrade = "WO"
	comm_title = "MCH"
	total_positions = 0
	skills_type = /datum/skills/mech_pilot
	access = list(ACCESS_MARINE_BRIDGE, ACCESS_MARINE_DROPSHIP, ACCESS_MARINE_PILOT, ACCESS_MARINE_MECH, ACCESS_MARINE_LOGISTICS, ACCESS_MARINE_CARGO, ACCESS_MARINE_RO, ACCESS_MARINE_MEDBAY)
	minimal_access = list(ACCESS_MARINE_BRIDGE, ACCESS_MARINE_DROPSHIP, ACCESS_MARINE_PILOT, ACCESS_MARINE_MECH, ACCESS_MARINE_LOGISTICS, ACCESS_MARINE_CARGO, ACCESS_MARINE_RO, ACCESS_MARINE_MEDBAY)
	display_order = JOB_DISPLAY_ORDER_MECH_PILOT
	outfit = /datum/outfit/job/command/mech_pilot
	exp_requirements = XP_REQ_EXPERT
	exp_type = EXP_TYPE_REGULAR_ALL
	job_flags = JOB_FLAG_LATEJOINABLE|JOB_FLAG_ROUNDSTARTJOINABLE|JOB_FLAG_ALLOWS_PREFS_GEAR|JOB_FLAG_PROVIDES_BANK_ACCOUNT|JOB_FLAG_ADDTOMANIFEST|JOB_FLAG_PROVIDES_SQUAD_HUD|JOB_FLAG_CAN_SEE_ORDERS|JOB_FLAG_ALWAYS_VISIBLE_ON_MINIMAP
	jobworth = list(
		/datum/job/xenomorph = LARVA_POINTS_REGULAR,
		/datum/job/terragov/squad/smartgunner = SMARTIE_POINTS_REGULAR,
	)
	html_description = {"
		<b>Difficulty</b>:Very Hard<br /><br />
		<b>You answer to the</b> acting Command Staff<br /><br />
		<b>Unlock Requirement</b>: Starting Role<br /><br />
		<b>Gamemode Availability</b>: Nuclear War<br /><br /><br />
		<b>Duty</b>: Act as the spearhead of the operation
	"}
	minimap_icon = "mech_pilot"

/datum/job/terragov/command/mech_pilot/radio_help_message(mob/M)
	. = ..()
	to_chat(M, {"\nYou are the operator of a very expensive and valuable Mech, and are trained and expected to use it in the field of combat.
You can serve your Division in a variety of roles, so choose carefully."})

/datum/job/terragov/command/mech_pilot/after_spawn(mob/living/carbon/new_mob, mob/user, latejoin = FALSE)
	. = ..()
	if(!ishuman(new_mob))
		return
	var/mob/living/carbon/human/new_human = new_mob
	var/playtime_mins = user?.client?.get_exp(title)
	if(!playtime_mins || playtime_mins < 1 )
		return
	switch(playtime_mins)
		if(0 to 600) // starting
			new_human.wear_id.paygrade = "WO"
		if(601 to 3000) // 10 hrs
			new_human.wear_id.paygrade = "CWO"
		if(3001 to 6000) // 50 hrs
			new_human.wear_id.paygrade = "O1"
		if(6001 to INFINITY) // 100 hrs
			new_human.wear_id.paygrade = "O2"

/datum/outfit/job/command/mech_pilot
	name = MECH_PILOT
	jobtype = /datum/job/terragov/command/mech_pilot

	id = /obj/item/card/id/dogtag
	belt = /obj/item/storage/belt/utility/full
	glasses = /obj/item/clothing/glasses/welding
	ears = /obj/item/radio/headset/mainship/mcom
	w_uniform = /obj/item/clothing/under/marine/officer/mech
	wear_suit = /obj/item/clothing/suit/storage/marine/mech_pilot
	head = /obj/item/clothing/head/helmet/marine/mech_pilot
	shoes = /obj/item/clothing/shoes/marine/full
	gloves = /obj/item/clothing/gloves/marine

/datum/job/terragov/engineering
	job_category = JOB_CAT_ENGINEERING
	selection_color = "#fff5cc"
	supervisors = "the acting captain"
	exp_type_department = EXP_TYPE_ENGINEERING


//Chief Ship Engineer
/datum/job/terragov/engineering/chief
	title = CHIEF_SHIP_ENGINEER
	paygrade = "O2"
	comm_title = "CSE"
	selection_color = "#ffeeaa"
	total_positions = 1
	access = list(ACCESS_MARINE_CE, ACCESS_MARINE_ENGINEERING, ACCESS_MARINE_BRIDGE, ACCESS_CIVILIAN_ENGINEERING, ACCESS_MARINE_CARGO, ACCESS_MARINE_DROPSHIP, ACCESS_MARINE_LOGISTICS, ACCESS_MARINE_PREP, ACCESS_MARINE_RO, ACCESS_MARINE_MEDBAY)
	minimal_access = list(ACCESS_MARINE_CE, ACCESS_MARINE_ENGINEERING, ACCESS_MARINE_BRIDGE, ACCESS_CIVILIAN_ENGINEERING, ACCESS_MARINE_CARGO, ACCESS_MARINE_DROPSHIP, ACCESS_MARINE_LOGISTICS, ACCESS_MARINE_PREP, ACCESS_MARINE_RO, ACCESS_MARINE_MEDBAY)
	skills_type = /datum/skills/ce
	display_order = JOB_DISPLAY_ORDER_CHIEF_ENGINEER
	outfit = /datum/outfit/job/engineering/chief
	exp_requirements = XP_REQ_EXPERIENCED
	exp_type = EXP_TYPE_REGULAR_ALL
	job_flags = JOB_FLAG_LATEJOINABLE|JOB_FLAG_ROUNDSTARTJOINABLE|JOB_FLAG_ALLOWS_PREFS_GEAR|JOB_FLAG_PROVIDES_BANK_ACCOUNT|JOB_FLAG_ADDTOMANIFEST|JOB_FLAG_ISCOMMAND|JOB_FLAG_BOLD_NAME_ON_SELECTION|JOB_FLAG_PROVIDES_SQUAD_HUD
	jobworth = list(
		/datum/job/xenomorph = LARVA_POINTS_SHIPSIDE,
		/datum/job/terragov/squad/smartgunner = SMARTIE_POINTS_REGULAR,
		/datum/job/terragov/silicon/synthetic = SYNTH_POINTS_REGULAR,
		/datum/job/terragov/command/mech_pilot = MECH_POINTS_REGULAR,
	)
	html_description = {"
		<b>Difficulty</b>: Hard<br /><br />
		<b>You answer to the</b> acting Command Staff<br /><br />
		<b>Unlock Requirement</b>: Starting Role<br /><br />
		<b>Gamemode Availability</b>: Nuclear War<br /><br /><br />
		<b>Duty</b>: Supervise the engineers and technicians on duty. Overview the ship’s engine. Teach what’s right and what’s wrong about engineering, cut corners and find places in any FOB that can easily be destroyed.
	"}
	minimap_icon = "cse"

/datum/job/terragov/engineering/chief/after_spawn(mob/living/carbon/new_mob, mob/user, latejoin = FALSE)
	. = ..()
	if(!ishuman(new_mob))
		return
	var/mob/living/carbon/human/new_human = new_mob
	var/playtime_mins = user?.client?.get_exp(title)
	if(!playtime_mins || playtime_mins < 1 )
		return
	switch(playtime_mins)
		if(0 to 1500) // starting
			new_human.wear_id.paygrade = "O2"
		if(1501 to 6000) // 25 hrs
			new_human.wear_id.paygrade = "O3"
		if(6001 to INFINITY) // 100 hrs
			new_human.wear_id.paygrade = "O4"

/datum/job/terragov/engineering/chief/radio_help_message(mob/M)
	. = ..()
	to_chat(M, {"Your job is to maintain the ship's engine and keep everything running.
If you have no idea how to set up the engine, or it's your first time, <b>mentorhelp</b> so that a mentor can assist you.
You are also next in the chain of command, should the bridge crew fall in the line of duty."})


/datum/outfit/job/engineering/chief
	name = CHIEF_SHIP_ENGINEER
	jobtype = /datum/job/terragov/engineering/chief

	id = /obj/item/card/id/silver
	belt = /obj/item/storage/belt/utility/full
	ears = /obj/item/radio/headset/mainship/mcom
	w_uniform = /obj/item/clothing/under/marine/officer/ce
	wear_suit = /obj/item/clothing/suit/storage/marine/officer/req
	shoes = /obj/item/clothing/shoes/marine/full
	glasses = /obj/item/clothing/glasses/welding/superior
	gloves = /obj/item/clothing/gloves/insulated
	head = /obj/item/clothing/head/beret/marine/techofficer
	r_store = /obj/item/storage/pouch/construction
	back = /obj/item/storage/backpack/marine/engineerpack

/datum/outfit/job/engineering/chief/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	H.equip_to_slot_or_hand(new /obj/item/stack/sheet/metal/large_stack, SLOT_IN_R_POUCH)
	H.equip_to_slot_or_hand(new /obj/item/stack/sheet/plasteel/large_stack, SLOT_IN_R_POUCH)
	H.equip_to_slot_or_hand(new /obj/item/stack/sandbags/large_stack, SLOT_IN_R_POUCH)
	H.equip_to_slot_or_hand(new /obj/item/stack/barbed_wire/full, SLOT_IN_R_POUCH)

//Ship Engineer
/datum/job/terragov/engineering/tech
	title = SHIP_TECH
	comm_title = "ST"
	paygrade = "PO3"
	total_positions = 5
	supervisors = "the chief ship engineer and the requisitions officer"
	access = list(ACCESS_MARINE_ENGINEERING, ACCESS_MARINE_PREP, ACCESS_MARINE_MEDBAY, ACCESS_MARINE_DROPSHIP, ACCESS_MARINE_CARGO, ACCESS_CIVILIAN_ENGINEERING)
	minimal_access = list(ACCESS_MARINE_ENGINEERING, ACCESS_MARINE_PREP, ACCESS_MARINE_MEDBAY, ACCESS_MARINE_DROPSHIP, ACCESS_MARINE_CARGO, ACCESS_CIVILIAN_ENGINEERING)
	skills_type = /datum/skills/st
	display_order = JOB_DISPLAY_ORDER_SHIP_TECH
	outfit = /datum/outfit/job/engineering/tech
	job_flags = JOB_FLAG_LATEJOINABLE|JOB_FLAG_ROUNDSTARTJOINABLE|JOB_FLAG_ALLOWS_PREFS_GEAR|JOB_FLAG_PROVIDES_BANK_ACCOUNT|JOB_FLAG_ADDTOMANIFEST|JOB_FLAG_PROVIDES_SQUAD_HUD
	jobworth = list(
		/datum/job/xenomorph = LARVA_POINTS_SHIPSIDE,
		/datum/job/terragov/squad/smartgunner = SMARTIE_POINTS_REGULAR,
		/datum/job/terragov/silicon/synthetic = SYNTH_POINTS_REGULAR,
		/datum/job/terragov/command/mech_pilot = MECH_POINTS_REGULAR,
	)
	html_description = {"
		<b>Difficulty</b>: Medium<br /><br />
		<b>You answer to the</b> Chief Ship Engineer<br /><br />
		<b>Unlock Requirement</b>: Starting Role<br /><br />
		<b>Gamemode Availability</b>: Nuclear War<br /><br /><br />
		<b>Duty</b>: Maintain the ship, be in charge of the engines. Be the secondary engineer to a forward operating base, prepare the shipside defenses if needed. Help the Pilot Officer in preparing the dropship.
	"}
	minimap_icon = "st"

/datum/job/terragov/engineering/tech/after_spawn(mob/living/carbon/new_mob, mob/user, latejoin = FALSE)
	. = ..()
	if(!ishuman(new_mob))
		return
	var/mob/living/carbon/human/new_human = new_mob
	var/playtime_mins = user?.client?.get_exp(title)
	if(!playtime_mins || playtime_mins < 1 )
		return
	switch(playtime_mins)
		if(0 to 600) // starting
			new_human.wear_id.paygrade = "PO3"
		if(601 to 3000) // 10 hrs
			new_human.wear_id.paygrade = "PO2"
		if(3001 to 6000) // 50 hrs
			new_human.wear_id.paygrade = "PO1"
		if(6001 to INFINITY) // 100 hrs
			new_human.wear_id.paygrade = "CPO"

/datum/job/terragov/engineering/tech/radio_help_message(mob/M)
	. = ..()
	to_chat(M, {"Your job is to make sure the ship is operational, you should firstly focus on manning the
requisitions line and later on to be ready to send supplies for marines who are groundside."})


/datum/outfit/job/engineering/tech
	name = SHIP_TECH
	jobtype = /datum/job/terragov/engineering/tech

	id = /obj/item/card/id/silver
	belt = /obj/item/storage/belt/utility/full
	ears = /obj/item/radio/headset/mainship/st
	w_uniform = /obj/item/clothing/under/marine/officer/engi
	wear_suit = /obj/item/clothing/suit/storage/marine/ship_tech
	shoes = /obj/item/clothing/shoes/marine/full
	gloves = /obj/item/clothing/gloves/insulated
	glasses = /obj/item/clothing/glasses/welding/flipped
	head = /obj/item/clothing/head/tgmccap/req
	r_store = /obj/item/storage/pouch/general/medium
	back = /obj/item/storage/backpack/marine/engineerpack

/datum/job/terragov/requisitions
	job_category = JOB_CAT_REQUISITIONS
	selection_color = "#BAAFD9"
	supervisors = "the acting captain"
	exp_type_department = EXP_TYPE_REQUISITIONS


//Requisitions Officer
/datum/job/terragov/requisitions/officer
	title = REQUISITIONS_OFFICER
	req_admin_notify = TRUE
	paygrade = "CPO"
	comm_title = "RO"
	selection_color = "#9990B2"
	total_positions = 1
	access = list(ACCESS_MARINE_DROPSHIP, ACCESS_MARINE_CARGO, ACCESS_MARINE_RO, ACCESS_MARINE_BRIDGE, ACCESS_MARINE_PREP, ACCESS_MARINE_ALPHA, ACCESS_MARINE_BRAVO, ACCESS_MARINE_CHARLIE, ACCESS_MARINE_DELTA)
	minimal_access = list(ACCESS_MARINE_CARGO, ACCESS_MARINE_RO, ACCESS_MARINE_BRIDGE, ACCESS_MARINE_PREP, ACCESS_MARINE_ALPHA, ACCESS_MARINE_BRAVO, ACCESS_MARINE_CHARLIE, ACCESS_MARINE_DELTA, ACCESS_MARINE_MEDBAY, ACCESS_MARINE_DROPSHIP, ACCESS_MARINE_LOGISTICS)
	skills_type = /datum/skills/ro
	display_order = JOB_DISPLAY_ORDER_REQUISITIONS_OFFICER
	outfit = /datum/outfit/job/requisitions/officer
	exp_requirements = XP_REQ_UNSEASONED
	exp_type = EXP_TYPE_REGULAR_ALL
	job_flags = JOB_FLAG_LATEJOINABLE|JOB_FLAG_ROUNDSTARTJOINABLE|JOB_FLAG_ALLOWS_PREFS_GEAR|JOB_FLAG_PROVIDES_BANK_ACCOUNT|JOB_FLAG_ADDTOMANIFEST|JOB_FLAG_ISCOMMAND|JOB_FLAG_BOLD_NAME_ON_SELECTION|JOB_FLAG_PROVIDES_SQUAD_HUD
	jobworth = list(
		/datum/job/xenomorph = LARVA_POINTS_SHIPSIDE,
		/datum/job/terragov/squad/smartgunner = SMARTIE_POINTS_REGULAR,
		/datum/job/terragov/silicon/synthetic = SYNTH_POINTS_REGULAR,
		/datum/job/terragov/command/mech_pilot = MECH_POINTS_REGULAR,
	)
	html_description = {"
		<b>Difficulty</b>: Medium<br /><br />
		<b>You answer to the</b> acting Command Staff<br /><br />
		<b>Unlock Requirement</b>: Starting Role<br /><br />
		<b>Gamemode Availability</b>: Nuclear War<br /><br /><br />
		Requisition supplies to the battlefield. Ensure that the marines are reparing miners for more points. Supply the marines with deluxe equipment to ensure success.
	"}
	minimap_icon = "requisition"


/datum/job/terragov/requisitions/officer/after_spawn(mob/living/carbon/new_mob, mob/user, latejoin = FALSE)
	. = ..()
	if(!ishuman(new_mob))
		return
	var/mob/living/carbon/human/new_human = new_mob
	var/playtime_mins = user?.client?.get_exp(title)
	if(!playtime_mins || playtime_mins < 1 )
		return
	switch(playtime_mins)
		if(0 to 600) // starting
			new_human.wear_id.paygrade = "CPO"
		if(601 to 1500) // 10 hrs
			new_human.wear_id.paygrade = "WO"
		if(1501 to 6000) // 50 hrs
			new_human.wear_id.paygrade = "CWO"
		if(6001 to INFINITY) // 100 hrs
			new_human.wear_id.paygrade = "O1"

/datum/job/terragov/requisitions/officer/radio_help_message(mob/M)
	. = ..()
	to_chat(M, {"Your job is to dispense supplies to the marines, including weapon attachments.
While you may request paperwork for supplies, do not go out of your way to screw with marines, unless you want to get deposed.
A happy ship is a well-functioning ship."})


/datum/outfit/job/requisitions/officer
	name = REQUISITIONS_OFFICER
	jobtype = /datum/job/terragov/requisitions/officer

	id = /obj/item/card/id/silver
	belt = /obj/item/storage/holster/belt/m44/full
	ears = /obj/item/radio/headset/mainship/mcom
	w_uniform = /obj/item/clothing/under/marine/officer/ro_suit
	wear_suit = /obj/item/clothing/suit/storage/marine/officer/req
	suit_store = /obj/item/weapon/gun/energy/taser
	shoes = /obj/item/clothing/shoes/marine/full
	gloves = /obj/item/clothing/gloves/insulated
	head = /obj/item/clothing/head/tgmccap/req
	r_store = /obj/item/storage/pouch/general/large

/datum/job/terragov/medical
	job_category = JOB_CAT_MEDICAL
	selection_color = "#BBFFBB"
	exp_type_department = EXP_TYPE_MEDICAL


/datum/job/terragov/medical/professor
	title = CHIEF_MEDICAL_OFFICER
	req_admin_notify = TRUE
	comm_title = "CMO"
	paygrade = "CHO"
	total_positions = 1
	supervisors = "the acting captain"
	selection_color = "#99FF99"
	access = list(ACCESS_MARINE_DROPSHIP, ACCESS_MARINE_CMO, ACCESS_MARINE_MEDBAY, ACCESS_MARINE_RESEARCH, ACCESS_MARINE_BRIDGE, ACCESS_MARINE_CHEMISTRY)
	minimal_access = list(ACCESS_MARINE_CMO, ACCESS_MARINE_MEDBAY, ACCESS_MARINE_RESEARCH, ACCESS_MARINE_BRIDGE, ACCESS_MARINE_CHEMISTRY, ACCESS_MARINE_CARGO, ACCESS_MARINE_DROPSHIP, ACCESS_MARINE_LOGISTICS)
	skills_type = /datum/skills/cmo
	display_order = JOB_DISPLAY_ORDER_CHIEF_MEDICAL_OFFICER
	outfit = /datum/outfit/job/medical/professor
	multiple_outfits = TRUE
	outfits = list(
		/datum/outfit/job/medical/professor,
		/datum/outfit/job/medical/professor/robot,
	)
	exp_requirements = XP_REQ_EXPERIENCED
	exp_type = EXP_TYPE_REGULAR_ALL
	job_flags = JOB_FLAG_LATEJOINABLE|JOB_FLAG_ROUNDSTARTJOINABLE|JOB_FLAG_ALLOWS_PREFS_GEAR|JOB_FLAG_PROVIDES_BANK_ACCOUNT|JOB_FLAG_ADDTOMANIFEST|JOB_FLAG_ISCOMMAND|JOB_FLAG_BOLD_NAME_ON_SELECTION|JOB_FLAG_PROVIDES_SQUAD_HUD
	jobworth = list(
		/datum/job/xenomorph = LARVA_POINTS_SHIPSIDE,
		/datum/job/terragov/squad/smartgunner = SMARTIE_POINTS_REGULAR,
		/datum/job/terragov/silicon/synthetic = SYNTH_POINTS_REGULAR,
		/datum/job/terragov/command/mech_pilot = MECH_POINTS_REGULAR,
	)
	html_description = {"
		<b>Difficulty</b>: Hard<br /><br />
		<b>You answer to the</b> acting Command Staff<br /><br />
		<b>Unlock Requirement</b>: Starting Role<br /><br />
		<b>Gamemode Availability</b>: Crash, Nuclear War<br /><br /><br />
		<b>Duty</b>: Communicate and lead your fellow medical staff (if available), supervise the medical department. Coordinate and teach fellow medical staff and corpsmen what they’re doing for treating an injury. Be the sole doctor in the Canterbury.
	"}
	minimap_icon = "chief_medical"


/datum/job/terragov/medical/professor/radio_help_message(mob/M)
	. = ..()
	to_chat(M, {"You are the chief medical officer aboard the [SSmapping.configs[SHIP_MAP].map_name] and supervisor to the medical department.
You have final authority over the medical department, medications, and treatments.
Make sure that the doctors and nurses are doing their jobs and keeping the marines healthy and strong."})

/datum/job/terragov/medical/professor/after_spawn(mob/living/carbon/new_mob, mob/user, latejoin = FALSE)
	. = ..()
	if(!ishuman(new_mob))
		return
	var/mob/living/carbon/human/new_human = new_mob
	var/playtime_mins = user?.client?.get_exp(title)
	if(!playtime_mins || playtime_mins < 1 )
		return
	switch(playtime_mins)
		if(0 to 3000) // starting
			new_human.wear_id.paygrade = "CHO"
		if(3001 to INFINITY) // 50 hrs
			new_human.wear_id.paygrade = "CMO"

/datum/outfit/job/medical/professor
	name = CHIEF_MEDICAL_OFFICER
	jobtype = /datum/job/terragov/medical/professor

	id = /obj/item/card/id
	belt = /obj/item/storage/belt/rig/medical
	ears = /obj/item/radio/headset/mainship/mcom
	w_uniform = /obj/item/clothing/under/rank/medical/blue
	wear_suit = /obj/item/clothing/suit/storage/labcoat/cmo
	shoes = /obj/item/clothing/shoes/white
	gloves = /obj/item/clothing/gloves/latex
	glasses = /obj/item/clothing/glasses/hud/health
	mask = /obj/item/clothing/mask/surgical
	head = /obj/item/clothing/head/cmo
	r_store = /obj/item/storage/pouch/surgery
	l_store = /obj/item/storage/pouch/medkit/medic


/datum/outfit/job/medical/professor/robot
	species = SPECIES_COMBAT_ROBOT

	w_uniform = /obj/item/clothing/under/marine/robotic
	shoes = null
	gloves = null

/datum/outfit/job/medical/professor/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	H.equip_to_slot_or_hand(new /obj/item/tweezers, SLOT_IN_R_POUCH)
	H.equip_to_slot_or_hand(new /obj/item/reagent_containers/glass/bottle/lemoline/doctor, SLOT_S_STORE)

//Medical Officer
/datum/job/terragov/medical/medicalofficer
	title = MEDICAL_DOCTOR
	comm_title = "MD"
	paygrade = "RES"
	total_positions = 4
	supervisors = "the chief medical officer"
	access = list(ACCESS_MARINE_MEDBAY, ACCESS_MARINE_CHEMISTRY)
	minimal_access = list(ACCESS_MARINE_MEDBAY, ACCESS_MARINE_CHEMISTRY, ACCESS_MARINE_CARGO, ACCESS_MARINE_DROPSHIP)
	skills_type = /datum/skills/doctor
	display_order = JOB_DISPLAY_ORDER_DOCTOR
	outfit = /datum/outfit/job/medical/medicalofficer
	multiple_outfits = TRUE
	outfits = list(
		/datum/outfit/job/medical/medicalofficer,
		/datum/outfit/job/medical/medicalofficer/robot,
	)
	job_flags = JOB_FLAG_LATEJOINABLE|JOB_FLAG_ROUNDSTARTJOINABLE|JOB_FLAG_ALLOWS_PREFS_GEAR|JOB_FLAG_PROVIDES_BANK_ACCOUNT|JOB_FLAG_ADDTOMANIFEST|JOB_FLAG_PROVIDES_SQUAD_HUD
	jobworth = list(
		/datum/job/xenomorph = LARVA_POINTS_SHIPSIDE,
		/datum/job/terragov/squad/smartgunner = SMARTIE_POINTS_REGULAR,
		/datum/job/terragov/silicon/synthetic = SYNTH_POINTS_REGULAR,
		/datum/job/terragov/command/mech_pilot = MECH_POINTS_REGULAR,
	)
	html_description = {"
		<b>Difficulty</b>: Medium<br /><br />
		<b>You answer to the</b> Chief Medical Officer<br /><br />
		<b>Unlock Requirement</b>: Starting Role<br /><br />
		<b>Gamemode Availability</b>: Nuclear War<br /><br /><br />
		<b>Duty</b>: Tend severely wounded patients to your aid in the form of surgery, repair broken bones and damaged organs, fix internal bleeding and prevent the birth of a xenomorph larva. Develop superior healing medicines.
	"}
	minimap_icon = "medical"

/datum/job/terragov/medical/medicalofficer/after_spawn(mob/living/carbon/new_mob, mob/user, latejoin = FALSE)
	. = ..()
	if(!ishuman(new_mob))
		return
	var/mob/living/carbon/human/new_human = new_mob
	var/playtime_mins = user?.client?.get_exp(title)
	if(!playtime_mins || playtime_mins < 1 )
		return
	switch(playtime_mins)
		if(0 to 3000) // starting
			new_human.wear_id.paygrade = "RES"
		if(3001 to INFINITY) // 50 hrs
			new_human.wear_id.paygrade = "MD"

/datum/job/terragov/medical/medicalofficer/radio_help_message(mob/M)
	. = ..()
	to_chat(M, {"You are a doctor stationed aboard the [SSmapping.configs[SHIP_MAP].map_name].
You are tasked with keeping the marines healthy and strong, usually in the form of surgery.
You are also an expert when it comes to medication and treatment. If you do not know what you are doing, <b>mentorhelp</b> so a mentor can assist you."})


/datum/outfit/job/medical/medicalofficer
	name = MEDICAL_DOCTOR
	jobtype = /datum/job/terragov/medical/medicalofficer

	id = /obj/item/card/id
	belt = /obj/item/storage/belt/rig/medical
	ears = /obj/item/radio/headset/mainship/doc
	w_uniform = /obj/item/clothing/under/rank/medical/purple
	wear_suit = /obj/item/clothing/suit/storage/labcoat
	shoes = /obj/item/clothing/shoes/white
	gloves = /obj/item/clothing/gloves/latex
	glasses = /obj/item/clothing/glasses/hud/health
	mask = /obj/item/clothing/mask/surgical
	head = /obj/item/clothing/head/surgery/purple
	r_store = /obj/item/storage/pouch/surgery
	l_store = /obj/item/storage/pouch/medkit/medic


/datum/outfit/job/medical/medicalofficer/robot
	species = SPECIES_COMBAT_ROBOT
	jobtype = /datum/job/terragov/medical/medicalofficer

	w_uniform = /obj/item/clothing/under/marine/robotic
	shoes = null
	gloves = null

/datum/outfit/job/medical/medicalofficer/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	H.equip_to_slot_or_hand(new /obj/item/tweezers, SLOT_IN_R_POUCH)
	H.equip_to_slot_or_hand(new /obj/item/reagent_containers/glass/bottle/lemoline/doctor, SLOT_S_STORE)


//Researcher
/datum/job/terragov/medical/researcher
	title = MEDICAL_RESEARCHER
	comm_title = "Rsr"
	paygrade = "CD"
	total_positions = 2
	supervisors = "the NT corporate office"
	access = list(ACCESS_MARINE_MEDBAY, ACCESS_MARINE_RESEARCH, ACCESS_MARINE_CHEMISTRY, ACCESS_MARINE_ENGINEERING, ACCESS_CIVILIAN_ENGINEERING)
	minimal_access = list(ACCESS_MARINE_MEDBAY, ACCESS_MARINE_RESEARCH, ACCESS_MARINE_CHEMISTRY, ACCESS_MARINE_CARGO, ACCESS_MARINE_DROPSHIP)
	skills_type = /datum/skills/researcher
	display_order = JOB_DISPLAY_ORDER_MEDICAL_RESEARCHER
	outfit = /datum/outfit/job/medical/researcher
	multiple_outfits = TRUE
	outfits = list(
		/datum/outfit/job/medical/researcher,
		/datum/outfit/job/medical/researcher/robot,
	)
	job_flags = JOB_FLAG_LATEJOINABLE|JOB_FLAG_ROUNDSTARTJOINABLE|JOB_FLAG_ALLOWS_PREFS_GEAR|JOB_FLAG_PROVIDES_BANK_ACCOUNT|JOB_FLAG_ADDTOMANIFEST|JOB_FLAG_PROVIDES_SQUAD_HUD|JOB_FLAG_ALWAYS_VISIBLE_ON_MINIMAP
	jobworth = list(
		/datum/job/xenomorph = LARVA_POINTS_SHIPSIDE,
		/datum/job/terragov/squad/smartgunner = SMARTIE_POINTS_REGULAR,
		/datum/job/terragov/silicon/synthetic = SYNTH_POINTS_REGULAR,
		/datum/job/terragov/command/mech_pilot = MECH_POINTS_REGULAR,
	)
	html_description = {"
		<b>Difficulty</b>: Medium<br /><br />
		<b>You answer to the</b> Ninetails Corporate Office<br /><br />
		<b>Unlock Requirement</b>: Starting Role<br /><br />
		<b>Gamemode Availability</b>: Nuclear War<br /><br /><br />
		<b>Duty</b>: Research extraterrestrial life aboard the ship if provided by Ninetails/TerraGov, synthesize chemicals for the benefit of the marines. Find out the cause of why and when. Learn new things for humankind. Act as a secondary medical officer in practice.
	"}
	minimap_icon = "researcher"


/datum/job/terragov/medical/researcher/radio_help_message(mob/M)
	. = ..()
	to_chat(M, {"You are a civilian, working for the Ninetails Corporation, but you are still subject to the military chain of command.
You are tasked with deploying with the marines and researching the remains of the colony to get funding for Requisitions.
You are free to use any new technology you discover as you want, or give them out to the marines.
If shipside medbay is unstaffed, you should consider working as a regular doctor until someone else is available to take over.
It is also recommended that you gear up like a regular marine, or your 'internship' might be ending early..."})

/datum/job/terragov/medical/researcher/after_spawn(mob/living/carbon/new_mob, mob/user, latejoin = FALSE)
	. = ..()
	if(!ishuman(new_mob))
		return
	var/mob/living/carbon/human/new_human = new_mob
	var/playtime_mins = user?.client?.get_exp(title)
	if(!playtime_mins || playtime_mins < 1 )
		return
	switch(playtime_mins)
		if(0 to 3000) // starting
			new_human.wear_id.paygrade = "CD"
		if(3001 to INFINITY) // 50 hrs
			new_human.wear_id.paygrade = "PROF"


/datum/outfit/job/medical/researcher
	name = MEDICAL_RESEARCHER
	jobtype = /datum/job/terragov/medical/researcher

	id = /obj/item/card/id
	belt = /obj/item/storage/belt/rig/research
	ears = /obj/item/radio/headset/mainship/res
	w_uniform = /obj/item/clothing/under/marine/officer/researcher
	wear_suit = /obj/item/clothing/suit/storage/labcoat/researcher
	shoes = /obj/item/clothing/shoes/laceup
	gloves = /obj/item/clothing/gloves/latex
	glasses = /obj/item/clothing/glasses/hud/health
	mask = /obj/item/clothing/mask/surgical
	r_store = /obj/item/storage/pouch/surgery
	l_store = /obj/item/storage/pouch/medkit/medic


/datum/outfit/job/medical/researcher/robot
	species = SPECIES_COMBAT_ROBOT

	w_uniform = /obj/item/clothing/under/marine/robotic
	shoes = null
	gloves = null

/datum/outfit/job/medical/researcher/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	H.equip_to_slot_or_hand(new /obj/item/tweezers, SLOT_IN_R_POUCH)
	H.equip_to_slot_or_hand(new /obj/item/reagent_containers/glass/bottle/lemoline/doctor, SLOT_S_STORE)

/datum/job/terragov/civilian
	job_category = JOB_CAT_CIVILIAN
	selection_color = "#ffeedd"


//Liaison
/datum/job/terragov/civilian/liaison
	title = CORPORATE_LIAISON
	paygrade = "NT"
	comm_title = "CL"
	supervisors = "the NT corporate office"
	total_positions = 1
	shadow_languages = list(/datum/language/xenocommon)
	access = ALL_ACCESS
	minimal_access = ALL_ACCESS
	skills_type = /datum/skills/civilian
	display_order = JOB_DISPLAY_ORDER_CORPORATE_LIAISON
	outfit = /datum/outfit/job/civilian/liaison
	job_flags = JOB_FLAG_LATEJOINABLE|JOB_FLAG_ROUNDSTARTJOINABLE|JOB_FLAG_ALLOWS_PREFS_GEAR|JOB_FLAG_PROVIDES_BANK_ACCOUNT|JOB_FLAG_ADDTOMANIFEST|JOB_FLAG_PROVIDES_SQUAD_HUD
	jobworth = list(
		/datum/job/xenomorph = LARVA_POINTS_SHIPSIDE,
		/datum/job/terragov/squad/smartgunner = SMARTIE_POINTS_REGULAR,
		/datum/job/terragov/silicon/synthetic = SYNTH_POINTS_REGULAR,
		/datum/job/terragov/command/mech_pilot = MECH_POINTS_REGULAR,
	)
	html_description = {"
		<b>Difficulty</b>: Hard (varies)<br /><br />
		<b>You answer to the</b> Ninetails Corporate Office<br /><br />
		<b>Unlock Requirement</b>: Starting Role<br /><br />
		<b>Gamemode Availability</b>: Nuclear War<br /><br /><br />
		<b>Duty</b>: Manage relations between Ninetails and Nine Tailed Fox. Report your findings via faxes. Reply if you’re called.
	"}
	minimap_icon = "cl"

/datum/job/terragov/civilian/liaison/after_spawn(mob/living/carbon/new_mob, mob/user, latejoin = FALSE)
	. = ..()
	if(!ishuman(new_mob))
		return

	var/mob/living/carbon/human/new_human = new_mob
	var/playtime_mins = user?.client?.get_exp(title)
	if(!playtime_mins || playtime_mins < 1 )
		return
	switch(playtime_mins)
		if(0 to 600) // 0 to 10 hours
			new_human.wear_id.paygrade = "NT1"
		if(601 to 1500) // 10 to 25 hours
			new_human.wear_id.paygrade = "NT2"
		if(1501 to 3000) // 25 to 50 hours
			new_human.wear_id.paygrade = "NT3"
		if(3001 to 6000) // 50 to 100 hours
			new_human.wear_id.paygrade = "NT4"
		if(6000 to INFINITY) // Above 100 hours
			new_human.wear_id.paygrade = "NT5"

/datum/job/terragov/civilian/liaison/radio_help_message(mob/M)
	. = ..()
	to_chat(M, {"As a representative of Ninetails Corporation you are expected to stay professional and loyal to the corporation at all times.
You are expected to make sure the corporation is functioning as intended for Ninetails Corp's interests and good outlook. Running miners while at peace is usually more profitable than warring and wasting resources.
Your primary job is to observe and report back your findings to Ninetails. Follow regular game rules unless told otherwise by your superiors.
Use your office fax machine to communicate with corporate headquarters or to acquire new directives. You may not receive anything back (especially if the game staff is absent or otherwise busy), and this is normal."})

/datum/outfit/job/civilian/liaison
	name = CORPORATE_LIAISON
	jobtype = /datum/job/terragov/civilian/liaison

	id = /obj/item/card/id/silver
	ears = /obj/item/radio/headset/mainship/mcom
	w_uniform = /obj/item/clothing/under/liaison_suit
	shoes = /obj/item/clothing/shoes/laceup


/datum/job/terragov/silicon
	job_category = JOB_CAT_SILICON
	selection_color = "#aaee55"


//Synthetic
/datum/job/terragov/silicon/synthetic
	title = SYNTHETIC
	req_admin_notify = TRUE
	comm_title = "Syn"
	paygrade = "Mk.I"
	supervisors = "the acting captain"
	total_positions = 1
	skills_type = /datum/skills/synthetic
	access = ALL_ACCESS
	minimal_access = ALL_ACCESS
	display_order = JOB_DISPLAY_ORDER_SYNTHETIC
	outfit = /datum/outfit/job/civilian/synthetic
	exp_requirements = XP_REQ_EXPERIENCED
	exp_type = EXP_TYPE_REGULAR_ALL
	job_flags = JOB_FLAG_SPECIALNAME|JOB_FLAG_LATEJOINABLE|JOB_FLAG_ROUNDSTARTJOINABLE|JOB_FLAG_ADDTOMANIFEST|JOB_FLAG_ISCOMMAND|JOB_FLAG_BOLD_NAME_ON_SELECTION|JOB_FLAG_PROVIDES_SQUAD_HUD|JOB_FLAG_CAN_SEE_ORDERS|JOB_FLAG_ALWAYS_VISIBLE_ON_MINIMAP
	jobworth = list(
		/datum/job/xenomorph = LARVA_POINTS_SHIPSIDE_STRONG,
		/datum/job/terragov/squad/smartgunner = SMARTIE_POINTS_REGULAR,
		/datum/job/terragov/command/mech_pilot = MECH_POINTS_REGULAR,
	)
	html_description = {"
		<b>Difficulty</b>: Soul Crushing<br /><br />
		<b>You answer to the</b> acting Command Staff and the human crew<br /><br />
		<b>Unlock Requirement</b>: Starting Role<br /><br />
		<b>Gamemode Availability</b>: Crash, Nuclear War<br /><br /><br />
		<b>Duty</b>: Support and assist in every department of the Nine Tailed Fox, use your incredibly developed skills to help the marines during their missions. You can talk to other synthetics or the AI on the :n channel. Serve your purpose.
	"}
	minimap_icon = "synth"

/datum/job/terragov/silicon/synthetic/get_special_name(client/preference_source)
	return preference_source.prefs.synthetic_name

/datum/job/terragov/silicon/synthetic/return_spawn_type(datum/preferences/prefs)
	if(prefs?.synthetic_type == "Early Synthetic")
		return /mob/living/carbon/human/species/early_synthetic
	return /mob/living/carbon/human/species/synthetic

/datum/job/terragov/silicon/synthetic/return_skills_type(datum/preferences/prefs)
	if(prefs?.synthetic_type == "Early Synthetic")
		return /datum/skills/early_synthetic
	return ..()

/datum/job/terragov/silicon/synthetic/after_spawn(mob/living/carbon/new_mob, mob/user, latejoin = FALSE)
	. = ..()
	if(!ishuman(new_mob))
		return
	var/mob/living/carbon/human/new_human = new_mob
	var/playtime_mins = user?.client?.get_exp(title)
	if(!playtime_mins || playtime_mins < 1 )
		return
	switch(playtime_mins)
		if(0 to 600) //up to 10 hours
			new_human.wear_id.paygrade = "Mk.I"
		if(601 to 2400)
			new_human.wear_id.paygrade = "Mk.II"
		if(2401 to 5400)
			new_human.wear_id.paygrade = "Mk.III"
		if(5401 to 7600)
			new_human.wear_id.paygrade = "Mk.IV"
		if(7601 to INFINITY)
			new_human.wear_id.paygrade = "Mk.V"

/datum/job/terragov/silicon/synthetic/radio_help_message(mob/M)
	. = ..()
	to_chat(M, {"Your primary job is to support and assist all NTC departments and personnel on-board.
In addition, being a Synthetic gives you knowledge in every field and specialization possible on-board the ship."})


/datum/outfit/job/civilian/synthetic
	name = SYNTHETIC
	jobtype = /datum/job/terragov/silicon/synthetic

	id = /obj/item/card/id/gold
	belt = /obj/item/storage/belt/utility/full
	ears = /obj/item/radio/headset/mainship/mcom
	w_uniform = /obj/item/clothing/under/rank/synthetic
	shoes = /obj/item/clothing/shoes/white
	gloves = /obj/item/clothing/gloves/insulated
	r_store = /obj/item/storage/pouch/general/medium
	l_store = /obj/item/storage/pouch/general/medium


/datum/job/terragov/silicon/ai
	title = SILICON_AI
	job_category = JOB_CAT_SILICON
	req_admin_notify = TRUE
	comm_title = "AI"
	total_positions = 1
	selection_color = "#92c255"
	supervisors = "your laws and the human crew"
	exp_requirements = XP_REQ_INTERMEDIATE
	exp_type = EXP_TYPE_REGULAR_ALL
	exp_type_department = EXP_TYPE_SILICON
	display_order = JOB_DISPLAY_ORDER_AI
	skills_type = /datum/skills/ai
	job_flags = JOB_FLAG_SPECIALNAME|JOB_FLAG_LATEJOINABLE|JOB_FLAG_ROUNDSTARTJOINABLE|JOB_FLAG_OVERRIDELATEJOINSPAWN|JOB_FLAG_ISCOMMAND|JOB_FLAG_BOLD_NAME_ON_SELECTION
	jobworth = list(
		/datum/job/xenomorph = LARVA_POINTS_SHIPSIDE,
		/datum/job/terragov/squad/smartgunner = SMARTIE_POINTS_REGULAR,
		/datum/job/terragov/silicon/synthetic = SYNTH_POINTS_REGULAR,
		/datum/job/terragov/command/mech_pilot = MECH_POINTS_REGULAR,
	)
	html_description = {"
		<b>Difficulty</b>: Easy<br /><br />
		<b>You answer to the</b> acting Command Staff and the human crew<br /><br />
		<b>Unlock Requirement</b>: Starting Role<br /><br />
		<b>Gamemode Availability</b>: Nuclear War<br /><br /><br />
		<b>Duty</b>: Assist the crew whenever you’re needed, be the doorknob of the ship. Recon the areas for threats via cameras, report your findings to the crew at various communication channels. Follow your laws.
	"}


/datum/job/terragov/silicon/ai/get_special_name(client/preference_source)
	return preference_source.prefs.ai_name


/datum/job/terragov/silicon/ai/return_spawn_type(datum/preferences/prefs)
	return /mob/living/silicon/ai

/datum/job/terragov/silicon/ai/radio_help_message(mob/M)
	. = ..()
	to_chat(M, {"Your primary job is to support and assist all NTC departments and personnel on-board.
However, your vision is limited through cameras from the ship or to marines groundside.
Recon any threats and report findings at various communication channels.
If you require any help, use <b>mentorhelp</b> to ask mentors about what you're supposed to do."})


/datum/job/terragov/silicon/ai/announce(mob/living/announced_mob)
	. = ..()
	SSticker.OnRoundstart(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(minor_announce), "[announced_mob] has been downloaded to an empty bluespace-networked AI core at [AREACOORD(announced_mob)]."))


/datum/job/terragov/silicon/ai/config_check()
	return CONFIG_GET(flag/allow_ai)

// Silicons only need a very basic preview since there is no customization for them.
/datum/job/terragov/silicon/ai/handle_special_preview(client/parent)
	parent.show_character_previews(image('icons/mob/ai.dmi', icon_state = "ai", dir = SOUTH))
	return TRUE
