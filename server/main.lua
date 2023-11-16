local DoorInfo	= {}
ServerCallbacks = {}

RegisterServerCallback = function(name, cb)
	ServerCallbacks[name] = cb
end


TriggerServerCallback = function(name, requestId, source, cb, ...)
	if ServerCallbacks[name] then
		ServerCallbacks[name](source, cb, ...)
	end
end

RegisterServerEvent('CMRP:UpdateVerrouillageServer')
AddEventHandler('CMRP:UpdateVerrouillageServer', function(doorID, state)
	if type(doorID) ~= 'number' then
		return
	end

	DoorInfo[doorID] = {}

	DoorInfo[doorID].state = state
	DoorInfo[doorID].doorID = doorID

	TriggerClientEvent('CMRP:UpdateVerrouillageClient', -1, doorID, state)
end)

RegisterServerCallback('CMRP:GetInfoPortes', function(source, cb)
	cb(DoorInfo, #DoorInfo)
end)