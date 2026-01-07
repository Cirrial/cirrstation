/// Component to grant any mob with it the ability to see active radios in their field of vision, including those in mobs.
/datum/component/radio_source_vision
	dupe_mode = COMPONENT_DUPE_SOURCES
	var/vision_distance = 9
	var/list/radio_images = list()

/datum/component/radio_source_vision/Initialize()
	if (!isliving(parent))
		return COMPONENT_INCOMPATIBLE

/datum/component/radio_source_vision/RegisterWithParent()
	START_PROCESSING(SSobj, src)

/datum/component/radio_source_vision/UnregisterFromParent()
	STOP_PROCESSING(SSobj, src)

/datum/component/radio_source_vision/process()
	radio_source_scan(parent, vision_distance)

/datum/component/radio_source_vision/proc/radio_source_scan(mob/viewer, distance = 3)
	if(!ismob(viewer) || !viewer.client)
		return

	// clean out old images
	if(radio_images.len > 0)
		for(var/image/existing in radio_images)
			remove_image_from_client(existing, viewer.client)
	radio_images = list()

	// make new ones
	// radio overlays
	var/image/I
	var/list/radios = get_radios_nearby(viewer, distance)
	for(var/obj/item/radio/radio in radios)
		var/atom/location = radio.loc
		if(isturf(location))
			I = radio_source_make_overlay_image(radio, radio)
		else
			I = radio_source_make_overlay_image(location, radio)
		radio_images += I
		add_image_to_client(I, viewer.client)

/datum/component/radio_source_vision/proc/radio_source_make_overlay_image(atom/source, obj/item/radio/radio)
	var/image/I = new(loc = source)
	var/mutable_appearance/MA = mutable_appearance('icons/obj/weapons/guns/projectiles.dmi', icon_state = "bluespace")
	MA.alpha = 192
	MA.dir = radio.dir
	I.appearance = MA
	SET_PLANE(I, ABOVE_LIGHTING_PLANE, source)
	return I
