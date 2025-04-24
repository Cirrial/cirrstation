// coconut, for space australia foods
/obj/item/seeds/coconut
	name = "coconut seed pack"
	desc = "These seeds grow into a palm tree."
	icon = 'troutstation/icons/obj/service/hydroponics/seeds.dmi'
	icon_state = "seed-coconut"
	species = "coconut"
	plantname = "Palm Tree"
	product = /obj/item/food/grown/coconut
	genes = list(/datum/plant_gene/trait/repeated_harvest)
	lifespan = 55
	endurance = 35
	yield = 2
	growthstages = 3
	growing_icon = 'troutstation/icons/obj/service/hydroponics/growing_fruits.dmi'
	reagents_add = list(/datum/reagent/consumable/nutriment/vitamin = 0.01, /datum/reagent/consumable/nutriment = 0.1, /datum/reagent/water = 0.08)

/obj/item/food/grown/coconut
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
	food_reagents = list(
		/datum/reagent/water = 2,
		/datum/reagent/consumable/nutriment/vitamin = 0.6,
		/datum/reagent/consumable/nutriment = 2,
	)
	eat_time = 30 SECONDS // nice work gnawing that coconut you dummy
	foodtypes = FRUIT
	tastes = list("coconut" = 1)
	juice_typepath = /datum/reagent/consumable/coconut_milk
	throw_speed = 1
	throw_range = 6
	force = 2
	throwforce = 4
	var/strike_sound = 'troutstation/sound/effects/bowling_strike.ogg'
	var/cracked = FALSE

/obj/item/food/grown/coconut/make_processable()
	AddElement(/datum/element/processable_callback, TOOL_ROLLINGPIN, PROC_REF(crack_coconut), 3 SECONDS, table_required = TRUE, screentip_verb = "Crack")

/obj/item/food/grown/coconut/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	. = ..()
	if(cracked)
		return
	if(ishuman(hit_atom))
		var/mob/living/carbon/human/victim = hit_atom
		if(victim)
			var/zone = throwingdatum.target_zone
			if(zone == BODY_ZONE_HEAD)
				visible_message(span_warning("[victim] was hit on the head by a coconut!"))
				victim.Stun(2 SECONDS)
				victim.Knockdown(2 SECONDS)
			if(zone == BODY_ZONE_L_LEG || zone == BODY_ZONE_R_LEG)
				visible_message(span_warning("STRIKE!!"))
				playsound(src, strike_sound, YEET_SOUND_VOLUME, ignore_walls = FALSE, vary = sound_vary)
				victim.Stun(2 SECONDS)
				victim.Knockdown(2 SECONDS)
			victim.Stun(1 SECONDS)
	else if(isliving(hit_atom))
		var/mob/living/target = hit_atom
		target.Stun(2 SECONDS)
	if(prob(50))
		crack_coconut()

/obj/item/food/grown/coconut/proc/try_crack_coconut(mob/living/user)
	if(cracked)
		return
	user.balloon_alert(user, "cracked the coconut")
	crack_coconut()

/obj/item/food/grown/coconut/proc/crack_coconut()
	if(cracked)
		return
	RemoveElement(/datum/element/processable_callback, TOOL_ROLLINGPIN, PROC_REF(crack_coconut), 3 SECONDS, table_required = TRUE, screentip_verb = "Crack")
	name = "cracked coconut"
	desc = "This coconut has been split asunder..."
	icon_state = "cracked_coconut"
	force = 0
	throwforce = 0
	var/datum/component/edible/edible = src.GetComponent(/datum/component/edible)
	edible.eat_time = 5 SECONDS
	cracked = TRUE

/obj/item/food/desiccated_coconut
	name = "desiccated coconut"
	desc = "Thinly shredded coconut."
	icon = 'troutstation/icons/obj/food/io_foods.dmi'
	icon_state = "desiccated_coconut"
	w_class = WEIGHT_CLASS_TINY
	foodtypes = FRUIT
	tastes = list("coconut" = 1)

/datum/food_processor_process/coconut
	input = /obj/item/food/grown/coconut
	output = /obj/item/food/desiccated_coconut
	food_multiplier = 3
