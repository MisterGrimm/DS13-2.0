#define CYST_SHOOT_ANGLE 90

/obj/structure/necromorph/cyst
	name = "cyst"
	icon = 'deadspace/icons/effects/corruption.dmi'
	icon_state = "cyst-empty"
	max_integrity = 50
	set_dir_on_move = FALSE
	//If we are ready to shoot
	var/ready = FALSE
	cost = 15
	can_place_in_sight = FALSE
	require_wall = TRUE

/obj/structure/necromorph/cyst/Initialize(mapload)
	.=..()
	var/static/list/loc_connections = list(
		COMSIG_ATOM_ENTERED = PROC_REF(on_entered),
		COMSIG_ATOM_INITIALIZED_ON = PROC_REF(on_entered),
	)
	AddComponent(/datum/component/connect_range, src, loc_connections, 6, FALSE)
	addtimer(CALLBACK(src, PROC_REF(set_ready)), 8 SECONDS)

/obj/structure/necromorph/cyst/update_icon_state()
	icon_state = ready ? "cyst-full" : "cyst-empty"
	return ..()

/obj/structure/necromorph/cyst/proc/on_entered(atom/source, mob/living/carbon/human/arrived)
	if(!ready || isnecromorph(arrived) || isprojectile(arrived) || !arrived.stat == CONSCIOUS)
		return
	var/angle = SIMPLIFY_DEGREES(get_angle(src, arrived) - dir2angle(src.dir))
	if(angle > CYST_SHOOT_ANGLE*0.5)
		return
	if(!can_see(src, arrived, 4))
		return
	shoot_at(arrived)

/obj/structure/necromorph/cyst/proc/shoot_at(atom/movable/target)
	if(!ready)
		return
	ready = FALSE
	update_icon(UPDATE_ICON_STATE)
	var/turf/startloc = get_turf(src)
	var/obj/projectile/cyst/P = new /obj/projectile/cyst(startloc)
	playsound(src,pick(
		'deadspace/sound/effects/creatures/necromorph/cyst/cyst_fire_1.ogg',
		'deadspace/sound/effects/creatures/necromorph/cyst/cyst_fire_2.ogg',
		'deadspace/sound/effects/creatures/necromorph/cyst/cyst_fire_3.ogg',
		'deadspace/sound/effects/creatures/necromorph/cyst/cyst_fire_4.ogg',
	), VOLUME_HIGH, TRUE)
	P.starting = startloc
	P.firer = src
	P.fired_from = src
	P.yo = target.y - startloc.y
	P.xo = target.x - startloc.x
	P.original = target
	P.def_zone = ran_zone()
	P.preparePixelProjectile(target, src)
	P.fire(null, target)
	addtimer(CALLBACK(src, PROC_REF(set_ready)), 8 SECONDS)

/obj/structure/necromorph/cyst/proc/set_ready()
	ready = TRUE
	update_icon(UPDATE_ICON_STATE)

/obj/projectile/cyst
	name = "bio bomb"
	desc = "A wiggling creature which looks fit to burst any moment"
	icon = 'deadspace/icons/effects/corruption.dmi'
	icon_state= "cyst-bomb-primed"
	damage = 45
	damage_type = BURN
	armor_flag = BIO

#undef CYST_SHOOT_ANGLE
