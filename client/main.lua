local Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
    ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}


local CurrentActionMsg          = ''



RegisterNetEvent("AdvertError")
AddEventHandler("AdvertError", function(inputText)
	SetNotificationTextEntry("STRING");
	AddTextComponentString(inputText);
	SetNotificationMessage("CHAR_LIFEINVADER", "CHAR_LIFEINVADER", true, 1, "~w~Weazel ~r~News:~w~", _U('error_occured'), "");
	DrawNotification(false, true);
end)

RegisterNetEvent("Advert")
AddEventHandler("Advert", function()
		DisplayOnscreenKeyboard(false, "FMMC_KEY_TIP8", "", "", "", "", "", Config.Characters)
		local input = true
		Citizen.CreateThread(function()
		while input do
		if input == true then
		HideHudAndRadarThisFrame()
		if UpdateOnscreenKeyboard() == 3 then
		input = false
		elseif UpdateOnscreenKeyboard() == 1 then
		local inputText = GetOnscreenKeyboardResult()
		if string.len(inputText) > 0 then
		TriggerServerEvent('SyncAdvert', inputText)
		input = false
		else
			DisplayOnscreenKeyboard(false, "FMMC_KEY_TIP8", "", "", "", "", "", Config.Characters)
		end
		elseif UpdateOnscreenKeyboard() == 2 then
		input = false
		end
		end
		 Citizen.Wait(0)
		 end
			
end)
end)

RegisterNetEvent('DisplayAdvert')
AddEventHandler('DisplayAdvert',function(inputText)
	SetNotificationTextEntry("STRING");
	AddTextComponentString(inputText);
	SetNotificationMessage("CHAR_LIFEINVADER", "CHAR_LIFEINVADER", true, 1, "~w~Weazel ~r~News:~w~", _U("DisplayAdvert"), "");
	DrawNotification(false, true);
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        HideHudComponentThisFrame(1)
        HideHudComponentThisFrame(3)
        HideHudComponentThisFrame(4)
        HideHudComponentThisFrame(6)
        HideHudComponentThisFrame(7)
        HideHudComponentThisFrame(8)
        HideHudComponentThisFrame(9)
        HideHudComponentThisFrame(13)
    end
end)


--- Marker 

Citizen.CreateThread(function()
	while true do
	
		local isInMarker = false
		local playerPed      = PlayerPedId()
		local coords         = GetEntityCoords(playerPed)

		Wait(0)
		DrawMarker(22, -594.46691894531, -930.03179931641, 23.869626998901, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 200, 55, 50, 100, false, true, 2, true, false, false, false)
		
		if GetDistanceBetweenCoords(coords, -594.46691894531, -930.03179931641, 23.869626998901, true) < 1.5 then
			isInMarker = true
			SetTextComponentFormat('STRING')
			AddTextComponentString(_U('advertise'))
            DisplayHelpTextFromStringLabel(0, 0, 1, -1)
		else
			isInMarker = false
		end
		if IsControlJustReleased(0, Keys['E']) and isInMarker == true then			
			TriggerEvent('Advert')
		end
			
	end
end)


-- Blip

local blips = {
	{title="Weazel News", colour=5, id=682, x = -594.37426757812, y = -929.93981933594, z = 23.86962890625}
}

Citizen.CreateThread(function()

    for _, info in pairs(blips) do
      info.blip = AddBlipForCoord(info.x, info.y, info.z)
      SetBlipSprite(info.blip, info.id)
      SetBlipDisplay(info.blip, 4)
      SetBlipScale(info.blip, 0.8)
      SetBlipColour(info.blip, info.colour)
      SetBlipAsShortRange(info.blip, true)
	  BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(info.title)
      EndTextCommandSetBlipName(info.blip)
    end
end)

