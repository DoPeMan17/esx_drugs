local menuOpen = false
local wasOpen = false

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)

		if GetDistanceBetweenCoords(coords, Config.CircleZones.LicenseShop.coords, true) < 5 then
			if not menuOpen then
				checkjob()
			end
		--[[else
			if wasOpen then
				wasOpen = false
				ESX.UI.Menu.CloseAll()
			end

			Citizen.Wait(500)--]]
		end
	end
end)

function checkjob()
	ESX.TriggerServerCallback('esx_illegal:CheckJob', function(cb)
	if cb then
		ESX.ShowHelpNotification(_U('licenseshop_prompt'))
			if IsControlJustReleased(0, Keys['E']) then
				wasOpen = true
				OpenlicenseShop()
			else
				Citizen.Wait(500)
			end
		end
	end)
end

function OpenlicenseShop()
	ESX.UI.Menu.CloseAll()
	local elements = {}
	menuOpen = true

	for k, v in pairs(ESX.GetPlayerData().inventory) do
		local price = Config.Licenses[v.name]

		if price and v.count >= 0 then
			table.insert(elements, {
				label = ('%s - <span style="color:green;">%s</span>'):format("Buy " .. v.label, _U('dealer_item', ESX.Math.GroupDigits(price))),
				name = v.name,
				price = price,

			})
		end
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'license_shop', {
		title    = _U('licenseshop_title'),
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		TriggerServerEvent('esx_illegal:buyLisense2', data.current.name)
	end, function(data, menu)
		menu.close()
		menuOpen = false
	end)
end

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		if menuOpen then
			ESX.UI.Menu.CloseAll()
		end
	end
end)