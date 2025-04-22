/datum/reagent/consumable/lime_spider
	name = "Lime Spider"
	description = "Oddly popular on Io, this float is a twist on the typical: instead of ice cream in a cola, it is in a lime soda. The name is derived from the foam produced, being reminiscent of a spider's web."
	color = "#95d68a"
	quality = DRINK_GOOD
	nutriment_factor = 3
	taste_description = "creamy lime"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/consumable/lime_spider/on_mob_metabolize(mob/living/affected_mob)
	. = ..()
	affected_mob.add_movespeed_modifier(/datum/movespeed_modifier/reagent/lime_spider)
