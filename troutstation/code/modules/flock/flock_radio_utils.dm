/// Proc to fetch all radios near an origin regardless of if they're in containers or not. Excludes origin.
/proc/get_radios_nearby(atom/origin, distance = 3)
	var/list/radios = list()
	var/obj/item/radio/radio = null
	var/atom/origin_turf = get_turf(origin) // so we can still see radio signals while in phased dummy
	// any mobs with radios
	for(var/mob/M in orange(distance, origin_turf))
		if(M == origin)
			continue
		if(M.contents.len > 0)
			for(var/obj/content in M.contents)
				if(istype(content, /obj/item/radio))
					radio = content
					radios += radio
	// any objs with/that are radios
	for(var/obj/O in orange(distance, origin_turf))
		if(O == origin)
			continue
		if(istype(O, /obj/item/radio))
			radio = O
			radios += radio
		if(O.contents.len > 0)
			for(var/obj/content in O.contents)
				if(istype(content, /obj/item/radio))
					radio = content
					radios += radio
	return radios
