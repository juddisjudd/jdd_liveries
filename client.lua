RegisterCommand('liveries',function()
    TriggerEvent('getliveries')
end)

AddEventHandler('getliveries',function()
    local options = {}
    local vehicle = GetVehiclePedIsIn(PlayerPedId())
    local count = GetVehicleLiveryCount(vehicle)
    local name = GetLabelText(GetLiveryName(vehicle, i))
    for i = 1, count do
	options[#options + 1] = {
		title = "Toggle livery " .. i,
		description = name,
		event = 'togglelivery',
		args = {
			vehicle = vehicle,
			livery = i
		}
	}
    end

    if GetVehicleLivery(vehicle) == -1 then
	lib.notify({
		id = 'some_identifier',
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
