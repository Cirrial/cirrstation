/datum/crafting_recipe/food/space_shuttle_jelly
	name = "Space Shuttle Jelly"
	reqs = list(
		/datum/reagent/consumable/berryjuice = 10,
		/datum/reagent/consumable/sugar = 5,
		/datum/reagent/water = 10,
	)
	result = /obj/item/food/space_shuttle_jelly
	category = CAT_IO


// for raw dim sims to regular:
//	removed_foodtypes = RAW
//	added_foodtypes = FRIED

/datum/crafting_recipe/food/raw_dim_sim
	name = "raw dim sim"
	reqs = list(
		/obj/item/food/doughslice = 1,
		/obj/item/food/raw_meatball = 1,
		/obj/item/food/grown/cabbage = 1,
		/datum/reagent/consumable/salt = 2,
		/datum/reagent/consumable/blackpepper = 2,
	)
	result = /obj/item/food/raw_dim_sim
	category = CAT_IO

/datum/crafting_recipe/food/microwave/dim_sim
	reqs = list(/obj/item/food/raw_dim_sim = 1)
	result = /obj/item/food/dim_sim
	removed_foodtypes = RAW
	category = CAT_IO

/datum/crafting_recipe/food/democracy_sausage
	name = "democracy sausage"
	reqs = list(
		/obj/item/food/sausage = 1,
		/obj/item/food/onion_slice = 2,
		/datum/reagent/consumable/ketchup = 5,
		/obj/item/food/breadslice/plain = 1,
	)
	result = /obj/item/food/democracy_sausage
	category = CAT_IO

/datum/crafting_recipe/food/lamington
	name = "lamington"
	reqs = list(
		/obj/item/food/cake/plain = 1,
		/obj/item/food/desiccated_coconut = 2,
		/obj/item/food/chocolatebar = 1
	)
	result = /obj/item/food/lamington
	removed_foodtypes = JUNKFOOD
	category = CAT_IO

/datum/crafting_recipe/food/knife/lamington_slice
	reqs = list(/datum/crafting_recipe/food/lamington = 1)
	result = /obj/item/food/lamington_slice
	category = CAT_IO

/datum/crafting_recipe/food/JC_lamington
	name = "jam and cream lamington"
	reqs = list(
		/obj/item/food/lamington = 1,
		/datum/reagent/consumable/cream = 5,
		/datum/reagent/consumable/berryjuice = 5,
	)
	result = /obj/item/food/JC_lamington
	category = CAT_IO

/datum/crafting_recipe/food/knife/JC_lamington_slice
	reqs = list(/datum/crafting_recipe/food/JC_lamington = 1)
	result = /obj/item/food/JC_lamington_slice
	category = CAT_IO

/datum/crafting_recipe/food/vegemite_toast
	name = "\improper Vegemite toast"
	reqs = list(
		/datum/reagent/consumable/vegemite = 10,
		/obj/item/food/griddle_toast = 1,
	)
	result = /obj/item/food/vegemite_toast
	category = CAT_IO

/datum/crafting_recipe/food/cheese_vegemite_scroll
	name = "cheese and Vegemite scroll"
	reqs = list(
		/datum/reagent/consumable/vegemite = 5,
		/obj/item/food/pastrybase = 1,
		/obj/item/food/cheese/wedge = 1,
	)
	result = /obj/item/food/cheese_vegemite_scroll
	category = CAT_IO

/datum/crafting_recipe/food/fairy_bread
	name = "fairy bread"
	reqs = list(
		/obj/item/food/butterslice = 1,
		/datum/reagent/consumable/sprinkles = 2,
		/obj/item/food/breadslice/plain = 1,
	)
	result = /obj/item/food/fairy_bread
	removed_foodtypes = JUNKFOOD
	category = CAT_IO

/datum/crafting_recipe/food/golden_gaytime
	name = "\improper Golden Gaytime"
	reqs = list(
		/obj/item/popsicle_stick = 1,
		/datum/reagent/consumable/caramel = 4,
		/datum/reagent/consumable/ice = 2,
		/datum/reagent/consumable/cream = 2,
		/datum/reagent/consumable/vanilla = 2,
		/obj/item/food/chocolatebar = 1,
		/datum/reagent/consumable/sugar = 2
	)
	result = /obj/item/food/popsicle/golden_gaytime
	added_foodtypes = DAIRY
	removed_foodtypes = JUNKFOOD
	category = CAT_IO

/datum/crafting_recipe/food/pie_floater
	name = "pie floater"
	reqs = list(
		/datum/reagent/consumable/nutriment/soup/pea = 30,
		/obj/item/food/pie/meatpie = 1,
		/datum/reagent/consumable/ketchup = 5,
		/obj/item/reagent_containers/cup/bowl = 1,
	)
	result = /obj/item/food/pie_floater
	category = CAT_IO
