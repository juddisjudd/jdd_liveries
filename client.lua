

local function viewLiveries()
	if cache.vehicle then 
		return TriggerEvent('getLiveries')
	else
		lib.notify({
			title = 'Liveries',
			description = 'You are not in a vehicle.',
			position = 'top',
			style = { backgroundColor = '#141517', color = '#909296' },
			icon = 'ban',
			iconColor = '#C53030'
		})
	end
end

RegisterCommand('liveries', viewLiveries)

local function formatOption(label, vehicle, i)
	return {
		title = ('Toggle Livery: %s'):format(i + 1),
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
		return lib.notify({
			title = 'Liveries',
			description = 'No liveries have been found for this vehicle.',
			position = 'top',
			style = { backgroundColor = '#141517', color = '#909296' },
			icon = 'ban',
			iconColor = '#C53030'
		})
	end

	lib.registerContext({ id = 'liveries_menu', title = 'Vehicle Liveries', options = options })
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