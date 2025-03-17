/*
*
*Slugcats, a new vent critter.
*
*/

/mob/living/basic/slugcat
	name = "slugcat"
	desc = "A biologically engineered entity to clean pipes and relay information. It looks upon you with large, inquisitive eyes."
	icon = 'troutstation/icons/mob/simple/slugcats.dmi'
	icon_state = "scug"
	icon_living = "scug"
	icon_dead = "scug_dead"
	speak_emote = list("mews")
	butcher_results = list(/obj/item/food/meat/slab = 2)
	response_help_continuous = "pets"
	response_help_simple = "pet"
	response_disarm_continuous = "shoos"
	response_disarm_simple = "shoo"
	response_harm_continuous = "swats"
	response_harm_simple = "swat"

	gold_core_spawnable = FRIENDLY_SPAWN

	health = 80
	maxHealth = 80
	melee_damage_lower = 5
	melee_damage_upper = 5
	obj_damage = 0
	environment_smash = ENVIRONMENT_SMASH_NONE

	attack_verb_continuous = "claws"
	attack_verb_simple = "claw"
	attack_sound = 'sound/items/weapons/pierce.ogg'
	death_sound = 'troutstation/sound/effects/slugcat/death.ogg'

	// language_holder = /datum/language_holder/slugcat
	initial_language_holder = /datum/language_holder/slugcat

	ai_controller = /datum/ai_controller/basic_controller/slugcat

	///What fate (food) a slugcat?
	var/static/list/edibles = list(
		/mob/living/basic/mouse,
		/obj/item/food/deadmouse,
		/mob/living/basic/bat
	)

/mob/living/basic/slugcat/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/footstep, footstep_type = FOOTSTEP_MOB_CLAW)
	AddElement(/datum/element/ai_retaliate)
	AddElement(/datum/element/dextrous)
	ADD_TRAIT(src, TRAIT_VENTCRAWLER_ALWAYS, INNATE_TRAIT)

	AddElement(/datum/element/basic_eating, heal_amt = 2, food_types = edibles)
	ai_controller.set_blackboard_key(BB_BASIC_FOODS, edibles)


/datum/ai_controller/basic_controller/slugcat

	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
	)

	ai_traits = STOP_MOVING_WHEN_PULLED
	ai_movement = /datum/ai_movement/basic_avoidance
	idle_behavior = /datum/idle_behavior/idle_random_walk

	planning_subtrees = list(
		/datum/ai_planning_subtree/target_retaliate,
		/datum/ai_planning_subtree/find_food,
		/datum/ai_planning_subtree/basic_melee_attack_subtree,
	)

/datum/language/wawa
	name = "Slosh"
	desc = "The language of the slugcats. They have mastered the art of conveying complex thoughts just using one versatile syllable."
	key = "w"
	syllables = list("wawa")
	default_priority = 70

	icon_state = "wawa"
	icon = 'troutstation/icons/misc/language.dmi'

/datum/language_holder/slugcat
	understood_languages = list(/datum/language/common = list(LANGUAGE_MIND),
								/datum/language/wawa = list(LANGUAGE_MIND))
	spoken_languages = list(/datum/language/wawa = list(LANGUAGE_MIND))

// wawa
/datum/emote/living/wawa
	key = "wawa"
	key_third_person = "wawas"
	message = "goes wawa!"
	message_param = "wawa's at %t!"
	message_mime = "wawa's silently!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	cooldown = 10
	specific_emote_audio_cooldown = 10

/datum/emote/living/wawa/get_sound(mob/living/user)
	return pick(
		'troutstation/sound/effects/slugcat/wawa1.ogg',
		'troutstation/sound/effects/slugcat/wawa2.ogg',
		'troutstation/sound/effects/slugcat/wawa3.ogg',
		'troutstation/sound/effects/slugcat/wawa4.ogg',
	)

/datum/emote/living/wawa/can_run_emote(mob/user, status_check, intentional)
	return ..() && isslugcat(user)

// wa
/datum/emote/living/wa
	key = "wa"
	key_third_person = "wa"
	message = "goes wa!"
	message_param = "wa's at %t!"
	message_mime = "wa's silently!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	specific_emote_audio_cooldown = 1.8 SECONDS

/datum/emote/living/wa/get_sound(mob/living/user)
	return pick(
		'troutstation/sound/effects/slugcat/wa1.ogg',
		'troutstation/sound/effects/slugcat/wa2.ogg',
		'troutstation/sound/effects/slugcat/wa3.ogg',
		'troutstation/sound/effects/slugcat/wa4.ogg',
		'troutstation/sound/effects/slugcat/wa5.ogg',
		'troutstation/sound/effects/slugcat/wa6.ogg',
		'troutstation/sound/effects/slugcat/wa7.ogg',
		'troutstation/sound/effects/slugcat/wa8.ogg',
	)

/datum/emote/living/wa/can_run_emote(mob/user, status_check, intentional)
	return ..() && isslugcat(user)
