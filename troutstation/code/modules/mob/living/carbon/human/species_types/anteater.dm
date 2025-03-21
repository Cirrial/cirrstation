/datum/species/anteater
	name = "\improper Anteater"
	plural_form = "Anteaters"
	id = SPECIES_ANTEATER
	inherent_biotypes = MOB_ORGANIC | MOB_HUMANOID

	mutant_organs = list(
		/obj/item/organ/anteater_snout = "Big",
	)
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_PRIDE | MIRROR_MAGIC | RACE_SWAP | ERT_SPAWN | SLIME_EXTRACT
	payday_modifier = 1.0

	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/anteater,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/anteater,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/anteater,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/anteater,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/anteater,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/anteater,
	)


/datum/species/anteater/on_species_gain(mob/living/carbon/human/human_who_gained_species, datum/species/old_species, pref_load, regenerate_icons)
	. = ..()

/datum/species/anteater/on_species_loss(mob/living/carbon/human/C, datum/species/new_species, pref_load)
	. = ..()

/datum/species/anteater/randomize_features()
	var/list/features = ..()
	return features

// sounds

/datum/species/anteater/get_scream_sound(mob/living/carbon/human/anteater)
	if(anteater.physique == MALE)
		if(prob(1))
			return 'sound/mobs/humanoids/human/scream/wilhelm_scream.ogg'
		return pick(
			'sound/mobs/humanoids/human/scream/malescream_1.ogg',
			'sound/mobs/humanoids/human/scream/malescream_2.ogg',
			'sound/mobs/humanoids/human/scream/malescream_3.ogg',
			'sound/mobs/humanoids/human/scream/malescream_4.ogg',
			'sound/mobs/humanoids/human/scream/malescream_5.ogg',
			'sound/mobs/humanoids/human/scream/malescream_6.ogg',
		)

	return pick(
		'sound/mobs/humanoids/human/scream/femalescream_1.ogg',
		'sound/mobs/humanoids/human/scream/femalescream_2.ogg',
		'sound/mobs/humanoids/human/scream/femalescream_3.ogg',
		'sound/mobs/humanoids/human/scream/femalescream_4.ogg',
		'sound/mobs/humanoids/human/scream/femalescream_5.ogg',
	)

/datum/species/anteater/get_cough_sound(mob/living/carbon/human/anteater)
	if(anteater.physique == FEMALE)
		return pick(
			'sound/mobs/humanoids/human/cough/female_cough1.ogg',
			'sound/mobs/humanoids/human/cough/female_cough2.ogg',
			'sound/mobs/humanoids/human/cough/female_cough3.ogg',
			'sound/mobs/humanoids/human/cough/female_cough4.ogg',
			'sound/mobs/humanoids/human/cough/female_cough5.ogg',
			'sound/mobs/humanoids/human/cough/female_cough6.ogg',
		)
	return pick(
		'sound/mobs/humanoids/human/cough/male_cough1.ogg',
		'sound/mobs/humanoids/human/cough/male_cough2.ogg',
		'sound/mobs/humanoids/human/cough/male_cough3.ogg',
		'sound/mobs/humanoids/human/cough/male_cough4.ogg',
		'sound/mobs/humanoids/human/cough/male_cough5.ogg',
		'sound/mobs/humanoids/human/cough/male_cough6.ogg',
	)

/datum/species/anteater/get_cry_sound(mob/living/carbon/human/anteater)
	if(anteater.physique == FEMALE)
		return pick(
			'sound/mobs/humanoids/human/cry/female_cry1.ogg',
			'sound/mobs/humanoids/human/cry/female_cry2.ogg',
		)
	return pick(
		'sound/mobs/humanoids/human/cry/male_cry1.ogg',
		'sound/mobs/humanoids/human/cry/male_cry2.ogg',
		'sound/mobs/humanoids/human/cry/male_cry3.ogg',
	)


/datum/species/anteater/get_sneeze_sound(mob/living/carbon/human/anteater)
	if(anteater.physique == FEMALE)
		return 'sound/mobs/humanoids/human/sneeze/female_sneeze1.ogg'
	return 'sound/mobs/humanoids/human/sneeze/male_sneeze1.ogg'

/datum/species/anteater/get_laugh_sound(mob/living/carbon/human/anteater)
	if(anteater.physique == FEMALE)
		return 'sound/mobs/humanoids/human/laugh/womanlaugh.ogg'
	return pick(
		'sound/mobs/humanoids/human/laugh/manlaugh1.ogg',
		'sound/mobs/humanoids/human/laugh/manlaugh2.ogg',
	)

/datum/species/anteater/get_sigh_sound(mob/living/carbon/human/anteater)
	if(anteater.physique == FEMALE)
		return SFX_FEMALE_SIGH
	return SFX_MALE_SIGH

/datum/species/anteater/get_sniff_sound(mob/living/carbon/human/anteater)
	if(anteater.physique == FEMALE)
		return 'sound/mobs/humanoids/human/sniff/female_sniff.ogg'
	return 'sound/mobs/humanoids/human/sniff/male_sniff.ogg'

/datum/species/anteater/get_snore_sound(mob/living/carbon/human/anteater)
	if(anteater.physique == FEMALE)
		return SFX_SNORE_FEMALE
	return SFX_SNORE_MALE

/datum/species/anteater/get_hiss_sound(mob/living/carbon/human/anteater)
	return 'sound/mobs/humanoids/human/hiss/human_hiss.ogg'

// descriptions

/datum/species/anteater/get_physical_attributes()
	return "todo"

/datum/species/anteater/get_species_description()
	return "todo"

/datum/species/anteater/get_species_lore()
	return list(
		"Shawn please add details."
	)

/datum/species/anteater/create_pref_unique_perks()
	var/list/to_add = list()
	return to_add
