///A extremely simple form of necromorph for small creatures with no limbs to chop off.
///Examples : Divider components, swarmers, ecetera.
///Not meant to be playable by signals.
/mob/living/simple_animal/hostile/necromorph
	name = "basic necromorph"
	desc = "You have a feeling that you shouldn't be seeing this."
	//most simple necros have their own .dmi file, so this needs to be changed as needed
	icon = 'deadspace/icons/necromorphs/basic/components.dmi'
	icon_state = "head"
	attack_verb_continuous = "beats"
	attack_verb_simple = "beat"
	speak_emote = null
	health = 50
	maxHealth = 50
	melee_damage_lower = 3
	melee_damage_upper = 7
	obj_damage = 5
	stat_attack = UNCONSCIOUS //simple necros attack until the person is DEAD
	//Attack_sound also needs to be changed as needed
	attack_sound = SFX_NECRO_HEAD_ATTACK
	attack_vis_effect = ATTACK_EFFECT_DISARM
	faction = list("necromorph")
	sharpness = NONE
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_plas" = 0, "max_plas" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	combat_mode = TRUE
	dodging = TRUE //They try to be nimble due to their low health
	dodge_prob = 50

/mob/living/basic/necromorph/Initialize(mapload)
	. = ..()


/mob/living/basic/necromorph/death(gibbed)
	. = ..()

