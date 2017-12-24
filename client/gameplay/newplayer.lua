-- CONFIG --

local spawnWithFlashlight = true
local displayRadar = true
local bool = true

zombiekillsthislife = 0
playerkillsthislife = 0
zombiekills = 0
playerkills = 0

-- CODE --

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if bool then
			TriggerServerEvent("Z:newplayer", PlayerId())
			TriggerServerEvent("Z:newplayerID", GetPlayerServerId(PlayerId()))
			bool = false
			SetBlackout(true)
		end
	end
end)

local welcomed = false
DecorRegister("hunger",1)
DecorRegister("thirst",1)
DecorRegister("humanity",1)

Citizen.CreateThread(function()
	AddEventHandler('baseevents:onPlayerKilled', function(killerId)
    local player = NetworkGetPlayerIndexFromPed(PlayerPedId())
    local attacker = killerId

		if GetPlayerFromServerId(attacker) and attacker ~= GetPlayerServerId(PlayerId()) then

			-- this is concept code for the "dropping loot when dying", no idea if it works, needs testing, hence, it hasn't been implemented yet
			-- NEEDS MUTLI ITEM PICKUP SUPPORT
			--[[
			for item,Consumable in ipairs(consumableItems) do
				if consumableItems.count[item] > 0.0 then
					local playerX, playerY, playerZ = table.unpack(GetEntityCoords(PlayerPedId(), not IsEntityDead(PlayerPedId()) ))
					ForceCreateFoodPickupAtCoord(playerX + 1, playerY, playerZ, item, consumableItems.count[item])
				end
			end
			--]]
		end
		playerkillsthislife = 0
		zombiekillsthislife = 0
		initiateSave(true)
		if possessed then
			unPossessPlayer(PlayerPedId())
			possessed = false
		end
	end)

	AddEventHandler('baseevents:onPlayerWasted', function()
		playerkillsthislife = 0
		zombiekillsthislife = 0
		initiateSave(true)
		if possessed then
			unPossessPlayer(PlayerPedId())
			possessed = false
		end
	end)

	AddEventHandler('baseevents:onPlayerDied', function()
		playerkillsthislife = 0
		zombiekillsthislife = 0
		initiateSave(true)
		if possessed then
			unPossessPlayer(PlayerPedId())
			possessed = false
		end
	end)
end)

Citizen.CreateThread(function()
	AddEventHandler("playerSpawned", function(spawn,pid)
		if spawnWithFlashlight then
			for i,Consumable in ipairs(consumableItems) do
				consumableItems.count[i] = 0.0
			end
			GiveWeaponToPed(PlayerPedId(), GetHashKey("WEAPON_FLASHLIGHT"), 1, false, false)
			GiveWeaponToPed(PlayerPedId(), GetHashKey("WEAPON_BAT"), 1, false, false)
			GiveWeaponToPed(PlayerPedId(), 0xFBAB5776, true)
			DecorSetFloat(PlayerPedId(), "hunger", 100.0)
			DecorSetFloat(PlayerPedId(), "thirst", 100.0)
			DecorSetFloat(PlayerPedId(), "humanity", 500.0)
			playerkillsthislife = 0
			zombiekillsthislife = 0
			infected = false
			consumableItems.count[1] = 1.0
			consumableItems.count[2] = 1.0
			StatSetInt("STAMINA", 40,1)

			-- this is debug code
			--[[
			spawnindex=0
			for i,Consumable in ipairs(consumableItems) do
				spawnindex=spawnindex+1
				consumableItems.count[spawnindex] = 99.0
				DecorSetFloat(PlayerPedId(), Consumable, 99.0)
			end
			]]

			SetPedDropsWeaponsWhenDead(PlayerPedId(),true)
			NetworkSetFriendlyFireOption(true)
			SetCanAttackFriendly(PlayerPedId(), true, true)
			TriggerEvent('showNotification', "Press 'M' to open your Interaction Menu!")
			Wait(5000)
			if pid == PlayerId() then
				initiateSave(true)
			end
		end
	end)
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if GetEntityHeightAboveGround(PlayerPedId()) < 80 and IsPedInParachuteFreeFall(PlayerPedId()) then
			ForcePedToOpenParachute(PlayerPedId())
		end
	end
end)
