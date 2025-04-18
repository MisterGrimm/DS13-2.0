//An actual HUD
/datum/hud/necromorph
	ui_style = 'icons/hud/screen_midnight.dmi'
	var/atom/movable/screen/meter/background/background
	var/atom/movable/screen/meter/health/health
	var/atom/movable/screen/meter/health/shield/shield
	var/atom/movable/screen/meter/foreground/foreground

/datum/hud/necromorph/New(mob/living/carbon/human/necromorph/owner)
	..()

//healthbar
	background = new

	health = new
	health.add_filter("alpha_mask", 1, alpha_mask_filter(icon = icon('deadspace/icons/hud/healthbar.dmi', "alpha_mask"), x = clamp(HUD_METER_PIXEL_WIDTH*(owner.health/owner.maxHealth), 0, HUD_METER_PIXEL_WIDTH), flags = MASK_INVERSE))

	foreground = new
	if(owner.dodge_shield > 0)
		foreground.maptext = MAPTEXT("[max(0, owner.health)]+[owner.dodge_shield]/[owner.maxHealth]")
	else
		foreground.maptext = MAPTEXT("[max(0, owner.health)]/[owner.maxHealth]")

	shield = new
	shield.add_filter("alpha_mask", 1, alpha_mask_filter(icon = icon('deadspace/icons/hud/healthbar.dmi', "alpha_mask"), x = clamp(HUD_METER_PIXEL_WIDTH*(owner.dodge_shield/owner.maxHealth), 0, HUD_METER_PIXEL_WIDTH), flags = MASK_INVERSE))

	infodisplay += background
	infodisplay += health
	infodisplay += shield
	infodisplay += foreground

