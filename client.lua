RegisterCommand('liveries',function()
	if IsPedInAnyVehicle(PlayerPedId(), 0) then
    	TriggerEvent('getliveries')
	else 
		lib.notify({
			id = 'invehicle',
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
end)

AddEventHandler('getliveries',function()
    local vehicle = GetVehiclePedIsIn(PlayerPedId()) -- Get the current vehicle the player is in
    local count = GetVehicleLiveryCount(vehicle) -- Get the count of all liveries vehicle has
    local name = GetLabelText(GetLiveryName(vehicle, liveryIndex)) -- This should be returning livery name
    local options = {}
    for liveries = 1, count do
		options[#options + 1] = {
			title = "Toggle livery " .. liveries,
			description = name,
			event = 'togglelivery',
			args = {
				vehicle = vehicle,
				livery = liveries
			}
		}
	end
	if GetVehicleLivery(vehicle) == -1 then
		lib.notify({
			id = 'no_livery',
			title = 'Liveries',
			description = 'No liveries found for this vehicle.',
			position = 'top',
			style = {
				backgroundColor = '#141517',
				color = '#909296'
			},
			icon = 'ban',
			iconColor = '#C53030'
		})
	return end
	
    lib.registerContext({
        id = 'liveries_menu',
        title = 'Vehicle Liveries',
        options = options
    })
    lib.showContext('liveries_menu')
end)

AddEventHandler('togglelivery',function(data)
    SetVehicleLivery(data.vehicle,data.livery)
    TriggerEvent('getliveries')
end)
