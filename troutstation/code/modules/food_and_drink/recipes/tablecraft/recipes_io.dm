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
