/obj/item/organ/tongue/anteater
	name = "anteater tongue"
	desc = "It's either an anteater tongue, or someone didn't can their bait tightly enough."
	icon = 'troutstation/icons/obj/medical/organs/organs.dmi'
	icon_state = "anteater_tongue"
	say_mod = "trills"
	languages_native = list(/datum/language/myrtongue)
	liked_foodtypes = BUGS | FRUIT | MEAT
	disliked_foodtypes = VEGETABLES | GROSS | CLOTH | RAW
	toxic_foodtypes = TOXIC
	emote_sounds = list(
		/datum/emote/living/scream::key = list(
			'troutstation/sound/mobs/humanoids/anteater/anteater_scream1.ogg',
			'troutstation/sound/mobs/humanoids/anteater/anteater_scream2.ogg',
			'troutstation/sound/mobs/humanoids/anteater/anteater_scream3.ogg',
			'troutstation/sound/mobs/humanoids/anteater/anteater_scream4.ogg',
			'troutstation/sound/mobs/humanoids/anteater/anteater_scream5.ogg',
			'troutstation/sound/mobs/humanoids/anteater/anteater_scream6.ogg',
			'troutstation/sound/mobs/humanoids/anteater/anteater_scream7.ogg',
		),
		/datum/emote/living/laugh::key = list(
			'troutstation/sound/mobs/humanoids/anteater/anteater_laugh1.ogg',
			'troutstation/sound/mobs/humanoids/anteater/anteater_laugh2.ogg',
			'troutstation/sound/mobs/humanoids/anteater/anteater_laugh3.ogg',
		),
		/datum/emote/living/carbon/hiss::key = 'troutstation/sound/mobs/humanoids/anteater/anteater_hiss.ogg',
		/datum/emote/living/deathgasp::key = 'troutstation/sound/mobs/humanoids/anteater/anteater_death.ogg',
	)

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
