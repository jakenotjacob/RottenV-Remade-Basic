Citizen.CreateThread(function()
	-- these were never local since they are unique anyway, but you do you i guess
	local defaultHungerLoss = 0.0003
	local defaultThirstLoss = 0.0005
	local SprintingHungerLoss = 0.0005
	local SprintingThirstLoss = 0.0007
	local drivingHungerLoss = 0.0002
	local drivingThirstLoss = 0.0003
	local Saturation = 0 -- hey, this is a thing i wanted to implement, but never did, horayy
	while true do
		Citizen.Wait(0)
		if DecorGetFloat(PlayerPedId(),"hunger") > 100.0 then
			DecorSetFloat(PlayerPedId(), "hunger", 100.0)
		end
		if DecorGetFloat(PlayerPedId(),"thirst") > 100.0 then
			DecorSetFloat(PlayerPedId(), "thirst", 100.0)
		end
		if IsPedSprinting(PlayerPedId()) then
			DecorSetFloat(PlayerPedId(), "hunger", DecorGetFloat(PlayerPedId(),"hunger")-SprintingHungerLoss)
			DecorSetFloat(PlayerPedId(), "thirst", DecorGetFloat(PlayerPedId(),"thirst")-SprintingThirstLoss)
		elseif IsPedInVehicle(PlayerPedId()) then
			DecorSetFloat(PlayerPedId(), "hunger", DecorGetFloat(PlayerPedId(),"hunger")-drivingHungerLoss)
			DecorSetFloat(PlayerPedId(), "thirst", DecorGetFloat(PlayerPedId(),"thirst")-drivingThirstLoss)
		else
			DecorSetFloat(PlayerPedId(), "hunger", DecorGetFloat(PlayerPedId(),"hunger")-defaultHungerLoss)
			DecorSetFloat(PlayerPedId(), "thirst", DecorGetFloat(PlayerPedId(),"thirst")-defaultThirstLoss)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5000)
		if DecorGetFloat(PlayerPedId(),"hunger") < 15.0 and DecorGetFloat(PlayerPedId(),"hunger") > 2.0 then
			SetEntityHealth(PlayerPedId(),GetEntityHealth(PlayerPedId())-4)
		end
		if DecorGetFloat(PlayerPedId(),"thirst") < 15.0 and DecorGetFloat(PlayerPedId(),"thirst") > 2.0 then
			SetEntityHealth(PlayerPedId(),GetEntityHealth(PlayerPedId())-4)
		end
		if DecorGetFloat(PlayerPedId(),"hunger") < 2.0 then
			SetEntityHealth(PlayerPedId(), GetEntityHealth(PlayerPedId())-15)
		end
		if DecorGetFloat(PlayerPedId(),"thirst") < 2.0 then
			SetEntityHealth(PlayerPedId(), GetEntityHealth(PlayerPedId())-15)
		end
	end
end)

consumableItems = {
	{
		name = "Apple",
		hunger = 15.0,
		thirst = 3.0,
		health = 5,
		desc = "The healthy snack for Everyone!",
		consumable = true
	},
	{
		name = "Cola Bottle",
		hunger = 3.0,
		thirst = 30.0,
		health = 10,
		desc = "Famous Cocaine-Containing Drink",
		consumable = true
	},
	{
		name = "Milk Bottle",
		hunger = 10.0,
		thirst = 40.0,
		health = 5,
		desc = "Galactic.",
		consumable = true
	},
	{
		name = "Chips Package",
		hunger = 15.0,
		thirst = -10.0,
		health = 4,
		desc = "Quick to eat, doesn't taste like much, fills the stomach tho.",
		consumable = true
	},
	{
		name = "Beef",
		hunger = 40.0,
		thirst = -25.0,
		health = 6,
		desc = "Yummie",
		consumable = true
	},
	{
		name = "Beefium",
		hunger = 60.0,
		thirst = -10.0,
		health = 6,
		desc = "Due to extensive research scientists have discovered a new form of beef called Beefium, better than ever, and tastier too!",
		consumable = true
	},
	{
		name = "Bandage",
		hunger = 0.0,
		thirst = 0.0,
		health = 20,
		desc = "Please do not apply on broken hearts.",
		consumable = true
	},
	{
		name = "Orange Juice Pack",
		hunger = 3.0,
		thirst = 10.0,
		health = 5,
		desc = "Tasty AND Healthy!",
		consumable = true
	},
	{
		name = "Pizza Slice",
		hunger = 50.0,
		thirst = 30.0,
		health = 5,
		desc = "Fat.. but so delicious.",
		consumable = true
	},
	{
		name = "Fried Chicken",
		hunger = 15.0,
		thirst = -15.0,
		health = 5,
		desc = "Deep Fried is best fried.",
		consumable = true
	},
	{
		name = "Small Medkit",
		hunger = 0.0,
		thirst = 0.0,
		health = 50,
		desc = "Mandatory in every Motorised Vehicle by Law, also useful if you are about to die.",
		consumable = true
	},
	{
		name = "Water Bottle",
		hunger = 0.0,
		thirst = 50.0,
		health = 5,
		desc = "Fresh, clean water, delicious.",
		consumable = true
	},
	{
		name = "Engine Repair Kit",
		desc = "Usable to repair most types of combustion engines",
		property = "vehiclerepair",
		consumable = false
	},
	{
		name = "Tyre Repair Kit",
		desc = "Usable to repair various types of tires",
		property = "tyrerepair",
		consumable = false
	},
	{
		name = "Twinkie",
		hunger = 10.0,
		thirst = 6.0,
		health = 10,
		desc = "I hate coconut, not the taste, the consistency.",
		consumable = true
	},
	{
		name = "Antibiotics",
		desc = "This will save my Life! people said, it didn't, but now it's here to save yours! Can heal infections.",
		property = "cureinfection",
		hunger = 0.0,
		thirst = 0.0,
		health = 0,
		consumable = true
	},
}

consumableItems.count = {}
for i,Consumable in ipairs(consumableItems) do
	consumableItems.count[i] = 0.0
end
