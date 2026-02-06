/// Just a bunch of misc items mostly for agents to create with their resources

/obj/item/clothing/head/hats/flock_chameleon
	name = "adaptive hat"
	desc = "It looks more like a sad melon, but this is apparently the pinnacle of alien hat technology."
	icon_state = "flock"
	icon = 'troutstation/icons/obj/clothing/head/hats.dmi'
	worn_icon = 'troutstation/mob/clothing/head/hats.dmi'

/obj/item/clothing/head/hats/flock_chameleon/examine(mob/user)
	. = ..()
	. += span_notice("Use it on a hat to take that hat's appearance.")
