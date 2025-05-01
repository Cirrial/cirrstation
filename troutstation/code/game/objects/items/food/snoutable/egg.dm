/obj/item/food/egg/make_snoutable()
	AddComponent(/datum/component/snoutable, FALSE)

/obj/item/food/chocolateegg/make_snoutable()
	AddComponent(/datum/component/snoutable, FALSE)

/obj/item/food/eggsausage/make_snoutable()
	AddComponent(/datum/component/snoutable, TRUE, \
	"You alternate between egg and sausage as you slurp pieces up.", \
	"alternately slurps up the egg and sausage.")

/obj/item/food/omelette/make_snoutable()
	AddComponent(/datum/component/snoutable, FALSE)

/obj/item/food/benedict/make_snoutable()
	AddComponent(/datum/component/snoutable, FALSE)

/obj/item/food/eggwrap/make_snoutable()
	AddComponent(/datum/component/snoutable, FALSE, \
	"The egg wrap is surprisingly well-proportioned for your snout as you slurp it down.")

/obj/item/food/chawanmushi/make_snoutable()
	AddComponent(/datum/component/snoutable, FALSE) // there is nothing interesting I can think of to say about this
