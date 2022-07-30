lib.locale()

local function viewLiveries()
	if cache.vehicle then 
		return TriggerEvent('getLiveries')
	else
		lib.notify({ title = locale('liveries'), description = locale('not_in_vehicle'), type = 'error', position = 'top', icon = 'ban' })
	end
end

RegisterCommand('liveries', viewLiveries)

local function formatOption(label, vehicle, i)
	return {
		title = locale('toggle_livery', i + 1),
		description = label,
		event = 'toggleLivery',
		args = { vehicle = vehicle, livery = i }
	}
end

AddEventHandler('getLiveries', function()
	local vehicle = cache.vehicle
	local numMods = GetNumVehicleMods(vehicle, 48)
	local numLiveries = GetVehicleLiveryCount(vehicle)

	SetVehicleModKit(vehicle, 0)

	local options, count = {}, 0

	if numMods > 0 then
		for i = 0, numMods -1 do
			count += 1
			options[count] = formatOption(GetLabelText(GetModTextLabel(vehicle, 48, i)), vehicle, i)
		end
	end

	if numLiveries > 0 then
		for i = 0, numLiveries -1 do
			count += 1
			options[count] = formatOption(GetLabelText(GetLiveryName(vehicle, i)), vehicle, i)
		end
	end

	if count == 0 then
		return lib.notify({ title = locale('liveries'), description = locale('no_liveries_found'), type = 'error', position = 'top', icon = 'ban' })
	end

	lib.registerContext({ id = 'liveries_menu', title = locale('vehicle_liveries'), options = options })
	lib.showContext('liveries_menu')
end)

AddEventHandler('toggleLivery', function(data)
	local vehicle, livery = data?.vehicle, data?.livery
	if not vehicle or not livery then
		return
	end

	SetVehicleLivery(vehicle, livery)
	SetVehicleMod(vehicle, 48, livery)

	TriggerEvent('getLiveries')
end)