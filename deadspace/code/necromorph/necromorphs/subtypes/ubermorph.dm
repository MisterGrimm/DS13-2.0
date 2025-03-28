/mob/living/carbon/human/necromorph/ubermorph
	maxHealth = INFINITY
	class = /datum/necro_class/ubermorph
	necro_species = /datum/species/necromorph/ubermorph

/mob/living/carbon/human/necromorph/ubermorph/Initialize(mapload, obj/structure/marker/marker_master)
	. = ..()
	send_to_playing_players(span_colossus("A deep chill slithers into your mind.. You feel like you are running out of time.")) //If you aren't dead, you'll know you will be soon
	sound_to_playing_players(pick(GLOB.ubermorph_spawn), 40)

/mob/living/carbon/human/necromorph/ubermorph/play_necro_sound(audio_type, volume, vary, extra_range)
	playsound(src, pick(GLOB.ubermorph_sounds[audio_type]), volume, vary, extra_range)

/datum/necro_class/ubermorph
	display_name = "Ubermorph"
	desc = "A juvenile hivemind. Constantly regenerating, a nigh-immortal leader of the necromorph army. "
	ui_icon = 'deadspace/icons/necromorphs/ubermorph.dmi'
	necromorph_type_path = /mob/living/carbon/human/necromorph/ubermorph
	nest_allowed = FALSE
	tier = 4
	biomass_cost = 800
	biomass_spent_required = 2000
	melee_damage_lower = 10
	melee_damage_upper = 25
	implemented = TRUE
	armor = list(BLUNT = 75, PUNCTURE = 75, SLASH = 30, LASER = 10, ENERGY = 15, BOMB = 25, BIO = 100, FIRE = 80, ACID = 100)
	actions = list(
		/datum/action/cooldown/necro/charge/ubermorph,
		/datum/action/cooldown/necro/regenerate/ubermorph,
		/datum/action/innate/sense,
		// /datum/action/cooldown/necro/frenzy_shout/ubermorph,
	)
	minimap_icon = "ubermorph"
	spawn_limit = 1

/datum/species/necromorph/ubermorph
	name = "Ubermorph"
	id = SPECIES_NECROMORPH_UBERMORPH
	speedmod = 1.2
	bodypart_overrides = list(
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/necromorph/ubermorph,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/necromorph/ubermorph,
		BODY_ZONE_HEAD = /obj/item/bodypart/head/necromorph/ubermorph,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/necromorph/ubermorph,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/necromorph/ubermorph,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/necromorph/ubermorph,
	)

	special_step_sounds = list(
		'deadspace/sound/effects/footstep/ubermorph_footstep_1.ogg',
		'deadspace/sound/effects/footstep/ubermorph_footstep_2.ogg',
		'deadspace/sound/effects/footstep/ubermorph_footstep_3.ogg',
		'deadspace/sound/effects/footstep/ubermorph_footstep_4.ogg'
	)

/datum/species/necromorph/ubermorph/get_scream_sound(mob/living/carbon/human/necromorph/ubermorph)
	return pick(
		'deadspace/sound/effects/creatures/necromorph/ubermorph/ubermorph_pain_5.ogg',
		'deadspace/sound/effects/creatures/necromorph/ubermorph/ubermorph_pain_6.ogg',
		'deadspace/sound/effects/creatures/necromorph/ubermorph/ubermorph_shout_long_3.ogg',
	)

/datum/action/cooldown/necro/regenerate/ubermorph
	max_limbs = 2

/datum/action/cooldown/necro/frenzy_shout/ubermorph
	var/obj/effect/temp_visual/expanding_circle/EC

/datum/action/cooldown/necro/frenzy_shout/ubermorph/Activate(atom/target)
	. = ..()
	if(.)
		var/mob/living/carbon/human/necromorph/N = owner
		N.play_necro_sound(SOUND_SHOUT_LONG, VOLUME_HIGH, 1, 6)
		shake_camera(N, 6, 4)

		for (var/mob/living/L in view(7, N))
			if (!faction_check(N.faction, L.faction) && L.stat != DEAD)
				L.take_overall_damage(15)

		//Lets do some cool effects
		effect_circle()
		addtimer(CALLBACK(src, PROC_REF(effect_circle)), 4)
		addtimer(CALLBACK(src, PROC_REF(effect_circle)), 8)

/datum/action/cooldown/necro/frenzy_shout/ubermorph/proc/effect_circle()
	EC = new /obj/effect/temp_visual/expanding_circle(owner.loc, 1.5 SECONDS, 1.5,"#ff0000")
	EC.pixel_y += 40	//Offset it so it appears to be at our mob's head

/datum/action/cooldown/necro/charge/ubermorph
	name = "Lunge"
	desc = "A shortrange charge which causes heavy internal damage to one victim. Often fatal."

/datum/action/cooldown/necro/charge/ubermorph/Activate(atom/target)
	..()
	owner.face_atom(get_turf(target))
	animate(
		owner,
		pixel_x = owner.pixel_x + (target_atom.x - owner.x) * 24,
		pixel_y = owner.pixel_y + (target_atom.y - owner.y) * 24,
		time = charge_delay,
		easing = BACK_EASING
	)
	return TRUE

/datum/action/cooldown/necro/charge/ubermorph/do_charge()
	animate(owner, pixel_x = owner.base_pixel_x, pixel_y = owner.base_pixel_y, time = 0.5 SECONDS, easing = BACK_EASING)
	return ..()
