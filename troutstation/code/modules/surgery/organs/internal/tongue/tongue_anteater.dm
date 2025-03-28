/obj/item/organ/tongue/anteater
	name = "anteater tongue"
	desc = "It's either an anteater tongue, or someone didn't can their bait tightly enough."
	icon = 'troutstation/icons/obj/medical/organs/organs.dmi'
	icon_state = "anteater_tongue"
	say_mod = "trills"
	liked_foodtypes = BUGS | FRUIT | MEAT
	disliked_foodtypes = VEGETABLES | GROSS | CLOTH | RAW
	toxic_foodtypes = TOXIC

/obj/item/organ/tongue/anteater/get_possible_languages()
	return list(
		/datum/language/common,
		/datum/language/uncommon,
		/datum/language/spinwarder,
		/datum/language/draconic,
		/datum/language/codespeak,
		/datum/language/monkey,
		/datum/language/narsie,
		/datum/language/beachbum,
		/datum/language/aphasia,
		/datum/language/piratespeak,
		/datum/language/moffic,
		/datum/language/sylvan,
		/datum/language/shadowtongue,
		/datum/language/terrum,
		/datum/language/nekomimetic,
		/datum/language/myrtongue,
	)
