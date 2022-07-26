RegisterCommand('liveries',function()
    TriggerEvent('getliveries')
end)

AddEventHandler('getliveries',function()
    local options = {}
    local vehicle = GetVehiclePedIsIn(PlayerPedId())
    local count = GetVehicleLiveryCount(vehicle)
    for i = 1, count do
		options[#options + 1] = {
			title = "Toggle livery " .. i,
			event = 'togglelivery',
			args = {
				vehicle = vehicle,
				livery = i
			}
		}
    end
	
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
