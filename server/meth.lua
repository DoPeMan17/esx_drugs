local playersProcessingMeth = {}

RegisterServerEvent('esx_illegal:pickedUpHydrochloricAcid')
AddEventHandler('esx_illegal:pickedUpHydrochloricAcid', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem('hydrochloric_acid')

	if xItem.limit ~= -1 and (xItem.count + 1) > xItem.limit then
		TriggerClientEvent('esx:showNotification', _source, _U('hydrochloric_acid_inventoryfull'))
	else
		xPlayer.addInventoryItem(xItem.name, 1)
	end
end)

RegisterServerEvent('esx_illegal:pickedUpSodiumHydroxide')
AddEventHandler('esx_illegal:pickedUpSodiumHydroxide', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem('sodium_hydroxide')

	if xItem.limit ~= -1 and (xItem.count + 1) > xItem.limit then
		TriggerClientEvent('esx:showNotification', _source, _U('sodium_hydroxide_inventoryfull'))
	else
		xPlayer.addInventoryItem(xItem.name, 1)
	end
end)

RegisterServerEvent('esx_illegal:pickedUpSulfuricAcid')
AddEventHandler('esx_illegal:pickedUpSulfuricAcid', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem('sulfuric_acid')

	if xItem.limit ~= -1 and (xItem.count + 1) > xItem.limit then
		TriggerClientEvent('esx:showNotification', _source, _U('sulfuric_acid_inventoryfull'))
	else
		xPlayer.addInventoryItem(xItem.name, 1)
	end
end)

RegisterServerEvent('esx_illegal:processMeth')
AddEventHandler('esx_illegal:processMeth', function()
	if not playersProcessingMeth[source] then
		local _source = source

		playersProcessingMeth[_source] = ESX.SetTimeout(Config.Delays.MethProcessing, function()
			local xPlayer = ESX.GetPlayerFromId(_source)
			local xhydrochloric_acid,xsulfuric_acid,xsodium_hydroxide,xmeth = xPlayer.getInventoryItem('hydrochloric_acid'),xPlayer.getInventoryItem('sulfuric_acid'),xPlayer.getInventoryItem('sodium_hydroxide'), xPlayer.getInventoryItem('meth')

			if xmeth.limit ~= -1 and (xmeth.count + 1) > xmeth.limit then
				TriggerClientEvent('esx:showNotification', _source, _U('meth_processingfull'))
			elseif xhydrochloric_acid.count < 1 then
				TriggerClientEvent('esx:showNotification', _source, _U('meth_processingenough'))
			elseif xsulfuric_acid.count < 1 then
				TriggerClientEvent('esx:showNotification', _source, _U('meth_processingenough'))
			elseif xsodium_hydroxide.count < 1 then
				TriggerClientEvent('esx:showNotification', _source, _U('meth_processingenough'))
			else
				xPlayer.removeInventoryItem('hydrochloric_acid', 1)
				xPlayer.removeInventoryItem('sulfuric_acid', 1)
				xPlayer.removeInventoryItem('sodium_hydroxide', 1)
				xPlayer.addInventoryItem('meth', 1)

				TriggerClientEvent('esx:showNotification', _source, _U('meth_processed'))
			end

			playersProcessingMeth[_source] = nil
		end)
	else
		print(('esx_illegal: %s attempted to exploit meth processing!'):format(GetPlayerIdentifiers(source)[1]))
	end
end)

function CancelProcessing(playerID)
	if playersProcessingMeth[playerID] then
		ESX.ClearTimeout(playersProcessingMeth[playerID])
		playersProcessingMeth[playerID] = nil
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
