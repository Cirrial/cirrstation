/mob/living/basic/flock/agent
	name = "odd avian construct"
	desc = "Light flickers through traced lines in its smooth, glassy body."
	icon_state = "agent"
	icon_living = "agent"
	icon_dead = "agent_dead"
	maxHealth = 100
	health = 100
	speed = 0.5
	unique_name = FALSE // we get a REAL name
	hud_type = /datum/hud/dextrous/flock_agent

	var/obj/item/internal_storage

	/// Intrinsic radiodive ability
	var/datum/action/cooldown/spell/jaunt/radiodive/radiodive
	/// Intrinsic squawk ability
	var/datum/action/cooldown/mob_cooldown/flock_squawk/squawk


/mob/living/basic/flock/agent/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/dextrous, hud_type = hud_type, can_throw = TRUE)
	AddComponent(/datum/component/basic_inhands, x_offset = 0, y_offset = -1) // TODO: CUSTOM COMPONENT
	AddComponentFrom(SPECIES_TRAIT, /datum/component/radio_source_vision)
	ADD_TRAIT(src, TRAIT_ADVANCEDTOOLUSER, SPECIES_TRAIT)
	ADD_TRAIT(src, TRAIT_LITERATE, SPECIES_TRAIT)

	radiodive = new(src)
	radiodive.Grant(src)
	squawk = new(src)
	squawk.Grant(src)

	fully_replace_character_name(null, generate_flock_name("CV.CV.CV"))