//begin buttons
	var/atom/movable/screen/using
	var/atom/movable/screen/inventory/inv_box

	using = new/atom/movable/screen/language_menu
	using.icon = ui_style
	using.hud = src
	static_inventory += using

	using = new/atom/movable/screen/navigate
	using.icon = ui_style
	using.hud = src
	static_inventory += using

	using = new /atom/movable/screen/area_creator
	using.icon = ui_style
	using.hud = src
	static_inventory += using

	action_intent = new /atom/movable/screen/combattoggle/flashy()
	action_intent.hud = src
	action_intent.icon = ui_style
	action_intent.screen_loc = ui_combat_toggle
	static_inventory += action_intent


	using = new /atom/movable/screen/mov_intent
	using.icon = ui_style
	using.icon_state = (mymob.m_intent == MOVE_INTENT_WALK ? "walking" : "running")
	using.screen_loc = ui_movi
	using.hud = src
	static_inventory += using

	using = new /atom/movable/screen/drop()
	using.icon = ui_style
	using.screen_loc = ui_drop_throw
	using.hud = src
	static_inventory += using

	inv_box = new /atom/movable/screen/inventory()
	inv_box.name = "i_clothing"
	inv_box.icon = ui_style
	inv_box.slot_id = ITEM_SLOT_ICLOTHING
	inv_box.icon_state = "uniform"
	inv_box.screen_loc = ui_iclothing
	inv_box.hud = src
	toggleable_inventory += inv_box

	inv_box = new /atom/movable/screen/inventory()
	inv_box.name = "o_clothing"
	inv_box.icon = ui_style
	inv_box.slot_id = ITEM_SLOT_OCLOTHING
	inv_box.icon_state = "suit"
	inv_box.screen_loc = ui_oclothing
	inv_box.hud = src
	toggleable_inventory += inv_box

	build_hand_slots()

	using = new /atom/movable/screen/swap_hand()
	using.icon = ui_style
	using.icon_state = "swap_1"
	using.screen_loc = ui_swaphand_position(owner,1)
	using.hud = src
	static_inventory += using

	using = new /atom/movable/screen/swap_hand()
	using.icon = ui_style
	using.icon_state = "swap_2"
	using.screen_loc = ui_swaphand_position(owner,2)
	using.hud = src
	static_inventory += using

	inv_box = new /atom/movable/screen/inventory()
	inv_box.name = "id"
	inv_box.icon = ui_style
	inv_box.icon_state = "id"
	inv_box.screen_loc = ui_id
	inv_box.slot_id = ITEM_SLOT_ID
	inv_box.hud = src
	static_inventory += inv_box

	inv_box = new /atom/movable/screen/inventory()
	inv_box.name = "mask"
	inv_box.icon = ui_style
	inv_box.icon_state = "mask"
	inv_box.screen_loc = ui_mask
	inv_box.slot_id = ITEM_SLOT_MASK
	inv_box.hud = src
	toggleable_inventory += inv_box

	inv_box = new /atom/movable/screen/inventory()
	inv_box.name = "neck"
	inv_box.icon = ui_style
	inv_box.icon_state = "neck"
	inv_box.screen_loc = ui_neck
	inv_box.slot_id = ITEM_SLOT_NECK
	inv_box.hud = src
	toggleable_inventory += inv_box

	inv_box = new /atom/movable/screen/inventory()
	inv_box.name = "back"
	inv_box.icon = ui_style
	inv_box.icon_state = "back"
	inv_box.screen_loc = ui_back
	inv_box.slot_id = ITEM_SLOT_BACK
	inv_box.hud = src
	static_inventory += inv_box

	inv_box = new /atom/movable/screen/inventory()
	inv_box.name = "storage1"
	inv_box.icon = ui_style
	inv_box.icon_state = "pocket"
	inv_box.screen_loc = ui_storage1
	inv_box.slot_id = ITEM_SLOT_LPOCKET
	inv_box.hud = src
	static_inventory += inv_box

	inv_box = new /atom/movable/screen/inventory()
	inv_box.name = "storage2"
	inv_box.icon = ui_style
	inv_box.icon_state = "pocket"
	inv_box.screen_loc = ui_storage2
	inv_box.slot_id = ITEM_SLOT_RPOCKET
	inv_box.hud = src
	static_inventory += inv_box

	inv_box = new /atom/movable/screen/inventory()
	inv_box.name = "suit storage"
	inv_box.icon = ui_style
	inv_box.icon_state = "suit_storage"
	inv_box.screen_loc = ui_sstore1
	inv_box.slot_id = ITEM_SLOT_SUITSTORE
	inv_box.hud = src
	static_inventory += inv_box

	using = new /atom/movable/screen/resist()
	using.icon = ui_style
	using.screen_loc = ui_above_intent
	using.hud = src
	hotkeybuttons += using

	using = new /atom/movable/screen/human/toggle()
	using.icon = ui_style
	using.screen_loc = ui_inventory
	using.hud = src
	static_inventory += using

	using = new /atom/movable/screen/human/equip()
	using.icon = ui_style
	using.screen_loc = ui_equip_position(mymob)
	using.hud = src
	static_inventory += using

	inv_box = new /atom/movable/screen/inventory()
	inv_box.name = "gloves"
	inv_box.icon = ui_style
	inv_box.icon_state = "gloves"
	inv_box.screen_loc = ui_gloves
	inv_box.slot_id = ITEM_SLOT_GLOVES
	inv_box.hud = src
	toggleable_inventory += inv_box

	inv_box = new /atom/movable/screen/inventory()
	inv_box.name = "eyes"
	inv_box.icon = ui_style
	inv_box.icon_state = "glasses"
	inv_box.screen_loc = ui_glasses
	inv_box.slot_id = ITEM_SLOT_EYES
	inv_box.hud = src
	toggleable_inventory += inv_box

	inv_box = new /atom/movable/screen/inventory()
	inv_box.name = "ears"
	inv_box.icon = ui_style
	inv_box.icon_state = "ears"
	inv_box.screen_loc = ui_ears
	inv_box.slot_id = ITEM_SLOT_EARS
	inv_box.hud = src
	toggleable_inventory += inv_box

	inv_box = new /atom/movable/screen/inventory()
	inv_box.name = "head"
	inv_box.icon = ui_style
	inv_box.icon_state = "head"
	inv_box.screen_loc = ui_head
	inv_box.slot_id = ITEM_SLOT_HEAD
	inv_box.hud = src
	toggleable_inventory += inv_box

	inv_box = new /atom/movable/screen/inventory()
	inv_box.name = "shoes"
	inv_box.icon = ui_style
	inv_box.icon_state = "shoes"
	inv_box.screen_loc = ui_shoes
	inv_box.slot_id = ITEM_SLOT_FEET
	inv_box.hud = src
	toggleable_inventory += inv_box

	inv_box = new /atom/movable/screen/inventory()
	inv_box.name = "belt"
	inv_box.icon = ui_style
	inv_box.icon_state = "belt"
