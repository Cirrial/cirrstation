/obj/item/food/dough/make_snoutable()
	AddComponent(/datum/component/snoutable, FALSE)

/obj/item/food/doughslice/make_snoutable()
	AddComponent(/datum/component/snoutable, FALSE)

/obj/item/food/cakebatter/make_snoutable()
	AddComponent(/datum/component/snoutable, FALSE)

/obj/item/food/piedough/make_snoutable()
	AddComponent(/datum/component/snoutable, FALSE)

/obj/item/food/rawpastrybase/make_snoutable()
	AddComponent(/datum/component/snoutable, FALSE)

/obj/item/food/pastrybase/make_snoutable()
	AddComponent(/datum/component/snoutable, TRUE, \
	"You crumble bits off %FOOD and lick them up.", \
	"crumbles %FOOD and licks it a bunch.")
