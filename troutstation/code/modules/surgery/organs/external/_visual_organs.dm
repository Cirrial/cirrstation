/obj/item/organ/anteater_snout
	name = "anteater snout"
	desc = "Makes for an absolutely terrible trombone."
	icon = 'troutstation/icons/obj/medical/organs/organs.dmi'
	icon_state = "anteater_snout"

	zone = BODY_ZONE_HEAD
	slot = ORGAN_SLOT_EXTERNAL_ANTEATER_SNOUT

	preference = "feature_anteater_snout"
	// external_bodyshapes = BODYSHAPE_SNOUTED

	restyle_flags = EXTERNAL_RESTYLE_FLESH

	bodypart_overlay = /datum/bodypart_overlay/mutant/snout/anteater

	organ_flags = parent_type::organ_flags | ORGAN_EXTERNAL


/datum/bodypart_overlay/mutant/snout/anteater
	feature_key = "anteater_snout"

/datum/bodypart_overlay/mutant/snout/anteater/get_global_feature_list()
	return SSaccessories.anteater_snouts_list

// let's violate the whole "visual organ" thing and add some extra functionality

/obj/item/organ/anteater_snout/on_mob_insert(mob/living/carbon/organ_owner, special, movement_flags)
	. = ..()
	RegisterSignal(owner, COMSIG_CARBON_ATTEMPT_EAT, PROC_REF(try_eating))

/obj/item/organ/anteater_snout/on_mob_remove(mob/living/carbon/organ_owner, special, movement_flags)
	. = ..()
	UnregisterSignal(organ_owner, COMSIG_CARBON_ATTEMPT_EAT)

/obj/item/organ/anteater_snout/proc/try_eating(mob/living/carbon/source, atom/eating)
	SIGNAL_HANDLER
	// handle regular food items
	if(istype(eating, /obj/item/food))
		var/obj/item/food/food = eating
		if(food.w_class <= WEIGHT_CLASS_TINY)
			return
		if(food.food_flags & FOOD_FINGER_FOOD)
			return
	// maybe it has an edible component?
	if(istype(eating, /obj/item))
		var/obj/item/maybe_edible = eating
		var/datum/component/edible/edible = maybe_edible.GetComponent(/datum/component/edible)
		if(edible)
			if(maybe_edible.w_class <= WEIGHT_CLASS_TINY)
				return
			if(edible.food_flags & FOOD_FINGER_FOOD)
				return
	source.balloon_alert(source, "won't fit in your snout!")
	return COMSIG_CARBON_BLOCK_EAT
