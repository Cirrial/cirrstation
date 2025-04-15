/obj/item/borg/upgrade/booster
	name = "skiff thruster module"
	desc = "Bypasses a cyborg's safety measures to convert energy to raw speed. The cyborg can toggle this on and off."
	icon_state = "module_general"
	require_model = TRUE
	var/on = FALSE
	var/energy_cost = 0.05 * STANDARD_CELL_CHARGE // DRINK IT UP
	var/datum/action/toggle_action
	var/datum/movespeed_modifier/movespeed_modifier = /datum/movespeed_modifier/skiff_booster

/obj/item/borg/upgrade/booster/action(mob/living/silicon/robot/borg, mob/living/user = usr)
	. = ..()
	if(!.)
		return .
	icon_state = "selfrepair_off"
	toggle_action = new /datum/action/item_action/toggle(src)
	toggle_action.Grant(borg)

/obj/item/borg/upgrade/booster/deactivate(mob/living/silicon/robot/borg, mob/living/user = usr)
	. = ..()
	if(!.)
		return .
	toggle_action.Remove(borg)
	QDEL_NULL(toggle_action)
	deactivate_boost()

/obj/item/borg/upgrade/booster/ui_action_click()
	if(on)
		to_chat(toggle_action.owner, span_notice("You deactivate the booster module."))
		deactivate_boost()
	else
		to_chat(toggle_action.owner, span_notice("You activate the booster module."))
		activate_boost()


/obj/item/borg/upgrade/booster/update_icon_state()
	if(toggle_action)
		icon_state = "selfrepair_[on ? "on" : "off"]"
	else
		icon_state = "cyborg_upgrade5"
	return ..()

/obj/item/borg/upgrade/booster/proc/activate_boost()
	START_PROCESSING(SSobj, src)
	on = TRUE
	var/mob/living/silicon/robot/cyborg = toggle_action.owner
	cyborg.add_movespeed_modifier(movespeed_modifier)
	update_appearance()

/obj/item/borg/upgrade/booster/proc/deactivate_boost()
	STOP_PROCESSING(SSobj, src)
	on = FALSE
	var/mob/living/silicon/robot/cyborg = toggle_action.owner
	cyborg.remove_movespeed_modifier(movespeed_modifier)
	update_appearance()

// this is just for tracking power use, the actual action happens on activate/deactivate
/obj/item/borg/upgrade/booster/process(seconds_per_tick)
	var/mob/living/silicon/robot/cyborg = toggle_action.owner

	if(istype(cyborg) && (cyborg.stat != DEAD) && on)
		if(!cyborg.cell)
			to_chat(cyborg, span_alert("Booster module deactivated. Please insert power cell."))
			deactivate_boost()
			return

		if(cyborg.cell.charge < energy_cost * 2)
			to_chat(cyborg, span_alert("Booster module deactivated. Please recharge."))
			deactivate_boost()
			return

		cyborg.cell.use(energy_cost * seconds_per_tick)
	else
		deactivate_boost()


/obj/item/borg/upgrade/booster/super
	name = "Sterilis-Approved skiff thruster module"
	desc = "A dangerous module that saps as much power as possible in the name of maximum speed. Warn your janitors about the inevitable wreckage this will cause."
	energy_cost = 0.15 * STANDARD_CELL_CHARGE // AHAHAHA
	movespeed_modifier = /datum/movespeed_modifier/super_skiff_booster