// inv_box.icon_full = "template_small"
	inv_box.screen_loc = ui_belt
	inv_box.slot_id = ITEM_SLOT_BELT
	inv_box.hud = src
	static_inventory += inv_box

	throw_icon = new /atom/movable/screen/throw_catch()
	throw_icon.icon = ui_style
	throw_icon.screen_loc = ui_drop_throw
	throw_icon.hud = src
	hotkeybuttons += throw_icon

	rest_icon = new /atom/movable/screen/rest()
	rest_icon.icon = ui_style
	rest_icon.screen_loc = ui_above_movement
	rest_icon.hud = src
	rest_icon.update_appearance()
	static_inventory += rest_icon

	spacesuit = new /atom/movable/screen/spacesuit
	spacesuit.hud = src
	infodisplay += spacesuit

	healthdoll = new /atom/movable/screen/healthdoll()
	healthdoll.hud = src
	infodisplay += healthdoll

	stamina = new /atom/movable/screen/stamina()
	stamina.hud = src
	infodisplay += stamina

	pull_icon = new /atom/movable/screen/pull()
	pull_icon.icon = ui_style
	pull_icon.screen_loc = ui_above_intent
	pull_icon.hud = src
	pull_icon.update_appearance()
	static_inventory += pull_icon

	zone_select = new /atom/movable/screen/zone_sel()
	zone_select.icon = ui_style
	zone_select.hud = src
	zone_select.update_appearance()
	static_inventory += zone_select

	combo_display = new /atom/movable/screen/combo()
	infodisplay += combo_display

	gun_setting_icon = new /atom/movable/screen/gun_mode()
	gun_setting_icon.icon = ui_style
	gun_setting_icon.hud = src

	var/atom/movable/screen/gun_option = new /atom/movable/screen/gun_radio()
	gun_option.icon = ui_style
	gun_option.hud = src
	gunpoint_options += gun_option

	gun_option = new /atom/movable/screen/gun_item()
	gun_option.icon = ui_style
	gun_option.hud = src
	gunpoint_options += gun_option

	gun_option = new /atom/movable/screen/gun_move()
	gun_option.icon = ui_style
	gun_option.hud = src
	gunpoint_options += gun_option

	for(var/atom/movable/screen/inventory/inv in (static_inventory + toggleable_inventory))
		if(inv.slot_id)
			inv.hud = src
			inv_slots[TOBITSHIFT(inv.slot_id) + 1] = inv
			inv.update_appearance()

	update_locked_slots()

/datum/hud/necromorph/Destroy()
	//They are actually deleted in QDEL_LIST(infodisplay)
	background = null
	health = null
	foreground = null
	return ..()

/datum/hud/necromorph/show_hud(version = 0,mob/viewmob)
	. = ..()
	if(!.)
		return
	var/mob/screenmob = viewmob || mymob
	hidden_inventory_update(screenmob)

/datum/hud/necromorph/update_locked_slots()
	if(!mymob)
		return
	var/mob/living/carbon/human/H = mymob
	if(!istype(H) || !H.dna.species)
		return
	var/datum/species/S = H.dna.species
	for(var/atom/movable/screen/inventory/inv in (static_inventory + toggleable_inventory))
		if(inv.slot_id)
			if(inv.slot_id in S.no_equip_flags)
				inv.alpha = 128
			else
				inv.alpha = initial(inv.alpha)

