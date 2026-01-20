/datum/hud/dextrous/flock_agent/New(mob/owner)
	..()
	var/atom/movable/screen/inventory/inv_box

	inv_box = new /atom/movable/screen/inventory(null, src)
	inv_box.name = "internal storage"
	inv_box.icon = ui_style
	inv_box.icon_state = "suit_storage"
	inv_box.screen_loc = ui_flock_storage
	inv_box.slot_id = ITEM_SLOT_DEX_STORAGE
	static_inventory += inv_box

	inv_box = new /atom/movable/screen/inventory(null, src)
	inv_box.name = "hat"
	inv_box.icon = ui_style
	inv_box.icon_state = "head"
	inv_box.screen_loc = ui_flock_head
	inv_box.slot_id = ITEM_SLOT_HEAD
	static_inventory += inv_box

	for(var/atom/movable/screen/inventory/inv in (static_inventory + toggleable_inventory))
		if(inv.slot_id)
			inv_slots[TOBITSHIFT(inv.slot_id) + 1] = inv
			inv.update_appearance()


/datum/hud/dextrous/flock_agent/persistent_inventory_update()
	if(!mymob)
		return
	var/mob/living/basic/flock/agent/flockmob = mymob

	if(hud_shown)
		if(!isnull(flockmob.internal_storage))
			flockmob.internal_storage.screen_loc = ui_flock_storage
			flockmob.client.screen += flockmob.internal_storage
		if(!isnull(flockmob.head))
			flockmob.head.screen_loc = ui_flock_head
			flockmob.client.screen += flockmob.head
	else
		flockmob.internal_storage?.screen_loc = null
		flockmob.head?.screen_loc = null

	..()
