/proc/generate_anteater_side_shot(datum/sprite_accessory/sprite_accessory, key, include_snout = TRUE)
	var/static/datum/universal_icon/anteater
	var/static/datum/universal_icon/anteater_with_snout

	if (isnull(anteater))
		anteater = uni_icon('troutstation/icons/mob/human/species/anteater/bodyparts.dmi', "anteater_head", EAST)
		var/datum/universal_icon/eyes = uni_icon('icons/mob/human/human_face.dmi', "eyes_l", EAST)
		eyes.blend_color(COLOR_GRAY, ICON_MULTIPLY)
		anteater.blend_icon(eyes, ICON_OVERLAY)

		anteater_with_snout = anteater.copy()
		anteater_with_snout.blend_icon(uni_icon('troutstation/icons/mob/human/species/anteater/anteater_snouts.dmi', "m_snout_big_ADJ", EAST), ICON_OVERLAY)

	var/datum/universal_icon/final_icon = include_snout ? anteater_with_snout.copy() : anteater.copy()

	if (!isnull(sprite_accessory) && sprite_accessory.icon_state != SPRITE_ACCESSORY_NONE)
		var/datum/universal_icon/accessory_icon = uni_icon(sprite_accessory.icon, "m_[key]_[sprite_accessory.icon_state]_ADJ", EAST)
		final_icon.blend_icon(accessory_icon, ICON_OVERLAY)

	final_icon.crop(11, 20, 23, 32)
	final_icon.scale(32, 32)
	final_icon.blend_color(COLOR_VIBRANT_LIME, ICON_MULTIPLY)

	return final_icon

/datum/preference/choiced/anteater_snout
	savefile_key = "feature_anteater_snout"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_FEATURES
	main_feature_name = "Snout"
	should_generate_icons = TRUE
	relevant_external_organ = /obj/item/organ/anteater_snout

/datum/preference/choiced/anteater_snout/init_possible_values()
	return assoc_to_keys_features(SSaccessories.anteater_snouts_list)

/datum/preference/choiced/anteater_snout/icon_for(value)
	return generate_anteater_side_shot(SSaccessories.anteater_snouts_list[value], "snout", include_snout = FALSE)

/datum/preference/choiced/anteater_snout/apply_to_human(mob/living/carbon/human/target, value)
	target.dna.features["anteater_snout"] = value