/datum/hud/necromorph/hidden_inventory_update(mob/viewer)
	if(!mymob)
		return
	var/mob/living/carbon/human/H = mymob

	var/mob/screenmob = viewer || H

	if(screenmob.hud_used.inventory_shown && screenmob.hud_used.hud_shown)
		if(H.shoes)
			H.shoes.screen_loc = ui_shoes
			screenmob.client.screen += H.shoes
		if(H.gloves)
			H.gloves.screen_loc = ui_gloves
			screenmob.client.screen += H.gloves
		if(H.ears)
			H.ears.screen_loc = ui_ears
			screenmob.client.screen += H.ears
		if(H.glasses)
			H.glasses.screen_loc = ui_glasses
			screenmob.client.screen += H.glasses
		if(H.w_uniform)
			H.w_uniform.screen_loc = ui_iclothing
			screenmob.client.screen += H.w_uniform
		if(H.wear_suit)
			H.wear_suit.screen_loc = ui_oclothing
			screenmob.client.screen += H.wear_suit
		if(H.wear_mask)
			H.wear_mask.screen_loc = ui_mask
			screenmob.client.screen += H.wear_mask
		if(H.wear_neck)
			H.wear_neck.screen_loc = ui_neck
			screenmob.client.screen += H.wear_neck
		if(H.head)
			H.head.screen_loc = ui_head
			screenmob.client.screen += H.head
	else
		if(H.shoes) screenmob.client.screen -= H.shoes
		if(H.gloves) screenmob.client.screen -= H.gloves
		if(H.ears) screenmob.client.screen -= H.ears
		if(H.glasses) screenmob.client.screen -= H.glasses
		if(H.w_uniform) screenmob.client.screen -= H.w_uniform
		if(H.wear_suit) screenmob.client.screen -= H.wear_suit
		if(H.wear_mask) screenmob.client.screen -= H.wear_mask
		if(H.wear_neck) screenmob.client.screen -= H.wear_neck
		if(H.head) screenmob.client.screen -= H.head

/datum/hud/necromorph/persistent_inventory_update(mob/viewer)
	if(!mymob)
		return
	..()
	var/mob/living/carbon/human/H = mymob

	var/mob/screenmob = viewer || H

	if(screenmob.hud_used)
		if(screenmob.hud_used.hud_shown)
			if(H.s_store)
				H.s_store.screen_loc = ui_sstore1
				screenmob.client.screen += H.s_store
			if(H.wear_id)
				H.wear_id.screen_loc = ui_id
				screenmob.client.screen += H.wear_id
			if(H.belt)
				H.belt.screen_loc = ui_belt
				screenmob.client.screen += H.belt
			if(H.back)
				H.back.screen_loc = ui_back
				screenmob.client.screen += H.back
			if(H.l_store)
				H.l_store.screen_loc = ui_storage1
				screenmob.client.screen += H.l_store
			if(H.r_store)
				H.r_store.screen_loc = ui_storage2
				screenmob.client.screen += H.r_store
		else
			if(H.s_store)
				screenmob.client.screen -= H.s_store
			if(H.wear_id)
				screenmob.client.screen -= H.wear_id
			if(H.belt)
				screenmob.client.screen -= H.belt
			if(H.back)
				screenmob.client.screen -= H.back
			if(H.l_store)
				screenmob.client.screen -= H.l_store
			if(H.r_store)
				screenmob.client.screen -= H.r_store

	if(hud_version != HUD_STYLE_NOHUD)
		for(var/obj/item/I in H.held_items)
			I.screen_loc = ui_hand_position(H.get_held_index_of_item(I))
			screenmob.client.screen += I
	else
		for(var/obj/item/I in H.held_items)
			I.screen_loc = null
			screenmob.client.screen -= I

/datum/hud/necromorph/proc/update_healthbar(mob/living/carbon/human/necromorph/necro)
	animate(health.get_filter("alpha_mask"), x = clamp(HUD_METER_PIXEL_WIDTH*(necro.health/necro.maxHealth), 0, HUD_METER_PIXEL_WIDTH), time = 0.5 SECONDS)
	if(necro.dodge_shield > 0)
		foreground.maptext = MAPTEXT("[max(0, necro.health)]+[necro.dodge_shield]/[necro.maxHealth]")
	else
		foreground.maptext = MAPTEXT("[max(0, necro.health)]/[necro.maxHealth]")

/datum/hud/necromorph/proc/update_shieldbar(mob/living/carbon/human/necromorph/necro)
	animate(shield.get_filter("alpha_mask"), x = clamp(HUD_METER_PIXEL_WIDTH*(necro.dodge_shield/necro.maxHealth), 0, HUD_METER_PIXEL_WIDTH), time = 0.5 SECONDS)
	if(necro.dodge_shield > 0)
		foreground.maptext = MAPTEXT("[max(0, necro.health)]+[necro.dodge_shield]/[necro.maxHealth]")
	else
		foreground.maptext = MAPTEXT("[max(0, necro.health)]/[necro.maxHealth]")
