#define FLOCK_OUTPOST_DEFAULT_ATMOS GAS_N2 + "=100;TEMP=200"
#define FLOCK_OUTPOST_VOID_LIGHT_COLOR "#ace5c6"
#define FLOCK_OUTPOST_LIGHT_COLOR "#b8ece4" // a very faint teal

// TEMPLATE DEFINITION STUFF
/datum/lazy_template/flock_outpost
	key = LAZY_TEMPLATE_KEY_FLOCK_OUTPOST
	map_name = "flock_outpost"

// AREAS
/area/centcom/flock_outpost
	name = "Flock Outpost"
	desc = "caw caw motherfucker"
	icon = 'troutstation/icons/area/areas_centcom.dmi'
	icon_state = "flock_outpost"
	requires_power = FALSE
	area_flags = NOTELEPORT
	static_lighting = TRUE
	base_lighting_alpha = 0
	default_gravity = STANDARD_GRAVITY
	flags_1 = NONE
	ambience_index = AMBIENCE_FLOCK

// TURFS
// Floors
/turf/open/floor/flock_outpost
	name = "resilient substrate"
	desc = "You are absolutely being watched."
	icon = 'troutstation/icons/turf/floors/flock_outpost_floor.dmi'
	icon_state = "flock_outpost_floor-255"
	base_icon_state = "flock_outpost_floor"
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = SMOOTH_GROUP_FLOCK_OUTPOST
	canSmoothWith = SMOOTH_GROUP_FLOCK_OUTPOST
	footstep = FOOTSTEP_FLOOR
	smoothing_junction = 255
	planetary_atmos = TRUE
	initial_gas_mix = FLOCK_OUTPOST_DEFAULT_ATMOS
	/// Icon for the emissive overlay
	var/emissive_icon = 'troutstation/icons/turf/floors/flock_outpost_floor_e.dmi'
	/// The alpha used for the emissive decal.
	var/emissive_alpha = 20
	/// Do we add an emissive decal at all?
	var/is_emissive = TRUE

/turf/open/floor/flock_outpost/Initialize(mapload)
	. = ..()
	if(is_emissive)
		AddElement(/datum/element/decal, emissive_icon, base_icon_state, dir, EMISSIVE_PLANE, null, emissive_alpha, null, smoothing_junction)

/turf/open/floor/flock_outpost/break_tile()
	return // unbreakable

/turf/open/floor/flock_outpost/burn_tile()
	return // unbreakable

/turf/open/floor/flock_outpost/plating
	name = "underwiring"
	desc = "Exposed nerve and tissue of the outpost superstructure. Strange for it to not be concealed."
	icon = 'troutstation/icons/turf/floors/flock_outpost.dmi'
	icon_state = "plating"
	smoothing_groups = null
	smoothing_flags = NONE
	canSmoothWith = null
	footstep = FOOTSTEP_PLATING
	is_emissive = FALSE

/turf/open/floor/flock_outpost/carpet
	name = "deep carpet"
	desc = "A nice soft carpet that feels better than it looks. The Lords have a little compassion, sometimes."
	icon = 'troutstation/icons/turf/floors/flock_outpost_carpet.dmi'
	icon_state = "flock_outpost_carpet-255"
	base_icon_state = "flock_outpost_carpet"
	smoothing_groups = SMOOTH_GROUP_CARPET_FLOCK_OUTPOST
	canSmoothWith = SMOOTH_GROUP_CARPET_FLOCK_OUTPOST
	footstep = FOOTSTEP_CARPET
	is_emissive = FALSE

/turf/open/floor/flock_outpost/light
	name = "bright glass"
	desc = "A bright surface to illuminate the way."
	icon = 'troutstation/icons/turf/floors/flock_outpost_light_floor.dmi'
	icon_state = "flock_outpost_light_floor-255"
	base_icon_state = "flock_outpost_light_floor"
	smoothing_groups = SMOOTH_GROUP_FLOCK_OUTPOST_LIGHT
	canSmoothWith = SMOOTH_GROUP_FLOCK_OUTPOST_LIGHT
	footstep = FOOTSTEP_FLOOR
	emissive_icon = 'troutstation/icons/turf/floors/flock_outpost_light_floor_e.dmi'
	light_range = 2
	light_power = 0.5
	light_color = FLOCK_OUTPOST_LIGHT_COLOR

// Walls
/turf/closed/indestructible/flock_outpost
	name = "ultradense substrate panel"
	desc = "Impervious to all known forms of damage. All known forms you can think of, anyway."
	icon = 'troutstation/icons/turf/floors/flock_outpost_wall.dmi'
	icon_state = "flock_outpost_wall-0"
	base_icon_state = "flock_outpost_wall"
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = SMOOTH_GROUP_FLOCK_OUTPOST_WALL
	canSmoothWith = SMOOTH_GROUP_FLOCK_OUTPOST_WALL
	smoothing_junction = 255
	/// Icon for the emissive overlay
	var/emissive_icon = 'troutstation/icons/turf/floors/flock_outpost_wall_e.dmi'
	/// The alpha used for the emissive decal.
	var/emissive_alpha = 20

/turf/closed/indestructible/flock_outpost/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/decal, emissive_icon, base_icon_state, dir, EMISSIVE_PLANE, null, emissive_alpha, null, smoothing_junction)

