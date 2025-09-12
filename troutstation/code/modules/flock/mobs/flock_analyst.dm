/mob/living/basic/flock/analyst
	name = "odd avian construct"
	desc = "Light flickers through its glassy, spindly body. It looks fragile."
	icon_state = "analyst"
	icon_living = "analyst"
	icon_dead = "analyst_dead"
	maxHealth = 50
	health = 50
	hud_type = /datum/hud/dextrous/flock_analyst

	var/obj/item/internal_storage


/mob/living/basic/flock/analyst/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/dextrous, hud_type = hud_type, can_throw = TRUE)
	AddComponent(/datum/component/basic_inhands, y_offset = getItemPixelShiftY())


/mob/living/basic/flock/analyst/proc/getItemPixelShiftY()
	return 0  // todo: check this
