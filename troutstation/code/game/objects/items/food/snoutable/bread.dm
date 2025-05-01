/obj/item/food/breadslice/make_snoutable()
	AddComponent(/datum/component/snoutable, TRUE, \
	"You start tearing %FOOD apart, awkwardly shoving bits of bread into your snout.", \
	"tears %FOOD apart, awkwardly stuffing bits of it into %PRONOUN_their snout.")

/obj/item/food/butterbiscuit/make_snoutable()
	AddComponent(/datum/component/snoutable, TRUE, \
	"You crumble bits off %FOOD and lick them up.", \
	"crumbles %FOOD and licks it a bunch.")

/obj/item/food/raw_frenchtoast/make_snoutable()
	AddComponent(/datum/component/snoutable, TRUE, \
	"You awkwardly slurp up the raw egg and mushy bread.", \
	"licks up %FOOD's eggy gooey mess.")

/obj/item/food/frenchtoast/make_snoutable()
	AddComponent(/datum/component/snoutable, TRUE, \
	"You smush the delicious syrupy %FOOD into your snout.", \
	"smushes %FOOD into %PRONOUN_their snout.")

/obj/item/food/raw_breadstick/make_snoutable()
	AddComponent(/datum/component/snoutable, FALSE)

/obj/item/food/raw_croissant/make_snoutable()
	AddComponent(/datum/component/snoutable, FALSE)

/obj/item/food/croissant/make_snoutable()
	AddComponent(/datum/component/snoutable, TRUE, \
	"You crumble bits off %FOOD and lick them up.", \
	"crumbles %FOOD and licks it a bunch.")
