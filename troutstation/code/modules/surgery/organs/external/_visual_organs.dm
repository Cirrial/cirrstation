/obj/item/organ/anteater_snout
	name = "anteater snout"
	desc = "Makes for an absolutely terrible trombone."
	icon = 'troutstation/icons/obj/medical/organs/organs.dmi'
	icon_state = "anteater_snout"

	zone = BODY_ZONE_HEAD
	slot = ORGAN_SLOT_EXTERNAL_ANTEATER_SNOUT

	preference = "feature_anteater_snout"
	external_bodyshapes = BODYSHAPE_SNOUTED

	restyle_flags = EXTERNAL_RESTYLE_FLESH

	bodypart_overlay = /datum/bodypart_overlay/mutant/snout/anteater

	organ_flags = parent_type::organ_flags | ORGAN_EXTERNAL

/datum/bodypart_overlay/mutant/snout/anteater/get_global_feature_list()
	return SSaccessories.anteater_snouts_list
