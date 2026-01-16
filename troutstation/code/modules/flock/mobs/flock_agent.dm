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
	internal_radio.canhear_range = 0 // only us
	internal_radio.recalculateChannels()

	radiodive = new(src)
	radiodive.Grant(src)
	squawk = new(src)
	squawk.Grant(src)

	fully_replace_character_name(null, generate_flock_name("CV.CV.CV"))

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
	playsound(our_turf, 'sound/effects/extinguish.ogg', 75, TRUE, -3)
	new /obj/effect/particle_effect/fluid/foam/firefighting(our_turf)
	src.extinguish_mob()
	extinguishing = FALSE

// Inventory //
/mob/living/basic/flock/agent/doUnEquip(obj/item/item_dropping, force, newloc, no_move, invdrop = TRUE, silent = FALSE)
	if(..())
		update_held_items()
		if(item_dropping == head)
			head = null
			update_worn_head()
		if(item_dropping == internal_storage)
			internal_storage = null
			update_inv_internal_storage()
		return TRUE
	return FALSE

/mob/living/basic/flock/agent/can_equip(obj/item/item, slot, disable_warning = FALSE, bypass_equip_delay_self = FALSE, ignore_equipped = FALSE, indirect_action = FALSE)
	switch(slot)
		if(ITEM_SLOT_HEAD)
			if(head)
				return FALSE
			if(!((item.slot_flags & ITEM_SLOT_HEAD) || (item.slot_flags & ITEM_SLOT_MASK)))
				return FALSE
			return TRUE
		if(ITEM_SLOT_DEX_STORAGE)
			if(internal_storage)
				return FALSE
			return TRUE
	..()


/mob/living/basic/flock/agent/get_item_by_slot(slot_id)
	switch(slot_id)
		if(ITEM_SLOT_HEAD)
			return head
		if(ITEM_SLOT_DEX_STORAGE)
			return internal_storage
	return ..()

/mob/living/basic/flock/agent/get_slot_by_item(obj/item/looking_for)
	if(internal_storage == looking_for)
		return ITEM_SLOT_DEX_STORAGE
	if(head == looking_for)
		return ITEM_SLOT_HEAD
	return ..()

/mob/living/basic/flock/agent/equip_to_slot(obj/item/equipping, slot, initial = FALSE, redraw_mob = FALSE, indirect_action = FALSE)
	if(!slot)
		return
	if(!istype(equipping))
		return

	var/index = get_held_index_of_item(equipping)
	if(index)
		held_items[index] = null
	update_held_items()

	if(equipping.pulledby)
		equipping.pulledby.stop_pulling()

	equipping.screen_loc = null // will get moved if inventory is visible
	equipping.forceMove(src)
	SET_PLANE_EXPLICIT(equipping, ABOVE_HUD_PLANE, src)

	switch(slot)
		if(ITEM_SLOT_HEAD)
			head = equipping
			update_worn_head()
		if(ITEM_SLOT_DEX_STORAGE)
			internal_storage = equipping
			update_inv_internal_storage()
		else
			to_chat(src, span_danger("You are trying to equip this item to an unsupported inventory slot. Report this to a coder!"))
			return

	has_equipped(equipping, slot)

/mob/living/basic/flock/agent/getBackSlot()
	return ITEM_SLOT_DEX_STORAGE

// Visuals eg. overlays //
// mostly stolen from drones like the rest of this
/mob/living/basic/flock/agent/proc/apply_overlay(cache_index)
	if((. = agent_overlays[cache_index]))
		add_overlay(.)

/mob/living/basic/flock/agent/proc/remove_overlay(cache_index)
	var/overlay = agent_overlays[cache_index]
	if(overlay)
		cut_overlay(overlay)
		agent_overlays[cache_index] = null

/mob/living/basic/flock/agent/update_clothing(slot_flags)
	if(slot_flags & ITEM_SLOT_HEAD)
		update_worn_head()
	if(slot_flags & ITEM_SLOT_HANDS)
		update_held_items()
	if(slot_flags & (ITEM_SLOT_HANDS|ITEM_SLOT_DEX_STORAGE))
		update_inv_internal_storage()

/mob/living/basic/flock/agent/proc/update_inv_internal_storage()
	if(internal_storage && client && hud_used?.hud_shown)
		internal_storage.screen_loc = ui_drone_storage
		client.screen += internal_storage

/mob/living/basic/flock/agent/update_worn_head()
	remove_overlay(FLOCK_AGENT_HEAD_LAYER)

	if(head)
		if(client && hud_used?.hud_shown)
			head.screen_loc = ui_flock_head
			client.screen += head
		var/used_head_icon = 'icons/mob/clothing/head/utility.dmi'
		var/mutable_appearance/head_overlay = head.build_worn_icon(default_layer = FLOCK_AGENT_HEAD_LAYER, default_icon_file = used_head_icon)
		head_overlay.pixel_z -= 5

		agent_overlays[FLOCK_AGENT_HEAD_LAYER] = head_overlay

	apply_overlay(FLOCK_AGENT_HEAD_LAYER)

/mob/living/basic/flock/agent/regenerate_icons()
	update_held_items()
	update_worn_head()
	update_inv_internal_storage()
