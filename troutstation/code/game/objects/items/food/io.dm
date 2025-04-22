/obj/item/food/space_shuttle_jelly
	name = "space shuttle jelly"
	desc = "I like Space Shuttle Jelly, Space Shuttle Jelly for me. \nI like it for dinner, I like it for tea, a little each day is a good recipe. \nThe quality’s high as the name will imply, and it’s made from pure fruits, one more good reason why- \nI like Space Shuttle Jelly, Space Shuttle Jelly for me."
	icon = 'troutstation/icons/obj/food/io.dmi'
	icon_state = "space_shuttle_jelly"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/sugar = 3,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	tastes = list("sugar" = 1, "strawberry" = 2)
	foodtypes = SUGAR|FRUIT
	w_class = WEIGHT_CLASS_NORMAL
	crafting_complexity = FOOD_COMPLEXITY_2
	venue_value = FOOD_PRICE_CHEAP

/obj/item/food/raw_dim_sim
	name = "raw dim sim"
	desc = "A raw meat and cabbage filled dumpling. Cook this baby up!"
	icon = 'troutstation/icons/obj/food/io.dmi'
	icon_state = "raw_dim_sim"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 1,
		/datum/reagent/consumable/nutriment/protein = 2,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	tastes = list("meat" = 3, "cabbage" = 2, "seasoning" = 1)
	foodtypes = RAW|GRAIN|MEAT|VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3
	food_flags = FOOD_FINGER_FOOD

/obj/item/food/raw_dim_sim/make_microwaveable()
	AddElement(/datum/element/microwavable, /obj/item/food/dim_sim)

/obj/item/food/dim_sim
	name = "dim sim"
	desc = "A meal invented by a Martian immigrant on Io, inspired by food back home. A fried dumpling full of meat, cabbage and seasonings. Goes well with soy sauce!"
	icon = 'troutstation/icons/obj/food/io.dmi'
	icon_state = "dim_sim"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("meat" = 3, "cabbage" = 2, "seasoning" = 1)
	foodtypes = GRAIN|MEAT|VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3
	venue_value = FOOD_PRICE_CHEAP
	food_flags = FOOD_FINGER_FOOD

/obj/item/food/democracy_sausage
	name = "democracy sausage"
	desc = "It's compulsory to vote on Io, but stands selling these \"Democracy\" sausage sandwiches outside polling stations help draw in vote dodgers and raise money."
	icon = 'troutstation/icons/obj/food/io.dmi'
	icon_state = "democracy_sausage"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 5,
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("meat" = 1, "ketchup" = 1)
	bite_consumption = 4
	foodtypes = GRAIN|MEAT|VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2
	venue_value = FOOD_PRICE_CHEAP
	food_flags = FOOD_FINGER_FOOD





// for slicing lamingtons, when coconuts are added
// /obj/item/food/lamington/make_processable()
	// AddElement(/datum/element/processable, TOOL_KNIFE, /obj/item/food/lamington_slice, 4, 3 SECONDS, table_required = TRUE, screentip_verb = "Slice")

// /obj/item/food/JC_lamington/make_processable()
	// AddElement(/datum/element/processable, TOOL_KNIFE, /obj/item/food/JC_lamington_slice, 4, 3 SECONDS, table_required = TRUE, screentip_verb = "Slice")
