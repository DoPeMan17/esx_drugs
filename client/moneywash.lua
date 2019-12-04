local menuOpen = false
local wasOpen = false

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)

		if GetDistanceBetweenCoords(coords, Config.CircleZones.MoneyWash.coords, true) < 5 then
			if not menuOpen then
				ESX.ShowHelpNotification(_U('moneywash_prompt'))

				if IsControlJustReleased(0, Keys['E']) then
					if Config.MoneyWashLicenseEnabled then
						CheckMoneyWashLicense()
					else
						wasOpen = true
						OpenMoneyWash()
					end
				end
			else
				Citizen.Wait(500)
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

function CheckMoneyWashLicense()

	ESX.TriggerServerCallback('esx_illegal:CheckMoneyWashLicense', function(cb)
		if cb then
			wasOpen = true
			OpenMoneyWash()
		else
			ESX.ShowNotification(_U('need_license'))
		end
	end)
end

function OpenMoneyWash()
	ESX.UI.Menu.CloseAll()
	local elements = {
		{label = _U('moneywash_wash'), value = 'moneywash_wash'}
	}
	menuOpen = true

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'drug_shop', {
		title    = _U('moneywash_title'),
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		if data.current.value == 'moneywash_wash' then
			TriggerServerEvent('esx_illegal:Wash')
		end
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