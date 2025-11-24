/mob/living/basic/skitterer
	name = "skitterer"
	desc = "A freak of a creature who's only objective in life seems to be to get on other lifeform's nerves. As it's name may imply, it skitters around on its six stubby legs."
	icon = 'troutstation/icons/mob/simple/skitterer.dmi'
	icon_state = "skitterer"
	icon_living = "skitterer"
	icon_dead = "skitterer_dead"
	butcher_results = list(/obj/item/food/meat/slab = 1)
	speak_emote = list("cries","shrieks","whoops")
	response_help_continuous = "prods"
	response_help_simple = "prod"
	response_disarm_continuous = "bops"
	response_disarm_simple = "bop"
	response_harm_continuous = "kicks"
	response_harm_simple = "kick"
	speed = -0.5
	mob_biotypes = MOB_ORGANIC
	mob_size = MOB_SIZE_SMALL
	faction = list(FACTION_SKITTER)

	gold_core_spawnable = FRIENDLY_SPAWN

	health = 25
	maxHealth = 25
	melee_damage_lower = 1
	melee_damage_upper = 2
	obj_damage = 0
	environment_smash = ENVIRONMENT_SMASH_NONE

	attack_verb_continuous = "kicks"
	attack_verb_simple = "kick"
	attack_sound = 'troutstation/sound/mobs/non-humanoids/skitterer/skitter_attack1.ogg'
	attacked_sound = 'troutstation/sound/mobs/non-humanoids/skitterer/skitter_attack2.ogg'
	death_sound = 'troutstation/sound/mobs/non-humanoids/skitterer/skitter_death.ogg'

	ai_controller = /datum/ai_controller/basic_controller/skitterer


/mob/living/basic/skitterer/attackby(obj/item/reagent_containers/cooler_jug/gaywater/thejug, mob/user, list/modifiers, list/attack_modifiers)
	if(!istype(thejug))
		return ..()
	new /mob/living/basic/gay_skitterer(src.loc)
	to_chat(user, span_notice("[src] suddenly seems very gay..."))
	qdel(thejug)
	qdel(src)



/mob/living/basic/skitterer/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/footstep, footstep_type = FOOTSTEP_MOB_SKITTER)
	AddElement(/datum/element/ai_retaliate)
	AddElement(/datum/element/dextrous, hands_count = 1, can_throw = FALSE)
	ADD_TRAIT(src, TRAIT_VENTCRAWLER_ALWAYS, INNATE_TRAIT)
	var/static/list/display_emote = list(
		BB_EMOTE_SAY = list("Aouuuugh!","Waaaaarrrrrghghh!","Oogh!"),
		BB_EMOTE_SEE = list("flails its limbs!", "hops around!", "skitters across the floor!"),
		BB_SPEAK_CHANCE = 5,
		BB_EMOTE_SOUND = list('troutstation/sound/mobs/non-humanoids/skitterer/skitter_attack3.ogg'),
	)
	ai_controller.set_blackboard_key(BB_BASIC_MOB_SPEAK_LINES, display_emote)
	ai_controller.set_blackboard_key(BB_REINFORCEMENTS_EMOTE, "screeches loudly, calling for help!")

/mob/living/basic/gay_skitterer // not a subtype because the ai random speech/emote thing was acting weird
	name = "gay skitterer"
	desc = "This might be the gayest creature this side of the galaxy."
	icon = 'troutstation/icons/mob/simple/skitterer.dmi'
	icon_state = "gay_skitterer"
	icon_living = "gay_skitterer"
	icon_dead = "gay_skitterer_dead"
	butcher_results = list(/obj/item/food/meat/slab = 1, /obj/item/food/gaywatermelonmush = 2)
	speak_emote = list("cries","shrieks","whoops")
	response_help_continuous = "prods"
	response_help_simple = "prod"
	response_disarm_continuous = "bops"
	response_disarm_simple = "bop"
	response_harm_continuous = "kicks"
	response_harm_simple = "kick"
	speed = -0.5
	mob_biotypes = MOB_ORGANIC
	mob_size = MOB_SIZE_SMALL
	faction = list(FACTION_SKITTER)

	gold_core_spawnable = FRIENDLY_SPAWN

	health = 25
	maxHealth = 25
	melee_damage_lower = 1
	melee_damage_upper = 2
	obj_damage = 0
	environment_smash = ENVIRONMENT_SMASH_NONE

	attack_verb_continuous = "kicks"
	attack_verb_simple = "kick"
	attack_sound = 'troutstation/sound/mobs/non-humanoids/skitterer/skitter_attack1.ogg'
	attacked_sound = 'troutstation/sound/mobs/non-humanoids/skitterer/skitter_attack2.ogg'
	death_sound = 'troutstation/sound/mobs/non-humanoids/skitterer/skitter_death.ogg'

	ai_controller = /datum/ai_controller/basic_controller/skitterer

/mob/living/basic/gay_skitterer/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/footstep, footstep_type = FOOTSTEP_MOB_SKITTER)
	AddElement(/datum/element/ai_retaliate)
	AddElement(/datum/element/dextrous, hands_count = 1, can_throw = FALSE)
	ADD_TRAIT(src, TRAIT_VENTCRAWLER_ALWAYS, INNATE_TRAIT)
	var/static/list/display_emote = list(
		BB_EMOTE_SAY = list("Gay!"),
		BB_EMOTE_SEE = list("flails gayly!", "hops around gayly!", "skitters gayly across the floor!"),
		BB_SPEAK_CHANCE = 10,
		BB_EMOTE_SOUND = list('troutstation/sound/misc/gay.ogg','troutstation/sound/misc/gay2.ogg','troutstation/sound/misc/gay3.ogg','troutstation/sound/misc/gay4.ogg','troutstation/sound/misc/gay5.ogg'),
	)
	ai_controller.set_blackboard_key(BB_BASIC_MOB_SPEAK_LINES, display_emote)
	ai_controller.set_blackboard_key(BB_REINFORCEMENTS_SAY, "GAYYYYYY!!!")



/datum/ai_controller/basic_controller/skitterer
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
	)

	ai_movement = /datum/ai_movement/basic_avoidance
	idle_behavior = /datum/idle_behavior/idle_random_walk/more_walking

	planning_subtrees = list(
		/datum/ai_planning_subtree/target_retaliate,
		/datum/ai_planning_subtree/call_reinforcements,
		/datum/ai_planning_subtree/random_speech/blackboard,
		/datum/ai_planning_subtree/basic_melee_attack_subtree,
	)
