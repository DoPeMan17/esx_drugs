RegisterServerEvent('esx_illegal:buyLisense2')
AddEventHandler('esx_illegal:buyLisense2', function(itemName)
	local xPlayer = ESX.GetPlayerFromId(source)
	local price = Config.Licenses[itemName]
	local xItem = xPlayer.getInventoryItem(itemName)
	local money = xPlayer.getMoney()

	if money < price then
		TriggerClientEvent('esx:showNotification', source, _U('license_notenough'))
		return
	end
	
	if xItem.count >= 1 then
		TriggerClientEvent('esx:showNotification', source, _U('license_inventoryfull'))
	else
		xPlayer.removeMoney(price)

		xPlayer.addInventoryItem(xItem.name, 1)

		TriggerClientEvent('esx:showNotification', source, _U('license_bought', xItem.label, ESX.Math.GroupDigits(price)))
	end
	
end)

ESX.RegisterServerCallback('esx_illegal:CheckJob', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local job = xPlayer.getJob()

	--[[if (job.name == 'cartel' and (xPlayer.job.grade == 4 or xPlayer.job.grade == 3)) or (job.name == 'tequi-la-la' and (xPlayer.job.grade == 4 or xPlayer.job.grade == 3)) or (job.name == 'unicorn' and (xPlayer.job.grade == 4 or xPlayer.job.grade == 3)) then
		cb(true)
	else
		cb(false)
	end
	--]]
	cb(true)
end)
