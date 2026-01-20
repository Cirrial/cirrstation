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
	basic_mob_flags = FLAMMABLE_MOB // how else are we going to show off our fire extinguisher
	fire_stack_decay_rate = -0.05
	max_stamina = 100
	stamina_crit_threshold = 100
	max_stamina_slowdown = 3

	/// Headwear slot
	var/obj/item/head
	/// Internal slot
	var/obj/item/internal_storage

	/// Intrinsic radiodive ability
	var/datum/action/cooldown/spell/jaunt/radiodive/radiodive
	/// Intrinsic squawk ability
	var/datum/action/cooldown/mob_cooldown/flock_squawk/squawk
	/// Have we started our self-extinguishing process?
	var/extinguishing

	var/list/agent_overlays[FLOCK_AGENT_TOTAL_LAYERS]
	var/sprite_dir = SOUTH

/mob/living/basic/flock/agent/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/dextrous, hud_type = hud_type, can_throw = TRUE)
	AddComponent(/datum/component/personal_crafting)
	AddComponent(/datum/component/basic_inhands, x_offset = 0, y_offset = -1)
	AddComponentFrom(SPECIES_TRAIT, /datum/component/radio_source_vision)
	ADD_TRAIT(src, TRAIT_ADVANCEDTOOLUSER, SPECIES_TRAIT)
	ADD_TRAIT(src, TRAIT_LITERATE, SPECIES_TRAIT)
	ADD_TRAIT(src, TRAIT_CHUNKYFINGERS, SPECIES_TRAIT)
	RegisterSignal(src, COMSIG_ATOM_DIR_CHANGE, PROC_REF(on_dir_change)) // it's ugly but it's all I can hook into

	// as creatures of radio they should be allowed to hear all the radios
	// TODO: decide if that includes syndie radios too
	var/obj/item/radio/internal_radio = new /obj/item/radio(src)
	internal_radio.keyslot = /obj/item/encryptionkey/heads/captain
	internal_radio.subspace_transmission = TRUE
	internal_radio.canhear_range = 0 // only us
	internal_radio.recalculateChannels()

	radiodive = new(src)
	radiodive.Grant(src)
	squawk = new(src)
	squawk.Grant(src)

	fully_replace_character_name(null, generate_flock_name("CV.CV.CV"))
	sprite_dir = dir

/mob/living/basic/flock/agent/death(gibbed)
	if(head)
		dropItemToGround(head)
	if(internal_storage)
		dropItemToGround(internal_storage)
	if(is_jaunting(src))
		playsound(src, 'troutstation/sound/mobs/non-humanoids/flock/flock_critter_attenuate_death.ogg', 100, TRUE)
		icon_dead = "agent_dead_attenuated"
		death_message = "abruptly forms from the air, a husk that clatters to the ground amid ethereal caws."
		desc = "Odd lights fizz from a cracked, slowly melting shell. In a few days, there'll be no trace left."
	else
		playsound(src, 'troutstation/sound/mobs/non-humanoids/flock/flock_critter_death.ogg', 100, TRUE)
	return ..(gibbed)

/mob/living/basic/flock/agent/Life()
	. = ..()
	var/datum/status_effect/fire_handler/fire_stacks/fire_status = has_status_effect(/datum/status_effect/fire_handler/fire_stacks)
	// don't check if we're conscious, this is an autonomous process
	if(fire_status && !extinguishing)
		extinguishing = TRUE
		to_chat(src, span_boldwarning("Fire detected in multiple systems. Integrated extinguishing systems are engaging."))
		playsound(get_turf(src), 'sound/effects/bubbles/bubbles2.ogg', 50, TRUE, -3)
		addtimer(CALLBACK(src, PROC_REF(do_self_extinguish)), 5 SECONDS)

/mob/living/basic/flock/agent/proc/do_self_extinguish()
	var/turf/our_turf = get_turf(src)
	to_chat(src, span_boldnotice("Extinguisher online."))
	visible_message(span_warning("[src] abruptly and violently foams up!"),
		span_notice("You feel firefoam bubbling up with force from your seams. [prob(20) ? "It tickles a bit." : ""]"),
		span_notice("You hear a vigorous and forceful frothing."))
	playsound(our_turf, 'sound/effects/extinguish.ogg', 75, TRUE, -3)
	new /obj/effect/particle_effect/fluid/foam/firefighting(our_turf)
	src.extinguish_mob()
	extinguishing = FALSE

/mob/living/basic/flock/agent/getarmor(def_zone, type)
	var/armorval = 0

	if(head)
		armorval = head.get_armor_rating(type)
	return armorval

/mob/living/basic/flock/agent/proc/on_dir_change(datum/source, old_dir, new_dir)
	sprite_dir = new_dir // cache the value we're sent, it's always ordinal
	update_worn_head()
