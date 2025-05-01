/obj/item/food/bait/worm/make_snoutable()
	AddComponent(/datum/component/snoutable, FALSE, "You slurp the worm up.")

/obj/item/food/bait/natural/make_snoutable()
	AddComponent(/datum/component/snoutable, FALSE, "You slurp the bait up.")

/obj/item/food/bait/doughball/synthetic/super/make_snoutable()
	return

/obj/item/food/bait/doughball/synthetic/unconsumable/make_snoutable()
	return
