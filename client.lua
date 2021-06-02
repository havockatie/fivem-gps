function SetWaypoint(waypoint)
    if waypoint == nil or waypoint == '' then
        local PlayerCoords = GetEntityCoords(PlayerPedId())

        SetNewWaypoint(PlayerCoords)
    else
        for street, coords in pairs(streetList) do
            if string.match(string.lower(street), string.lower(waypoint)) then                
                SetNewWaypoint(coords[1], coords[2], coords[3])

                -- TriggerEvent('chatMessage', "GPS", {255, 255, 0}, "Destination Set to " .. street)
                exports['mb_notify']:sendNotification('GPS set destination to '..string.upper(waypoint), {duration=5000, type="info", vertical="top", horizontal="center", variant="filled"})
				break
            end
        end
    end
end

RegisterCommand("gps", function(source, args, rawCommand)
    if #args < 1 then
    else
        local waypoint = string.sub(rawCommand, 5) 
        SetWaypoint(waypoint)
    end
end)

function dump(o, depth)
    depth = depth or 1

    if type(o) == 'table' then
        local s = '\n'
        for i = 1,depth,1 
        do 
            s = s .. ' '
        end
        s = s .. '{\n'

        depth = depth + 4
        for k,v in pairs(o) do            
            if type(k) ~= 'number' then k = '"'..k..'"' end

            for i = 1,depth,1 
            do 
                s = s .. ' '
            end
            s = s .. '['..k..'] = ' .. dump(v, depth) .. ',\n'
        end

        for i = 1,depth,1 
        do 
            s = s .. ' '
        end
        return s .. '}\n'
    else
        return tostring(o)
    end
 end

RegisterNetEvent('gps:client:setwaypoint')
AddEventHandler('gps:client:setwaypoint', function(data)
    -- print(dump(data))
    local waypoint = data["waypoint"]
    SetWaypoint(waypoint)
end)