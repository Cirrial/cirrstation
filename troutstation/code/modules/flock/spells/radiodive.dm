#define RADIODIVE_BROADCASTING 1
#define RADIODIVE_LISTENING 2

/datum/action/cooldown/spell/jaunt/radiodive
	name = "Radiodive"
	desc = "Allows you to convert yourself into a signal and dive into signal-space. \
		You can only enter signal-space from radio devices that are both on and listening, \
		and you can only exit signal-space from radio devices that are on and broadcasting. \
		Signal integrity will self-correct overtime, slowly healing you."
	// todo: fix this shit
	background_icon_state = "bg_heretic"
	overlay_icon_state = "bg_heretic_border"
	button_icon = 'icons/mob/actions/actions_minor_antag.dmi'
	button_icon_state = "ninja_cloak"

	spell_requirements = NONE
	jaunt_type = /obj/effect/dummy/phased_mob/blood

	/// Radius we'll check for radio devices in
	var/radio_radius = 2
	/// Time it takes to dive into signal-space / enter jaunt
	var/phase_out_time = 1.5 SECONDS // using mirrorwalk as an example
	/// Time it takes to emerge from signal-space / exit jaunt
	var/phase_in_time = 2 SECONDS

/datum/action/cooldown/spell/jaunt/radiodive/Grant(mob/grant_to)
	. = ..()
	RegisterSignal(grant_to, COMSIG_MOVABLE_MOVED, PROC_REF(update_status_on_signal))

/datum/action/cooldown/spell/jaunt/radiodive/Remove(mob/remove_from)
	. = ..()
	UnregisterSignal(remove_from, COMSIG_MOVABLE_MOVED)

/datum/action/cooldown/spell/jaunt/radiodive/can_cast_spell(feedback = TRUE)
	. = ..()
	if(!.)
		return FALSE

	var/we_are_phasing = is_jaunting(owner)
	var/required_radio_mode = we_are_phasing ? RADIODIVE_BROADCASTING : RADIODIVE_LISTENING
	var/turf/owner_turf = get_turf(owner)
	var/obj/item/radio/nearby_radio = find_nearby_radio(owner_turf, radio_radius, required_radio_mode)
	if(isnull(nearby_radio))
		if(feedback)
			to_chat(owner, span_warning("There are no functional radios currently [we_are_phasing ? "transmitting":"receiving"] any signals nearby!"))
		return FALSE

	if(owner_turf.is_blocked_turf(exclude_mobs = TRUE))
		if(feedback)
			to_chat(owner, span_warning("Something is blocking you from [we_are_phasing ? "surfacing from":"diving into"] signal-space here!"))
		return FALSE

	return TRUE

/// Find a nearby radio that matches the mode we're looking for.
/// Returns null if none.
/datum/action/cooldown/spell/jaunt/radiodive/proc/find_nearby_radio(turf/origin, radio_radius, radio_mode)
	for(var/obj/item/radio/radio in range(radio_radius, origin))
		if(radio.is_on())
			switch(radio_mode)
				if(RADIODIVE_BROADCASTING)
					if(radio.get_broadcasting())
						return radio
				if(RADIODIVE_LISTENING)
					if(radio.get_listening())
						return radio
	return null

/datum/action/cooldown/spell/jaunt/radiodive/cast(mob/living/cast_on)
	. = ..()
	var/we_are_phasing = is_jaunting(owner)
	var/required_radio_mode = we_are_phasing ? RADIODIVE_BROADCASTING : RADIODIVE_LISTENING
	var/obj/item/radio/nearby_radio = find_nearby_radio(get_turf(owner), radio_radius, required_radio_mode)
	do_radiodive(nearby_radio, cast_on)

/datum/action/cooldown/spell/jaunt/radiodive/proc/do_radiodive(obj/item/radio/radio, mob/living/jaunter)
	if(is_jaunting(jaunter))
		. = try_exit_jaunt(radio, jaunter)
	else
		. = try_enter_jaunt(radio, jaunter)

	if(!.)
		reset_spell_cooldown()
		to_chat(jaunter, span_warning("You are unable to radiodive!"))

/datum/action/cooldown/spell/jaunt/radiodive/proc/try_enter_jaunt(obj/item/radio/radio, mob/living/jaunter)
	if(phase_out_time > 0 SECONDS)
		radio.visible_message(span_warning("[jaunter] shimmers and begins to dissolve into [radio]!"))
		if(!do_after(jaunter, phase_out_time, target = radio))
			return FALSE

	// The actual turf we enter
	var/turf/jaunt_turf = get_turf(radio)

	// Begin the jaunt
	ADD_TRAIT(jaunter, TRAIT_NO_TRANSFORM, REF(src))
	var/obj/effect/dummy/phased_mob/holder = enter_jaunt(jaunter, jaunt_turf)
	if(!holder)
		REMOVE_TRAIT(jaunter, TRAIT_NO_TRANSFORM, REF(src))
		return FALSE

	RegisterSignal(holder, COMSIG_MOVABLE_MOVED, PROC_REF(update_status_on_signal))

	radio.visible_message(span_warning("[jaunter] dissipates into [radio]!"))
	playsound(jaunter, 'sound/effects/magic/ethereal_enter.ogg', 50, TRUE, -1)
	jaunter.extinguish_mob()

	REMOVE_TRAIT(jaunter, TRAIT_NO_TRANSFORM, REF(src))
	return TRUE

/datum/action/cooldown/spell/jaunt/radiodive/proc/try_exit_jaunt(obj/item/radio/radio, mob/living/jaunter)
	if(HAS_TRAIT(jaunter, TRAIT_NO_TRANSFORM))
		to_chat(jaunter, span_warning("You're still decorporealizing!!"))
		return FALSE

	if(phase_in_time > 0 SECONDS)
		radio.visible_message(span_warning("[radio] starts to emit strange noises..."))
		if(!do_after(jaunter, phase_in_time, target = radio))
			return FALSE

	if(!exit_jaunt(jaunter, get_turf(radio)))
		return FALSE

	radio.visible_message(span_boldwarning("[jaunter] emerges in a shower of lights from [radio]!"))
	return TRUE

/datum/action/cooldown/spell/jaunt/radiodive/on_jaunt_exited(obj/effect/dummy/phased_mob/jaunt, mob/living/unjaunter)
	UnregisterSignal(jaunt, COMSIG_MOVABLE_MOVED)
	// TODO: maybe do some sort of effect here
	playsound(unjaunter, 'sound/effects/magic/ethereal_exit.ogg', 50, TRUE, -1)
	return ..()

#undef RADIODIVE_BROADCASTING
#undef RADIODIVE_LISTENING
