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

	var/obj/item/internal_storage

	/// Intrinsic radiodive ability
	var/datum/action/cooldown/spell/jaunt/radiodive/radiodive
	/// Intrinsic squawk ability
	var/datum/action/cooldown/mob_cooldown/flock_squawk/squawk


/mob/living/basic/flock/agent/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/dextrous, hud_type = hud_type, can_throw = TRUE)
	AddComponent(/datum/component/personal_crafting)
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


// Internal storage

/mob/living/basic/flock/agent/doUnEquip(obj/item/item_dropping, force, newloc, no_move, invdrop = TRUE, silent = FALSE)
	. = ..()
	if (!.)
		return FALSE
	update_held_items()
	if(item_dropping == internal_storage)
		internal_storage = null
		update_inv_internal_storage()
	return TRUE

/mob/living/basic/flock/agent/can_equip(mob/living/M, slot, disable_warning = FALSE, bypass_equip_delay_self = FALSE, ignore_equipped = FALSE, indirect_action = FALSE)
	if(slot != ITEM_SLOT_DEX_STORAGE)
		return FALSE
	return isnull(internal_storage)

/mob/living/basic/flock/agent/get_item_by_slot(slot_id)
	if(slot_id == ITEM_SLOT_DEX_STORAGE)
		return internal_storage
	return ..()

/mob/living/basic/flock/agent/get_slot_by_item(obj/item/looking_for)
	if(internal_storage == looking_for)
		return ITEM_SLOT_DEX_STORAGE
	return ..()

/mob/living/basic/flock/agent/equip_to_slot(obj/item/equipping, slot, initial = FALSE, redraw_mob = FALSE, indirect_action = FALSE)
	if (slot != ITEM_SLOT_DEX_STORAGE)
		to_chat(src, span_danger("You are trying to equip this item to an unsupported inventory slot. Report this to a coder!"))
		return FALSE

	var/index = get_held_index_of_item(equipping)
	if(index)
		held_items[index] = null
	update_held_items()

	if(equipping.pulledby)
		equipping.pulledby.stop_pulling()

	equipping.screen_loc = null // will get moved if inventory is visible
	equipping.forceMove(src)
	SET_PLANE_EXPLICIT(equipping, ABOVE_HUD_PLANE, src)

	internal_storage = equipping
	update_inv_internal_storage()

	has_equipped(equipping, slot)
	return TRUE

/mob/living/basic/flock/agent/getBackSlot()
	return ITEM_SLOT_DEX_STORAGE

/mob/living/basic/flock/agent/proc/update_inv_internal_storage()
	if(isnull(internal_storage) || isnull(client) || !hud_used?.hud_shown)
		return
	internal_storage.screen_loc = ui_flock_storage
	client.screen += internal_storage

/mob/living/basic/flock/agent/regenerate_icons()
	update_inv_internal_storage()
