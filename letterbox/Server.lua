local Locations = require 'Config'

for i = 1, #Locations do
    exports.ox_inventory:RegisterStash(('letterbox_%s'):format(i), 'Letter Box', 20, 20000, nil, nil, vec3(Locations[i].coords.x, Locations[i].coords.y, Locations[i].coords.z))
end