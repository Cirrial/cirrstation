/datum/design/borg_upgrade_booster
	name = "Skiff Booster Module"
	id = "borg_upgrade_booster"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/booster
	materials = list(
		/datum/material/iron =SHEET_MATERIAL_AMOUNT*8,
		/datum/material/glass =SHEET_MATERIAL_AMOUNT*2,
		/datum/material/plasma =SHEET_MATERIAL_AMOUNT*1,
	)
	construction_time = 8 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_ALL
	)

/datum/design/borg_upgrade_super_booster
	name = "Skiff Booster Module"
	id = "borg_upgrade_super_booster"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/booster/super
	materials = list(
		/datum/material/iron =SHEET_MATERIAL_AMOUNT*5,
		/datum/material/glass =SHEET_MATERIAL_AMOUNT*5,
		/datum/material/plasma =SHEET_MATERIAL_AMOUNT*5,
		/datum/material/gold =SHEET_MATERIAL_AMOUNT*5,
	)
	construction_time = 8 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_ALL
	)