/turf/closed/indestructible/flock_outpost_window
	name = "sealed window"
	desc = "Pretty dull weather we're having today. Looks like dots again."
	icon = MAP_SWITCH('troutstation/icons/obj/smooth_structures/flock_outpost_window.dmi', 'troutstation/icons/turf/floors/flock_outpost.dmi')
	icon_state = MAP_SWITCH("flock_outpost_window-0", "window")
	base_icon_state = "flock_outpost_window"
	opacity = FALSE
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = SMOOTH_GROUP_FLOCK_OUTPOST_WINDOW
	canSmoothWith = SMOOTH_GROUP_FLOCK_OUTPOST_WINDOW
	smoothing_junction = 255

/turf/closed/indestructible/flock_outpost_window/Initialize(mapload)
	. = ..()
	underlays += mutable_appearance('troutstation/icons/turf/floors/flock_outpost.dmi', "plating", layer - 0.01, src) //add the plating underlay

/turf/closed/indestructible/flock_outpost_fakedoor
	name = "iris door"
	desc = "You don't think it's unlocking any time soon."
	icon = 'troutstation/icons/obj/doors/flock.dmi'
	icon_state = "outpost_locked"

// The voooooiiid
/turf/open/flock_void
	name = "\proper signal space"
	desc = "The artificial energy subdimension this outpost resides in. Shreds lesser beings."
	icon = 'troutstation/icons/turf/floors/flock_outpost.dmi'
	icon_state = "void"
	smoothing_flags = NONE
	smoothing_groups = null
	canSmoothWith = null
	layer = SPACE_LAYER
	turf_flags = NOJAUNT | NO_RUST
	light_range = 2
	light_power = 0.6
	light_color = FLOCK_OUTPOST_VOID_LIGHT_COLOR

/turf/open/flock_void/examine(mob_user)
	. = ..()
	. += span_warning("You'd be dissolved immediately if you somehow walked into this.")

/turf/open/flock_void/Entered(atom/movable/arrived, atom/old_loc, list/atom/old_locs)
	. = ..()
	if(isobj(arrived))
		qdel(arrived)
	else if(isliving(arrived))
		var/mob/living/unfortunate = arrived
		to_chat(unfortunate, span_userdanger("You are torn to shreds by the energy of signal space!!"))
		unfortunate.dust(force = TRUE)

// OBJS
/obj/machinery/door/flock_outpost
	name = "iris door"
	desc = "Radial-blade doors are in vogue right now. Only 3 reported accidental amputations in the last 267 cycles!"
	icon = 'troutstation/icons/obj/doors/flock.dmi'
	icon_state = "outpost_closed"
	base_icon_state = "outpost"
	can_be_glass = FALSE // ironically
	autoclose = TRUE
	has_access_panel = FALSE
	var/open_sound = 'troutstation/sound/effects/flock/flock_door_open.ogg'
	var/close_sound = 'troutstation/sound/effects/flock/flock_door_close.ogg'

// I am absolutely fucking astounded this needs to be hooked into, what the fuck
/obj/machinery/door/flock_outpost/run_animation(animation, force_type = DEFAULT_DOOR_CHECKS)
	. = ..()
	switch(animation)
		if(DOOR_OPENING_ANIMATION)
			playsound(src, open_sound, 30, TRUE)
		if(DOOR_CLOSING_ANIMATION)
			playsound(src, close_sound, 30, TRUE)

/obj/effect/flock_outpost_light
	name = "luminous orb"
	desc = "A minor automaton. It softly floats and bathes the room in light. Surprisingly stubborn in keeping to its post."
	icon = 'troutstation/icons/obj/flock_outpost.dmi'
	icon_state = "orb"
	anchored = TRUE
	light_range = 6
	light_power = 1
	light_color = FLOCK_OUTPOST_LIGHT_COLOR
	/// Icon for the emissive overlay
	var/emissive_icon = 'troutstation/icons/obj/flock_outpost.dmi'
	/// The alpha used for the emissive decal.
	var/emissive_alpha = 20

/obj/effect/flock_outpost_light/Initialize()
	. = ..()
	AddElement(/datum/element/decal, emissive_icon, "orb_e", dir, EMISSIVE_PLANE, null, emissive_alpha, null, smoothing_junction)
	DO_FLOATING_ANIM(src)

/obj/machinery/computer/camera_advanced/flock
	name = "Mission Deployment Console"
	desc = "Pick where in the station you want to deploy to using this console."
	icon = 'icons/obj/antags/abductor.dmi'
	icon_state = "camera"
	icon_keyboard = null
	icon_screen = null
	networks = list(CAMERANET_NETWORK_SS13)
	lock_override = TRUE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF

/obj/machinery/computer/camera_advanced/flock/CreateEye()
	. = ..()
	//For observers
	eyeobj.icon = 'icons/mob/eyemob.dmi'
	eyeobj.icon_state = "abductor_camera"
	//For the user
	eyeobj.set_user_icon(eyeobj.icon, eyeobj.icon_state)

/obj/machinery/flock_outpost
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	use_power = NO_POWER_USE

/obj/machinery/flock_outpost/pod_pad
	name = "Transport Pod Shaper"
	desc = "Spawns a transport pod when you're ready. Free one-way ticket."
	icon = 'icons/obj/antags/abductor.dmi'
	icon_state = "alien-pad-idle"

#undef FLOCK_OUTPOST_LIGHT_COLOR
#undef FLOCK_OUTPOST_DEFAULT_ATMOS
#undef FLOCK_OUTPOST_VOID_LIGHT_COLOR
