local playersProcessingLSD = {}

RegisterServerEvent('esx_illegal:processLSD')
AddEventHandler('esx_illegal:processLSD', function()
	if not playersProcessingLSD[source] then
		local _source = source

		playersProcessingLSD[_source] = ESX.SetTimeout(Config.Delays.lsdProcessing, function()
			local xPlayer = ESX.GetPlayerFromId(_source)
			local xLSA, xThionylChloride, xLSD = xPlayer.getInventoryItem('lsa'), xPlayer.getInventoryItem('thionyl_chloride'), xPlayer.getInventoryItem('lsd')

			if xLSA.count > 0 and xThionylChloride.count > 0 then
				if xPlayer.canSwapItem('lsa', 1, 'lsd', 1) and xPlayer.canSwapItem('thionyl_chloride', 1, 'lsd', 1) then
					xPlayer.removeInventoryItem('lsa', 1)
					xPlayer.removeInventoryItem('thionyl_chloride', 1)
					xPlayer.addInventoryItem('lsd', 1)

					xPlayer.showNotification(_U('lsd_processed'))
				else
					xPlayer.showNotification(_U('lsd_processingfull'))
				end
			else
				xPlayer.showNotification(_U('lsd_processingenough'))
			end

			playersProcessingLSD[_source] = nil
		end)
	else
		print(('esx_illegal: %s attempted to exploit lsd processing!'):format(GetPlayerIdentifiers(source)[1]))
	end
end)

RegisterServerEvent('esx_illegal:processThionylChloride')
AddEventHandler('esx_illegal:processThionylChloride', function()
	if not playersProcessingLSD[source] then
		local _source = source

		playersProcessingLSD[_source] = ESX.SetTimeout(Config.Delays.lsdProcessing, function()
			local xPlayer = ESX.GetPlayerFromId(_source)
			local xLSA, xChemicals, xThionylChloride = xPlayer.getInventoryItem('lsa'), xPlayer.getInventoryItem('chemicals'), xPlayer.getInventoryItem('thionyl_chloride')

			if xLSA.count > 0 and xChemicals.count > 0 then
				if xPlayer.canSwapItem('lsa', 1, 'thionyl_chloride', 1) and xPlayer.canSwapItem('chemicals', 1, 'thionyl_chloride', 1) then
					xPlayer.removeInventoryItem('lsa', 1)
					xPlayer.removeInventoryItem('chemicals', 1)
					xPlayer.addInventoryItem('thionyl_chloride', 1)

					xPlayer.showNotification(_U('thionylchloride_processed'))
				else
					xPlayer.showNotification(_U('thionylchloride_processingfull'))
				end
			else
				xPlayer.showNotification(_U('thionylchloride_processingenough'))
			end

			playersProcessingLSD[_source] = nil
		end)
	else
		print(('esx_illegal: %s attempted to exploit lsd processing!'):format(GetPlayerIdentifiers(source)[1]))
	end
end)

function CancelProcessing(playerID)
	if playersProcessingLSD[playerID] then
		ESX.ClearTimeout(playersProcessingLSD[playerID])
		playersProcessingLSD[playerID] = nil
	end
end

RegisterServerEvent('esx_illegal:cancelProcessing')
AddEventHandler('esx_illegal:cancelProcessing', function()
	CancelProcessing(source)
end)

AddEventHandler('esx:playerDropped', function(playerID, reason)
	CancelProcessing(playerID)
end)

RegisterServerEvent('esx:onPlayerDeath')
AddEventHandler('esx:onPlayerDeath', function(data)
	CancelProcessing(source)
end)
