#define FLOCK_OUTPOST_DEFAULT_ATMOS GAS_N2 + "=100;TEMP=200"
#define FLOCK_OUTPOST_VOID_LIGHT_COLOR "#ace5c6"

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

// TURFS
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

/turf/open/floor/flock_outpost/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/decal, emissive_icon, base_icon_state, dir, EMISSIVE_PLANE, null, emissive_alpha, null, smoothing_junction)

/turf/open/floor/flock_outpost/break_tile()
	return // unbreakable

/turf/open/floor/flock_outpost/burn_tile()
	return // unbreakable

/turf/closed/indestructible/flock_outpost
	name = "sonorous panel"
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
	desc = "Pretty dull weather we're having today. Looks like rectangle clouds again."
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

/turf/open/flock_void
	name = "signal space"
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
#define LIGHT_COLOR_FLOCK_OUTPOST "#b8ece4" // a very faint teal

/obj/flock_outpost_light
	name = "luminous orb"
	desc = "A minor automaton. It softly floats and bathes the room in light. Surprisingly stubborn in keeping to its post."
	icon = 'troutstation/icons/obj/flock_outpost.dmi'
	icon_state = "orb"
	anchored = TRUE
	max_integrity = 1000
	light_range = 6
	light_power = 1
	light_color = LIGHT_COLOR_FLOCK_OUTPOST
	/// Icon for the emissive overlay
	var/emissive_icon = 'troutstation/icons/obj/flock_outpost.dmi'
	/// The alpha used for the emissive decal.
	var/emissive_alpha = 20

/obj/flock_outpost_light/Initialize()
	. = ..()
	AddElement(/datum/element/decal, emissive_icon, "orb_e", dir, EMISSIVE_PLANE, null, emissive_alpha, null, smoothing_junction)
	DO_FLOATING_ANIM(src)

#undef LIGHT_COLOR_FLOCK_OUTPOST

#undef FLOCK_OUTPOST_DEFAULT_ATMOS
#undef FLOCK_OUTPOST_VOID_LIGHT_COLOR
