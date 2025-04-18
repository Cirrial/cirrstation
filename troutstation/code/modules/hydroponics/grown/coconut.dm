// coconut, for space australia foods
/obj/item/seeds/coconut
	name = "coconut seed pack"
	desc = "These seeds grow into a palm tree."
	icon = 'troutstation/icons/obj/service/hydroponics/seeds.dmi'
	icon_state = "seed-coconut"
	species = "coconut"
	plantname = "Palm Tree"
	product = /obj/item/grown/coconut
	genes = list(/datum/plant_gene/trait/repeated_harvest)
	lifespan = 55
	endurance = 35
	yield = 2
	growthstages = 3
	growing_icon = 'troutstation/icons/obj/service/hydroponics/growing_fruits.dmi'
	reagents_add = list(/datum/reagent/consumable/nutriment/vitamin = 0.01, /datum/reagent/consumable/nutriment = 0.1, /datum/reagent/water = 0.08)

/obj/item/grown/coconut
	seed = /obj/item/seeds/coconut
	name = "coconut"
	desc = "Suspiciously bowling ball shaped."
	throw_drop_sound = 'troutstation/sound/effects/coconut_bonk.ogg'
	mob_throw_hit_sound = 'troutstation/sound/effects/coconut_bonk.ogg'
	hitsound = 'troutstation/sound/effects/coconut_bonk.ogg'
	attack_verb_continuous = list("bonks", "bops")
	attack_verb_simple = list("bonk", "bop")
	icon = 'troutstation/icons/obj/service/hydroponics/harvest.dmi'
	icon_state = "coconut"
	w_class = WEIGHT_CLASS_NORMAL
	throw_speed = 1
	throw_range = 5
	force = 3
	throwforce = 6
	var/strike_sound = 'troutstation/sound/effects/bowling_strike.ogg'

/obj/item/grown/coconut/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	. = ..()
	if(ishuman(hit_atom))
		var/mob/living/carbon/human/victim = hit_atom
		if(victim)
			var/zone = throwingdatum.target_zone
			if(zone == BODY_ZONE_HEAD)
				visible_message(span_warning("[victim] was hit on the head by a coconut!"))
			if(zone == BODY_ZONE_L_LEG || zone == BODY_ZONE_R_LEG)
				visible_message(span_warning("STRIKE!!"))
				playsound(src, strike_sound, YEET_SOUND_VOLUME, ignore_walls = FALSE, vary = sound_vary)
			victim.Stun(2 SECONDS)
	else if(isliving(hit_atom))
		var/mob/living/target = hit_atom
		target.Stun(2 SECONDS)
	if(prob(50))
		crack_coconut(src.loc)

/obj/item/grown/coconut/attack_self(mob/user)
	user.balloon_alert(user, "cracked the coconut")
	var/obj/item/food/cracked_coconut/cracked = crack_coconut(user)
	user.put_in_hands(cracked)

/obj/item/grown/coconut/proc/crack_coconut(atom/location)
	var/obj/item/food/cracked_coconut/cracked_coconut = new /obj/item/food/cracked_coconut(location)
	qdel(src)
	return cracked_coconut

/obj/item/food/cracked_coconut
	name = "cracked coconut"
	desc = "This coconut has been split asunder..."
	icon = 'troutstation/icons/obj/service/hydroponics/harvest.dmi'
	icon_state = "cracked_coconut"
	eat_time = 15 SECONDS
	foodtypes = FRUIT
	tastes = list("coconut" = 1)
	juice_typepath = /datum/reagent/consumable/coconut_milk

/obj/item/food/desiccated_coconut
	name = "desiccated coconut"
	desc = "Thinly shredded coconut."
	icon = 'troutstation/icons/obj/food/io_foods.dmi'
	icon_state = "desiccated_coconut"
	foodtypes = FRUIT
	tastes = list("coconut" = 1)

/datum/food_processor_process/coconut
	input = /obj/item/food/cracked_coconut
	output = /obj/item/food/desiccated_coconut
	food_multiplier = 3
