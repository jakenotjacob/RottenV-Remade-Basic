Citizen.CreateThread(function()
	while true do
		Wait(1)
		SetTextFont(0)
		SetTextProportional(1)
		SetTextScale(0.0, 0.3)

		SetTextColour(128, 128, 200, 255)

		SetTextDropshadow(0, 0, 0, 0, 255)
		SetTextEdge(1, 0, 0, 0, 255)
		SetTextDropShadow()
		SetTextOutline()
		SetTextEntry("STRING")
		AddTextComponentString("meow 🐶")
		DrawText(0.005, 0.005)

		health = GetEntityHealth(PlayerPedId())
		if health then
			SetTextFont(0)
			SetTextProportional(1)
			SetTextScale(0.0, 0.55)
			if health < 130 then
				SetTextColour(255, 0, 0, 255)
			else
				SetTextColour(0, 255, 0, 255)
			end
			SetTextDropshadow(0, 0, 0, 0, 255)
			SetTextEdge(1, 0, 0, 0, 255)
			SetTextDropShadow()
			SetTextOutline()
			SetTextEntry("STRING")
			local str = "HP: " .. health - 100
			if infected then str = "HP: " .. health - 100 .." ( INFECTED )" end
			AddTextComponentString(str)
			DrawText(0.16, 0.95)
		end
		hunger = DecorGetFloat(PlayerPedId(), "hunger")
		if hunger then
			SetTextFont(0)
			SetTextProportional(1)
			SetTextScale(0.0, 0.55)
			if hunger < 40.0 and hunger > 20.0 then
				SetTextColour(255, 191, 0, 255)
			elseif hunger < 20.0 then
				SetTextColour(255, 0, 0, 255)
			else
				SetTextColour(0, 255, 0, 255)
			end
			SetTextDropshadow(0, 0, 0, 0, 255)
			SetTextEdge(1, 0, 0, 0, 255)
			SetTextDropShadow()
			SetTextOutline()
			SetTextEntry("STRING")
			AddTextComponentString("Hunger: " .. math.round(hunger))
			DrawText(0.16, 0.85)
		end
		thirst = DecorGetFloat(PlayerPedId(), "thirst")
		if thirst then
			SetTextFont(0)
			SetTextProportional(1)
			SetTextScale(0.0, 0.55)
			if thirst < 40.0 and thirst > 20.0 then
				SetTextColour(255, 191, 0, 255)
			elseif thirst < 20.0 then
				SetTextColour(255, 0, 0, 255)
			else
				SetTextColour(0, 255, 0, 255)
			end
			SetTextDropshadow(0, 0, 0, 0, 255)
			SetTextEdge(1, 0, 0, 0, 255)
			SetTextDropShadow()
			SetTextOutline()
			SetTextEntry("STRING")
			AddTextComponentString("Thirst: " .. math.round(thirst))
			DrawText(0.16, 0.90)
		end

		local humanity = DecorGetFloat(PlayerPedId(), "humanity")
		if humanity then
			SetTextFont(0)
			SetTextProportional(1)
			SetTextScale(0.0, 0.55)
			if humanity < 200.0 then
				SetTextColour(255, 191, 0, 255)
			elseif humanity > 700.0 then
				SetTextColour(255, 0, 0, 255)
			else
				SetTextColour(0, 255, 0, 255)
			end
			SetTextDropshadow(0, 0, 0, 0, 255)
			SetTextEdge(1, 0, 0, 0, 255)
			SetTextDropShadow()
			SetTextOutline()
			SetTextEntry("STRING")
			AddTextComponentString("Humanity: " .. math.round(humanity))
			DrawText(0.16, 0.80)

		end
	end
end)


function math.round(num, numDecimalPlaces)
	if numDecimalPlaces and numDecimalPlaces>0 then
		local mult = 10^numDecimalPlaces
		return math.floor(num * mult + 0.5) / mult
	end
	return math.floor(num + 0.5)
end

function round(a,b)
	math.round(a,b)

end