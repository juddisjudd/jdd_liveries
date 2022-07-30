local function viewLiveries()
	if cache.vehicle then return TriggerEvent('getliveries')
else
		lib.notify({
			title = 'Liveries',
			description = 'You are not in a vehicle.',
			position = 'top',
			style = {
				backgroundColor = '#141517',
				color = '#909296'
			},
			icon = 'ban',
			iconColor = '#C53030'
		})
	end
end

RegisterCommand('liveries', viewLiveries)

AddEventHandler('getliveries',function()
	local vehicle = GetVehiclePedIsIn(PlayerPedId())
	local numMods = GetNumVehicleMods(cache.vehicle, 48)
	local numLiveries = GetVehicleLiveryCount(cache.vehicle)

	SetVehicleModKit(cache.vehicle, 0)

	local options = {}
	if numMods > 0 then
		for i = 0, numMods -1 do
			local modLabel = GetModTextLabel(cache.vehicle, 48, i)
			options[#options + 1] = {
				title = "Toggle livery " .. i,
				description = GetLabelText(modLabel),
				event = 'togglelivery',
				args = {
					vehicle = vehicle,
					livery = i
				}
			}
		end
	end

	if numLiveries > 0 then
		for i = 0, numLiveries -1 do
			local modLabel = GetLiveryName(cache.vehicle, i)
			options[#options + 1] = {
				title = "Toggle livery " .. i,
				description = GetLabelText(modLabel),
				event = 'togglelivery',
				args = {
					vehicle = vehicle,
					livery = i
				}
			}
		end
	end

    lib.registerContext({
        id = 'liveries_menu',
        title = 'Vehicle Liveries',
        options = options
    })
    lib.showContext('liveries_menu')
end)

AddEventHandler('togglelivery', function(data)
	SetVehicleLivery(data.vehicle, data.livery)
	SetVehicleMod(data.vehicle, 48, data.livery)
	TriggerEvent('getliveries')
end)
