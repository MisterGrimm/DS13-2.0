/obj/item/bodypart/chest/necromorph/hunter
	name = BODY_ZONE_CHEST
	limb_id = SPECIES_NECROMORPH_HUNTER
	icon_static = 'deadspace/icons/necromorphs/hunter.dmi'
	icon_state = "chest"
	max_damage = 400
	px_x = 0
	px_y = 0
	wound_resistance = 20
	biomass = 90 //Most biomass stored in chest due to regeneration

/obj/item/bodypart/head/necromorph/hunter
	name = BODY_ZONE_HEAD
	limb_id = SPECIES_NECROMORPH_HUNTER
	icon_static = 'deadspace/icons/necromorphs/hunter.dmi'
	icon_state = "head"
	max_damage = 50
	px_x = 0
	px_y = -8
	wound_resistance = 0
	biomass = 30
	base_pixel_x = -5
	base_pixel_y = -35

/obj/item/bodypart/arm/left/necromorph/hunter
	name = "left blade"
	limb_id = SPECIES_NECROMORPH_HUNTER
	icon_static = 'deadspace/icons/necromorphs/hunter.dmi'
	icon_state = "l_arm"
	attack_verb_continuous = list("slashes", "stabs")
	attack_verb_simple = list("slash", "stab")
	max_damage = 40
	px_x = -6
	px_y = 0
	wound_resistance = -5
	biomass = 20
	base_pixel_x = -17
	base_pixel_y = -22

/obj/item/bodypart/arm/right/necromorph/hunter
	name = "right blade"
	limb_id = SPECIES_NECROMORPH_HUNTER
	icon_static = 'deadspace/icons/necromorphs/hunter.dmi'
	icon_state = "r_arm"
	attack_verb_continuous = list("slashes", "stabs")
	attack_verb_simple = list("slash", "stab")
	max_damage = 40
	px_x = 6
	px_y = 0
	wound_resistance = -5
	biomass = 20
	base_pixel_x = 5
	base_pixel_y = -22

/obj/item/bodypart/leg/left/necromorph/hunter
	name = "left leg"
	limb_id = SPECIES_NECROMORPH_HUNTER
	icon_static = 'deadspace/icons/necromorphs/hunter.dmi'
	icon_state = "l_leg"
	attack_verb_continuous = list("kicks", "stomps")
	attack_verb_simple = list("kick", "stomp")
	max_damage = 45
	px_x = -2
	px_y = 12
	wound_resistance = -5
	biomass = 20
	base_pixel_x = -10

/obj/item/bodypart/leg/right/necromorph/hunter
	name = "right leg"
	limb_id = SPECIES_NECROMORPH_HUNTER
	icon_static = 'deadspace/icons/necromorphs/hunter.dmi'
	icon_state = "r_leg"
	attack_verb_continuous = list("kicks", "stomps")
	attack_verb_simple = list("kick", "stomp")
	max_damage = 45
	px_x = 2
	px_y = 12
	wound_resistance = -5
	biomass = 20
