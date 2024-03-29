ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local lastAdDate = 0
local webhook = ""

RegisterServerEvent("SyncAdvert")
AddEventHandler('SyncAdvert', function(inputText)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	if os.time(os.date("!*t")) > (lastAdDate + Config.Cooldown) then
		lastAdDate = os.time(os.date("!*t"))

		if xPlayer.getMoney() >= Config.AdvertCosts then
			xPlayer.removeMoney(Config.AdvertCosts)
			xPlayer.showNotification('$~g~' .. Config.AdvertCosts .. _U('AdvertPayed'))

		TriggerClientEvent('DisplayAdvert', -1, inputText, xPlayer.getName())
			
			PerformHttpRequest(webhook, function(err, text, headers) end, "POST", json.encode({
				["username"] = Config.Username,
				["avatar_url"] = Config.Logo,
					embeds = {{
					["color"] = tonumber(Config.Color),
					["author"] = {
						["name"] = "@" .. xPlayer.name,
						["icon_url"] = Config.AuthorIcon,
					},
						["description"] = "" .. inputText,
						["footer"] = {
							["text"] = Config.FooterText .. " • " .. os.date("%d.%m.%Y") .. " um " .. os.date("%H:%M") .. " Uhr",
							["icon_url"] = Config.FooterIcon,
						},
					}}
			}), {["Content-Type"] = "application/json"})
		else
			local missingMoney = Config.AdvertCosts - xPlayer.getMoney()
			xPlayer.showNotification(_U('not_enough', ESX.Math.GroupDigits(missingMoney)))
		end	
	else
		TriggerClientEvent('AdvertError', source, _U('cooldown'))	
	end		
	
end)
