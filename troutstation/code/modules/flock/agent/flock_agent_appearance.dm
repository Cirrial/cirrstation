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
		if(sprite_dir == EAST)
			head_overlay.pixel_w = 3
		else if(sprite_dir == WEST)
			head_overlay.pixel_w = -3
		else
			head_overlay.pixel_w = 0
		head_overlay.pixel_z -= 4

		agent_overlays[FLOCK_AGENT_HEAD_LAYER] = head_overlay

	apply_overlay(FLOCK_AGENT_HEAD_LAYER)

/mob/living/basic/flock/agent/regenerate_icons()
	update_held_items()
	update_worn_head()
	update_inv_internal_storage()
