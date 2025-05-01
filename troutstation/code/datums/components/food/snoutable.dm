/// Atoms that can be shoved up a small snout.
/datum/component/snoutable
	dupe_mode = COMPONENT_DUPE_UNIQUE
	/// Does this food item get eaten really conspicuously? If so, it should be announced to everyone around
	var/conspicuously_eating = FALSE
	/// Message shown to the eater when they eat this item
	var/default_eater_message = "You stuff \the %FOOD into your snout."
	var/eater_message
	/// Message shown to those around the eater when they eat this item if it's visibly eaten
	var/default_eating_message = "stuffs \the %FOOD into %PRONOUN_their snout."
	var/eating_message

/datum/component/snoutable/Initialize(
	conspicuously_eating = FALSE,
	eater_message,
	new_eating_message
)
	if(!isitem(parent))
		return COMPONENT_INCOMPATIBLE

	src.conspicuously_eating = conspicuously_eating
	src.eater_message = eater_message || default_eater_message
	src.eating_message = eating_message || default_eating_message

/datum/component/snoutable/RegisterWithParent()
	RegisterSignal(parent, COMSIG_ATOM_EXAMINE, PROC_REF(on_examine))

/datum/component/snoutable/UnregisterFromParent()
	UnregisterSignal(parent, list(COMSIG_ATOM_EXAMINE))

/// Announce to the eater (and maybe others) that they're eating a thing they're struggling with.
/datum/component/snoutable/proc/announce_snout_eating(mob/living/carbon/source, atom/food)
	var/eater_desc_message = REPLACE_PRONOUNS(replacetext(eater_message, "%FOOD", "[food]"), source)
	var/eating_desc_message = "[source] [REPLACE_PRONOUNS(replacetext(eating_message, "%FOOD", "[food]"), source)]"

	if(conspicuously_eating)
		source.visible_message(span_notice(eating_desc_message),
		span_notice(eater_desc_message),
		span_notice("You hear an anteater struggling with food."),
		visible_message_flags = ALWAYS_SHOW_SELF_MESSAGE)
	else
		source.show_message(span_notice(eater_desc_message), MSG_VISUAL, span_notice("You fumble \the [food] into your snout."))

/// Signal proc for [COMSIG_ATOM_EXAMINE].
/// Lets examiners know the item fits into a snout if they have a snout, or if they're a chef.
/datum/component/snoutable/proc/on_examine(atom/source, mob/user, list/examine_list)
	SIGNAL_HANDLER

	if(HAS_TRAIT(user, TRAIT_TINY_SNOUT))
		examine_list += span_nicegreen("It will fit into your snout!")
	else
		var/obj/item/organ/liver/liver = user.get_organ_slot(ORGAN_SLOT_LIVER)
		if(liver && HAS_TRAIT(liver, TRAIT_CULINARY_METABOLISM)) // goddamn liver traits
			examine_list += span_notice("It will fit into a narrow snout, which is great for anteaters.")
