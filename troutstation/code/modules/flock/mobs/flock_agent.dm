/mob/living/basic/flock/agent
	name = "odd avian construct"
	desc = "Light flickers through its glassy, spindly body. It looks fragile."
	icon_state = "agent"
	icon_living = "agent"
	icon_dead = "agent_dead"
	maxHealth = 100
	health = 100
	speed = 0.5
	hud_type = /datum/hud/dextrous/flock_agent

	var/obj/item/internal_storage

	/// Intrinsic radiodive ability
	var/datum/action/cooldown/spell/jaunt/radiodive/radiodive


/mob/living/basic/flock/agent/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/dextrous, hud_type = hud_type, can_throw = TRUE)
	AddComponent(/datum/component/basic_inhands, x_offset = 0, y_offset = -1) // TODO: CUSTOM COMPONENT
	AddComponentFrom(INNATE_TRAIT, /datum/component/radio_source_vision)

	radiodive = new(src)
	radiodive.Grant(src)
