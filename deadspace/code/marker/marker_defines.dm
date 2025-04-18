GLOBAL_LIST_EMPTY(necromorph_markers)
/obj/structure/marker
	name = "Marker"
	icon = 'deadspace/icons/obj/marker_giant.dmi'
	icon_state = "marker_giant_dormant"
	appearance_flags = PIXEL_SCALE|LONG_GLIDE
	layer = HIGH_OBJ_LAYER
	plane = GAME_PLANE
	interaction_flags_atom = INTERACT_ATOM_ATTACK_HAND
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	bound_width = 96
	bound_x = -32
	pixel_x = -33
	base_pixel_x = -33
	move_resist = MOVE_FORCE_OVERPOWERING
	density = TRUE
	///The loopingsound for when marker activates
	var/datum/looping_sound/marker/soundloop
	var/active = FALSE
	///Whether we should use necroqueue when spawning necromorphs
	var/use_necroqueue = TRUE
	var/list/necroqueue = list()
	var/mob/camera/marker_signal/marker/camera_mob
	var/datum/markernet/markernet
	var/list/marker_signals = list()
	var/list/necromorphs = list()
	///checks mobs with clients when marker activates and adds them to a list, used for sense
	var/list/unwhole = list()
	/// Biomass stored
	var/marker_biomass = 0
	/// Biomass signals can use
	var/signal_biomass = 0
	/// Biomass marker spent since the start of the round
	var/biomass_invested = 0
	/// Sources of biomass income
	var/list/datum/biomass_source/biomass_sources = list()
	/// Biomass recieve by the marker in the last process() call
	var/last_biomass_income = 0
	/// Percent of biomass signals recieve from marker income
	var/signal_biomass_percent = 0.1
	/// An assoc list of all necro class types = their references
	var/list/datum/necro_class/necro_classes = list()
	/// A list of all corruption nodes
	var/list/nodes = list()
	/// A list of atoms that let us spawn necromorphs 6 tiles away from them
	var/list/necro_spawn_atoms = list()
	/// List of eyes on the corruptions this marker has
	var/list/corruption_eyes
	/// When was the last time all signals were alerted by an eye
	var/last_eye_notify

/datum/looping_sound/marker
	mid_sounds = 'deadspace/sound/effects/markerthrob.ogg'
	mid_length = 9.5 SECONDS
	volume = 50
	ignore_walls = FALSE
	extra_range = 20
	falloff_exponent = 5
	falloff_distance = 8
