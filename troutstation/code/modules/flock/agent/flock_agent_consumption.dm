/mob/living/basic/flock/agent/proc/start_eating_item(obj/item/eating)
	eat_time_remaining = get_flock_item_eating_time(eating)
	total_eat_time = eat_time_remaining
	animate(eating, color = list(1,0,0,0,1,0,0,0,1,0,1,0.5), time = eat_time_remaining / 10)
	eating.SpinAnimation(speed = eat_time_remaining, parallel = FALSE)
	// actual eating happens in flock agent's Life process
	to_chat(src, span_notice("It will take about [eat_time_remaining] second[eat_time_remaining == 1 ? "" : "s"] to process [eating]."))

/mob/living/basic/flock/agent/proc/stop_eating_item(obj/item/eating)
	animate(eating, color = null, transform = null, time = 0.1 SECONDS)

/proc/get_flock_item_eating_time(obj/item/eating)
	var/time = eating.get_integrity() / 50 // base item max integrity is 200, so this gives us 4 seconds
	time += (get_flock_item_resources(eating) - 5) / 2 // another half a second per resource above 5 we get
	return time

/proc/get_flock_item_resources(obj/item/eating)
	var/item_resources = 5 // a pity amount
	if(length(eating.custom_materials) > 0)
		for(var/datum/material/mat in eating.custom_materials)
			item_resources += eating.custom_materials[mat] * mat.flock_resource_value
	return floor(item_resources)

/// material extra defines. whee
#define FLOCK_UNREAL_MATERIAL 2
#define FLOCK_PRECIOUS_MATERIAL 1
#define FLOCK_SEMIPRECIOUS_MATERIAL 0.5
#define FLOCK_ACCEPTABLE_MATERIAL 0.1
#define FLOCK_ORGANIC_TRASH 0.05
#define FLOCK_NEARLY_WORTHLESS 0.01

/datum/material
	/// How many resources is 1 unit of this resource worth? Keep in mind a sheet is 100 units.
	var/flock_resource_value = 0

/datum/material/iron
	flock_resource_value = FLOCK_ACCEPTABLE_MATERIAL
/datum/material/glass
	flock_resource_value = FLOCK_ACCEPTABLE_MATERIAL
/datum/material/silver
	flock_resource_value = FLOCK_SEMIPRECIOUS_MATERIAL
/datum/material/gold
	flock_resource_value = FLOCK_SEMIPRECIOUS_MATERIAL
/datum/material/diamond
	flock_resource_value = FLOCK_SEMIPRECIOUS_MATERIAL
/datum/material/uranium
	flock_resource_value = FLOCK_SEMIPRECIOUS_MATERIAL
/datum/material/plasma
	flock_resource_value = FLOCK_SEMIPRECIOUS_MATERIAL
/datum/material/bluespace
	flock_resource_value = FLOCK_PRECIOUS_MATERIAL
/datum/material/bananium
	flock_resource_value = FLOCK_PRECIOUS_MATERIAL
/datum/material/titanium
	flock_resource_value = FLOCK_SEMIPRECIOUS_MATERIAL
/datum/material/runite
	flock_resource_value = FLOCK_SEMIPRECIOUS_MATERIAL
/datum/material/plastic
	flock_resource_value = FLOCK_ACCEPTABLE_MATERIAL
/datum/material/biomass // not implemented anywhere yet but here we go
	flock_resource_value = FLOCK_ORGANIC_TRASH
/datum/material/meat
	flock_resource_value = FLOCK_ORGANIC_TRASH
/datum/material/wood
	flock_resource_value = FLOCK_ORGANIC_TRASH
/datum/material/pizza
	flock_resource_value = FLOCK_ORGANIC_TRASH
/datum/material/adamantine
	flock_resource_value = FLOCK_UNREAL_MATERIAL
/datum/material/mythril
	flock_resource_value = FLOCK_UNREAL_MATERIAL
/datum/material/hot_ice
	flock_resource_value = FLOCK_PRECIOUS_MATERIAL
/datum/material/metalhydrogen
	flock_resource_value = FLOCK_PRECIOUS_MATERIAL
/datum/material/sand
	flock_resource_value = FLOCK_ACCEPTABLE_MATERIAL
/datum/material/sandstone
	flock_resource_value = FLOCK_ACCEPTABLE_MATERIAL
/datum/material/snow
	flock_resource_value = FLOCK_NEARLY_WORTHLESS
/datum/material/runedmetal
	flock_resource_value = FLOCK_NEARLY_WORTHLESS // difficult to convert. internal war
/datum/material/bronze
	flock_resource_value = FLOCK_NEARLY_WORTHLESS // ratvar's death tanked bronze futures
/datum/material/paper
	flock_resource_value = FLOCK_ORGANIC_TRASH
/datum/material/cardboard
	flock_resource_value = FLOCK_ORGANIC_TRASH
/datum/material/bone
	flock_resource_value = FLOCK_ORGANIC_TRASH
/datum/material/zaukerite
	flock_resource_value = FLOCK_PRECIOUS_MATERIAL
/datum/material/alloy/plasteel
	flock_resource_value = FLOCK_SEMIPRECIOUS_MATERIAL
/datum/material/alloy/plastitanium
	flock_resource_value = FLOCK_PRECIOUS_MATERIAL
/datum/material/alloy/plasmaglass
	flock_resource_value = FLOCK_SEMIPRECIOUS_MATERIAL
/datum/material/alloy/titaniumglass
	flock_resource_value = FLOCK_SEMIPRECIOUS_MATERIAL
/datum/material/alloy/plastitaniumglass
	flock_resource_value = FLOCK_PRECIOUS_MATERIAL
/datum/material/alloy/alien
	flock_resource_value = FLOCK_UNREAL_MATERIAL // these substances are too similar as it is
/datum/material/hauntium
	flock_resource_value = FLOCK_UNREAL_MATERIAL

#undef FLOCK_UNREAL_MATERIAL
#undef FLOCK_PRECIOUS_MATERIAL
#undef FLOCK_SEMIPRECIOUS_MATERIAL
#undef FLOCK_ACCEPTABLE_MATERIAL
#undef FLOCK_ORGANIC_TRASH
#undef FLOCK_NEARLY_WORTHLESS
