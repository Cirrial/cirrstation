/mob/living/proc/flock_talk(message, list/spans = list(), list/message_mods = list())

	spans |= SPAN_FLOCK

/datum/saymode/flock
	key = MODE_KEY_FLOCK
	mode = MODE_FLOCK
	allows_custom_say_emotes = TRUE

/datum/saymode/flock/can_be_used_by(mob/living/user)
	pass()
