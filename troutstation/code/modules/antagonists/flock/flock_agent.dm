/// High mobility nuisance antag with a focus on stealing things the crew would rather not lose (but not high value targets)
/datum/antagonist/flock_agent
	name = "\improper Flock Agent"
	antagpanel_category = ANTAG_GROUP_FLOCK
	pref_flag = ROLE_FLOCK_AGENT

	show_in_antagpanel = TRUE
	show_name_in_check_antagonists = TRUE
	show_to_ghosts = TRUE

	// TODO: CUSTOM ANTAG PANEL
	// ui_name = "AntagInfoFlock"
	suicide_cry = "FOR MY LORD!!"

/datum/antagonist/flock_agent/greet()
	. = ..()
	owner.announce_objectives()

/datum/antagonist/flock_agent/on_gain()
	. = ..()
	forge_objectives()

/datum/antagonist/flock_agent/get_preview_icon()
	return finish_preview_icon(icon('troutstation/icons/mob/simple/flock.dmi', "agent"))

/datum/antagonist/flock_agent/forge_objectives()
	var/datum/objective/flock_agent_objective/objective = new
	objective.owner = owner
	objectives += objective

/datum/objective/flock_agent_objective

/datum/objective/flock_agent_objective/New()
	explanation_text = "TODO: proper objectives."
	..()

/datum/objective/flock_agent_objective/check_completion()
	return owner.current && owner.current.stat != DEAD

