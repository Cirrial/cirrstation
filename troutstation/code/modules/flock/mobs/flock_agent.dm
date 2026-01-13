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
	death_message = "hits the ground and cracks, its desperate caws fading as its lights dim."

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
	ADD_TRAIT(src, TRAIT_CHUNKYFINGERS, SPECIES_TRAIT)

	// as creatures of radio they should be allowed to hear all the radios
	// TODO: decide if that includes syndie radios too
	var/obj/item/radio/internal_radio = new /obj/item/radio(src)
	internal_radio.keyslot = /obj/item/encryptionkey/heads/captain
	internal_radio.subspace_transmission = TRUE
	internal_radio.canhear_range = 0 // anything higher and people in the area will hear it too
	internal_radio.recalculateChannels()

	radiodive = new(src)
	radiodive.Grant(src)
	squawk = new(src)
	squawk.Grant(src)

	fully_replace_character_name(null, generate_flock_name("CV.CV.CV"))

/mob/living/basic/flock/agent/death(gibbed)
	if(is_jaunting(src))
		playsound(src, 'troutstation/sound/mobs/non-humanoids/flock/flock_critter_attenuate_death.ogg', 100, TRUE)
		icon_dead = "agent_dead_attenuated"
		death_message = "abruptly forms from the air, a husk that clatters to the ground amid ethereal caws."
		desc = "Odd lights fizz from a cracked, slowly melting shell. In a few days, there'll be no trace left."
	else
		playsound(src, 'troutstation/sound/mobs/non-humanoids/flock/flock_critter_death.ogg', 100, TRUE)
	return ..()
