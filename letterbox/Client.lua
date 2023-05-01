local Locations = require 'Config'

local props = {}

for i = 1, #Locations do
    local v = Locations[i]

    lib.requestModel(v.prop, 1000)

    local prop = CreateObject(v.prop, vec3(v.coords.x, v.coords.y, v.coords.z), false, true, true)
    SetEntityHeading(prop, v.coords.w)
    FreezeEntityPosition(prop, true)
    SetCanClimbOnEntity(prop, true)

    exports.ox_target:addLocalEntity(prop, {
        {
            name = ('letterbox_%s'):format(i),
            label = 'View Letterbox',
            icon = 'fa-solid fa-box',
            onSelect = function()
                exports.ox_inventory:openInventory('stash', ('letterbox_%s'):format(i))
            end,
            canInteract = function(_, distance)
                return distance < 2.0
            end,
        },
    })

    props[i] = prop
end

AddEventHandler('onResourceStop', function(resource)
   if resource == GetCurrentResourceName() then
    for i = 1, #props do
        DeleteEntity(props[i])
        exports.ox_target:removeLocalEntity(props[i], ('letterbox_%s'):format(i))
    end
   end
end)