//This one's from bay12
/obj/machinery/vending/plasmaresearch
	name = "\improper Bombuddy 3000"
	desc = "All the fine parts you need in one vending machine!"
	products = list(
		/obj/item/clothing/under/rank/rnd/ds_research = 6,
		/obj/item/clothing/suit/hooded/ds = 2,
		/obj/item/clothing/suit/hooded/eg = 2,
		/obj/item/clothing/suit/hooded/eg/white = 2,
		/obj/item/transfer_valve = 6,
		/obj/item/assembly/timer = 6,
		/obj/item/assembly/signaler = 6,
		/obj/item/assembly/prox_sensor = 6,
		/obj/item/assembly/igniter = 6
	)
	contraband = list(/obj/item/assembly/health = 3)
	default_price = PAYCHECK_ASSISTANT
	extra_price = PAYCHECK_ASSISTANT
	payment_department = ACCOUNT_STATION_MASTER

	discount_access = ACCESS_ORDNANCE
