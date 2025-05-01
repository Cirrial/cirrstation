/// Atoms that can be shoved up a small snout.
/datum/element/snoutable
	element_flags = ELEMENT_BESPOKE
	argument_hash_start_idx = 2
	/// Can this item be eaten by a snout?
	var/snoutable = FALSE
	/// Does this food item get eaten really conspicuously? If so, it should be announced to everyone around
	var/conspicuously_eating = FALSE
	/// Message shown to the eater when they eat this item
	var/default_eater_message = "You stuff %FOOD into your snout."
	var/eater_message
	/// Message shown to those around the eater when they eat this item if it's visibly eaten
	var/default_eating_message = "stuffs %FOOD into %PRONOUN_their snout."
	var/eating_message

/datum/element/snoutable/Attach(datum/target, var/is_snoutable = FALSE, var/is_conspicuously_eating = FALSE, var/new_eater_message, var/new_eating_message)
	. = ..()
	if(!isitem(target))
		return ELEMENT_INCOMPATIBLE

	snoutable = is_snoutable
	conspicuously_eating = is_conspicuously_eating
	eater_message = new_eater_message || default_eater_message
	eating_message = new_eating_message || default_eating_message

	RegisterSignal(target, COMSIG_CARBON_ATTEMPT_EAT, PROC_REF(try_eating))
	RegisterSignal(target, COMSIG_ATOM_EXAMINE, PROC_REF(on_examine))

/datum/element/snoutable/Detach(datum/source)
	UnregisterSignal(source, list(COMSIG_CARBON_ATTEMPT_EAT, COMSIG_ATOM_EXAMINE))
	return ..()

/// Signal proc for [COMSIG_CARBON_ATTEMPT_EAT].
/// Handles the eating part.
/datum/element/snoutable/proc/try_eating(mob/living/carbon/source, atom/eating)
	SIGNAL_HANDLER

	if(!HAS_TRAIT(source, TRAIT_TINY_SNOUT))
		return // you don't have a snout so you don't care

	if(!snoutable)
		source.balloon_alert(source, "won't fit in your snout!")
		return COMSIG_CARBON_BLOCK_EAT

	var/food_desc = eating.name
	var/eater_desc_message = REPLACE_PRONOUNS(replacetext(eater_message, "%FOOD", food_desc), source)
	var/eating_desc_message = "[source] [REPLACE_PRONOUNS(replacetext(eating_message, "%FOOD", food_desc), source)]"

	if(conspicuously_eating)
		source.visible_message(span_notice(eating_desc_message),
		span_notice(eater_desc_message),
		span_notice("You hear an anteater struggling with food."),
		visible_message_flags = ALWAYS_SHOW_SELF_MESSAGE)
	else
		to_chat(source, span_notice(eater_desc_message))


/// Signal proc for [COMSIG_ATOM_EXAMINE].
/// Lets examiners know the item fits into a snout if they have a snout, or if they're a chef.
/datum/element/snoutable/proc/on_examine(atom/source, mob/user, list/examine_list)
	SIGNAL_HANDLER

	if(HAS_TRAIT(user, TRAIT_TINY_SNOUT))
		if(snoutable)
			examine_list += span_nicegreen("It will fit into your snout!")
		else
			examine_list += span_notice("It won't fit into your snout...")
	else if(snoutable)
		var/obj/item/organ/liver/liver = user.get_organ_slot(ORGAN_SLOT_LIVER)
		if(liver && HAS_TRAIT(liver, TRAIT_CULINARY_METABOLISM)) // goddamn liver traits
			examine_list += span_notice("It will fit into a narrow snout, which is great for anteaters.")
