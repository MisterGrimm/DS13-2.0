//after a delay, creates a rune below you. for constructs creating runes.
/datum/action/innate/cult/create_rune
	name = "Summon Rune"
	desc = "Summons a rune"
	background_icon_state = "bg_demon"
	var/obj/effect/rune/rune_type
	var/cooldown = 0
	var/base_cooldown = 1800
	var/scribe_time = 60
	var/damage_interrupt = TRUE
	var/action_interrupt = TRUE
	var/obj/effect/temp_visual/cult/rune_spawn/rune_word_type
	var/obj/effect/temp_visual/cult/rune_spawn/rune_innerring_type
	var/obj/effect/temp_visual/cult/rune_spawn/rune_center_type
	var/rune_color

/datum/action/innate/cult/create_rune/IsAvailable(feedback = FALSE)
	if(!rune_type || cooldown > world.time)
		return FALSE
	return ..()

/datum/action/innate/cult/create_rune/proc/turf_check(turf/T)
	if(!T)
		return FALSE
	if(isspaceturf(T))
		to_chat(owner, span_warning("You cannot scribe runes in space!"))
		return FALSE
	if(locate(/obj/effect/rune) in T)
		to_chat(owner, span_cult("There is already a rune here."))
		return FALSE
	if(!is_station_level(T.z) && !is_mining_level(T.z))
		to_chat(owner, span_warning("The veil is not weak enough here."))
		return FALSE
	return TRUE


/datum/action/innate/cult/create_rune/Activate()
	var/turf/T = get_turf(owner)
	if(turf_check(T))
		var/chosen_keyword
		if(initial(rune_type.req_keyword))
			chosen_keyword = tgui_input_text(owner, "Enter a keyword for the new rune.", "Words of Power", max_length = MAX_NAME_LEN)
			if(!chosen_keyword)
				return
	//the outer ring is always the same across all runes
		var/obj/effect/temp_visual/cult/rune_spawn/R1 = new(T, scribe_time, rune_color)
	//the rest are not always the same, so we need types for em
		var/obj/effect/temp_visual/cult/rune_spawn/R2
		if(ispath(rune_word_type, /obj/effect/temp_visual/cult/rune_spawn))
			R2 = new rune_word_type(T, scribe_time, rune_color)
		var/obj/effect/temp_visual/cult/rune_spawn/R3
		if(ispath(rune_innerring_type, /obj/effect/temp_visual/cult/rune_spawn))
			R3 = new rune_innerring_type(T, scribe_time, rune_color)
		var/obj/effect/temp_visual/cult/rune_spawn/R4
		if(ispath(rune_center_type, /obj/effect/temp_visual/cult/rune_spawn))
			R4 = new rune_center_type(T, scribe_time, rune_color)

		cooldown = base_cooldown + world.time
		owner?.update_mob_action_buttons()
		addtimer(CALLBACK(owner, TYPE_PROC_REF(/mob, update_mob_action_buttons)), base_cooldown)

		var/mob_health = null
		if(damage_interrupt && isliving(owner))
			var/mob/living/L = owner
			mob_health = L.health

		var/scribe_mod = scribe_time
		if(istype(T, /turf/open/floor/engine/cult))
			scribe_mod *= 0.5

		playsound(T, 'sound/magic/enter_blood.ogg', 100, FALSE)

		var/flags = action_interrupt ? DO_RESTRICT_CLICKING : NONE
		var/datum/callback/cb = mob_health ? CALLBACK(src, PROC_REF(check_health_changed), owner, list(mob_health)) : null

		if(do_after(owner, owner, scribe_mod, flags, extra_checks = cb))
			new rune_type(owner.loc, chosen_keyword)
		else
			qdel(R1)
			if(R2)
				qdel(R2)
			if(R3)
				qdel(R3)
			if(R4)
				qdel(R4)
			cooldown = 0
			owner?.update_mob_action_buttons()

/datum/action/innate/cult/create_rune/proc/check_health_changed(mob/living/user, list/old_health)
	if(user.health < old_health[1])
		return FALSE

	old_health[1] = user.health
	return TRUE

//teleport rune
/datum/action/innate/cult/create_rune/tele
	name = "Summon Teleport Rune"
	desc = "Summons a teleport rune to your location, as though it has been there all along..."
	button_icon_state = "telerune"
	rune_type = /obj/effect/rune/teleport
	rune_word_type = /obj/effect/temp_visual/cult/rune_spawn/rune2
	rune_innerring_type = /obj/effect/temp_visual/cult/rune_spawn/rune2/inner
	rune_center_type = /obj/effect/temp_visual/cult/rune_spawn/rune2/center
	rune_color = RUNE_COLOR_TELEPORT

/datum/action/innate/cult/create_rune/wall
	name = "Summon Barrier Rune"
	desc = "Summons an active barrier rune to your location, as though it has been there all along..."
	button_icon_state = "barrier"
	rune_type = /obj/effect/rune/wall
	rune_word_type = /obj/effect/temp_visual/cult/rune_spawn/rune4
	rune_innerring_type = /obj/effect/temp_visual/cult/rune_spawn/rune4/inner
	rune_center_type = /obj/effect/temp_visual/cult/rune_spawn/rune4/center
	rune_color = RUNE_COLOR_DARKRED

/datum/action/innate/cult/create_rune/revive
	name = "Summon Revive Rune"
	desc = "Summons a revive rune to your location, as though it has been there all along..."
	button_icon_state = "revive"
	rune_type = /obj/effect/rune/raise_dead
	rune_word_type = /obj/effect/temp_visual/cult/rune_spawn/rune1
	rune_innerring_type = /obj/effect/temp_visual/cult/rune_spawn/rune1/inner
	rune_center_type = /obj/effect/temp_visual/cult/rune_spawn/rune1/center
	rune_color = RUNE_COLOR_MEDIUMRED
