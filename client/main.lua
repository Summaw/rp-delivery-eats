local isOnJob = false
local JobBlip = nil
local deliveryAmount = nil

local inPickup = false
local inDelivery = false
local interacting = false

local DeliveryLocations = { -- List of locations for delivery
    vector4(-212.88, -1618.16, 34.87, 183.45),
    vector4(-223.15, -1617.6, 34.87, 90.52),
    vector4(-223.15, -1601.2, 34.88, 89.98),
    vector4(-223.06, -1585.81, 34.87, 96.12),
    vector4(-219.32, -1579.92, 34.87, 56.45),
    vector4(-215.66, -1576.28, 34.87, 328.55),
    vector4(-208.74, -1600.64, 34.87, 262.82),
    vector4(-210.01, -1607.03, 34.87, 258.99),
    vector4(-205.7, -1585.59, 38.05, 261.13),
    vector4(-215.73, -1576.32, 38.05, 318.59),
    vector4(-219.29, -1579.92, 38.05, 57.37),
    vector4(-223.09, -1585.89, 38.05, 84.95),
    vector4(-223.07, -1601.14, 38.05, 91.67),
    vector4(-223.08, -1617.59, 38.06, 100.36),
    vector4(-212.1, -1617.63, 38.05, 253.22),
    vector4(-209.96, -1607.11, 38.05, 262.46),
    vector4(-208.63, -1600.57, 38.05, 264.01),
    vector4(-160.08, -1636.25, 34.03, 319.31),
    vector4(-161.1, -1638.77, 34.03, 139.27),
    vector4(-161.66, -1638.4, 37.25, 142.38),
    vector4(179.88, -1637.35, 29.29, 326.86),
    vector4(-150.35, -1625.66, 33.66, 235.2),
    vector4(-151.32, -1622.34, 33.65, 56.46),
    vector4(-144.95, -1618.58, 36.05, 230.86),
    vector4(-152.42, -1623.58, 36.85, 51.96),
    vector4(-150.36, -1625.62, 36.85, 236.43),
    vector4(55.66, -1586.22, 29.6, 230.32),
    vector4(20.43, -1505.37, 31.85, 54.24),
    vector4(-1098.15, -345.84, 37.8, 355.64),
    vector4(-1102.43, -367.91, 37.78, 211.79),
    vector4(-1112.61, -355.77, 37.8, 86.28),
    vector4(-1077.63, -354.84, 37.8, 204.43),
    vector4(-930.84, -214.46, 38.55, 265.65),
    vector4(-783.65, -390.64, 37.33, 334.83),
    vector4(-733.45, -317.38, 36.55, 343.73),
    vector4(-1200.24, -156.96, 40.09, 193.64),
    vector4(-1440.64, -174.37, 47.7, 93.43),
    vector4(-336.23, 30.89, 47.86, 258.93),
    vector4(-338.85, 21.43, 47.86, 258.64),
    vector4(-345.18, 17.91, 47.86, 168.13),
    vector4(-360.45, 20.89, 47.86, 174.26),
    vector4(-371.42, 23.1, 47.86, 178.76),
    vector4(-362.25, 57.76, 54.43, 2.21),
    vector4(-350.59, 57.74, 54.43, 359.38),
    vector4(-344.57, 57.55, 54.43, 354.84),
    vector4(-333.07, 57.1, 54.43, 354.49),
    vector4(-483.53, -18.08, 45.09, 176.3),
    vector4(-492.97, -17.99, 45.06, 177.8),
    vector4(-500.47, -19.27, 45.13, 218.85),
    vector4(-45.47, -1445.44, 32.43, 273.99),
    vector4(-48.01, -1385.91, 29.49, 178.92),
    vector4(56.49, -1922.77, 21.91, 140.63),
    vector4(152.53, -1557.3, 29.42, 312.94),
    vector4(-50.32, -1783.28, 28.3, 316.41),
    vector4(-157.87, -1679.79, 33.83, 51.67),
    vector4(-114.29, -1659.73, 32.56, 230.5),
    vector4(-33.46, -1567.33, 33.02, 228.92),
    vector4(1179.77, -394.61, 68.0, 73.78),
    vector4(1114.32, -391.27, 68.95, 243.22),
    vector4(1028.76, -408.28, 66.34, 40.17),
    vector4(945.84, -519.02, 60.63, 121.84),
    vector4(964.3, -596.2, 59.9, 253.62),
    vector4(996.89, -729.58, 57.82, 128.54),
    vector4(1207.47, -620.29, 66.44, 268.16),
    vector4(1341.31, -597.31, 74.7, 48.81),
    vector4(1389.03, -569.57, 74.5, 293.76),
    vector4(1303.21, -527.36, 71.46, 340.6),
    vector4(213.08, -592.83, 43.87, 342.72),
    vector4(-2.32, -1496.26, 31.85, 319.93),
    vector4(-192.43, -652.64, 40.68, 71.02),
    vector4(-759.92, -709.14, 30.06, 94.47),
    vector4(-741.55, -982.29, 17.44, 203.21),
    vector4(-884.2, -1072.55, 2.53, 212.04),
    vector4(-978.07, -1108.35, 2.15, 214.74),
    vector4(-985.86, -1121.67, 4.55, 302.03),
    vector4(-991.71, -1103.4, 2.15, 31.96),
    vector4(-1113.9, -1193.92, 2.38, 215.16),
    vector4(-1207.17, -1264.31, 7.08, 150.31),
    vector4(-1150.83, -1519.37, 4.36, 308.62),
    vector4(-935.52, -1523.16, 5.24, 287.73),
    vector4(92.4, -1666.58, 29.29, 207.55),
}

-- activate loop
Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(1)
        local pos = GetEntityCoords(GetPlayerPed(-1))
        local dist = #(pos - vector3(Config.StartLocation.x, Config.StartLocation.y, Config.StartLocation.z))
        if dist < 15.0 then
            if dist < 10.0 then
                DrawMarker(2, Config.StartLocation.x, Config.StartLocation.y, Config.StartLocation.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 200, 200, 200, 222, false, false, false, true, false, false, false)
                if dist < 1.0 then
                    if isOnJob then
                        DrawText3D(Config.StartLocation.x, Config.StartLocation.y, Config.StartLocation.z, "~g~E~w~ - Sign off")
                        if IsControlJustReleased(0, Keys["E"]) then
                            isOnJob = false
                            RemoveJobBlip()
                            TriggerEvent("r3-fooddelivery:client:startAnimation")
                            Notify("You signed out.", "primary", 5000)
                        end
                    else
                        DrawText3D(Config.StartLocation.x, Config.StartLocation.y, Config.StartLocation.z, "~g~E~w~ - Start working")
                        if IsControlJustReleased(0, Keys["E"]) then
                            TriggerEvent("r3-fooddelivery:client:startAnimation")
                            if AreJobsOnline() then
                                WorkLoop()
                                Notify("You are now open to deliveries, wait until there is one ready for you.", "primary", 5000)
                            else
                                Notify("It seems like there are no companies available right now to give out orders.", "error", 5000)
                            end
                        end
                    end
                end 
            end
        else
            Citizen.Wait(1000)
        end
    end
end)

-- function with delivery searching loop
function WorkLoop()
    if isOnJob then return end
    isOnJob = true
    Citizen.CreateThread(function()
        while isOnJob do
            Citizen.Wait(1)
            Citizen.Wait(math.random(Config.Times["wait"].min, Config.Times["wait"].max) * 1000)
            if not isOnJob then return end
            local index = math.random(1, #Config.Companies)
            local company = Config.Companies[index]
            local delivery = DeliveryLocations[math.random(1, #DeliveryLocations)]
            while company.job.enable and not IsJobOnline(company.job.name) do
                Citizen.Wait(50)
                if not AreJobsOnline() then
                    isOnJob = false
                    RemoveJobBlip()
                    Notify("There are no companies available anymore to give out orders, you were signed out.", "error", 5000)
                    return
                end
                index = math.random(1, #Config.Companies)
                company = Config.Companies[index]
            end
            Notify("There's an order coming in, lets see if you get it..", "primary", 5000)
            Citizen.Wait(10 * 1000)
            if not isOnJob then return end
            if math.random(1, 100) <= Config.Chances["get"] then
                Notify("You got a delivery from "..company.label..". Go collect the order!", "success", 5000)
                CreateJobBlip(company.coords, company.label, "pickup")
                inPickup = true
                while inPickup do
                    Citizen.Wait(1)
                    if not isOnJob then return end
                    local pos = GetEntityCoords(GetPlayerPed(-1))
                    local dist = #(pos - vector3(company.coords.x, company.coords.y, company.coords.z))
                    if dist < 15.0 then
                        if dist < 10.0 then
                            DrawMarker(2, company.coords.x, company.coords.y, company.coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 200, 200, 200, 222, false, false, false, true, false, false, false)
                            if dist < 1.0 then
                                if not interacting then
                                    DrawText3D(company.coords.x, company.coords.y, company.coords.z, "~g~E~w~ - Pickup order")
                                    if IsControlJustReleased(0, Keys["E"]) then
                                        interacting = true
                                        Progressbar("fooddelivery-pickup-order", "Picking up order", 5000, false, true, {
                                            disableMovement = true,
                                            disableCarMovement = true,
                                            disableMouse = false,
                                            disableCombat = true,
                                        }, {
                                            animDict = "weapons@first_person@aim_rng@generic@projectile@thermal_charge@",
                                            anim = "plant_floor",
                                            flags = 17,
                                        }, {}, function() -- Done
                                            StopAnimTask(GetPlayerPed(-1), "weapons@first_person@aim_rng@generic@projectile@thermal_charge@", "plant_floor", 1.0)
                                            interacting = false
                                            TriggerServerEvent("r3-fooddelivery:server:getOrder", index)
                                        end, function() -- Cancel
                                            StopAnimTask(GetPlayerPed(-1), "weapons@first_person@aim_rng@generic@projectile@thermal_charge@", "plant_floor", 1.0)
                                            interacting = false
                                            Notify("Canceled..", "error")
                                        end)
                                    end
                                end
                            end
                        end
                    else
                        Citizen.Wait(1000)
                        if not isOnJob then return end
                    end
                end
                Notify("You picked up "..deliveryAmount.." bags to deliver, hurry to the customer!")
                CreateJobBlip(delivery, Config.Blips["delivery"].label, "delivery")
                inDelivery = true
                while inDelivery do
                    Citizen.Wait(1)
                    if not isOnJob then return end
                    local pos = GetEntityCoords(GetPlayerPed(-1))
                    local dist = #(pos - delivery.xyz)
                    if dist < 15.0 then
                        if dist < 10.0 then
                            DrawMarker(2, delivery.x, delivery.y, delivery.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 200, 200, 200, 222, false, false, false, true, false, false, false)
                            if dist < 1.0 then
                                if not interacting then
                                    DrawText3D(delivery.x, delivery.y, delivery.z, "~g~E~w~ - Deliver order")
                                    if IsControlJustReleased(0, Keys["E"]) then
                                        interacting = true
                                        TriggerEvent("r3-fooddelivery:client:deliverAnimation")
                                        Progressbar("fooddelivery-deliver-order", "Delivering order", 5000, false, true, {
                                            disableMovement = true,
                                            disableCarMovement = true,
                                            disableMouse = false,
                                            disableCombat = true,
                                        }, {
                                            animDict = "timetable@jimmy@doorknock@",
                                            anim = "knockdoor_idle",
                                            flags = 16,
                                        }, {}, function() -- Done
                                            interacting = false
                                            TriggerServerEvent("r3-fooddelivery:server:deliverOrder", index, deliveryAmount)
                                        end, function() -- Cancel
                                            interacting = false
                                            Notify("Canceled..", "error")
                                        end)
                                    end
                                end
                            end
                        end
                    else
                        Citizen.Wait(1000)
                        if not isOnJob then return end
                    end
                end
                RemoveJobBlip()
            else
                Notify("You did not get the job, better luck next time!", "error", 5000)
            end
        end
    end)
end

RegisterNetEvent("r3-fooddelivery:client:getJobCount")

function IsJobOnline(name)
    local online = nil
    local event = AddEventHandler("r3-fooddelivery:client:getJobCount", function(count)
        online = count > 0
    end)
    TriggerServerEvent("r3-fooddelivery:server:getJobCount", name)
    while online == nil do
        Citizen.Wait(50)
    end
    RemoveEventHandler(event)
    return online
end

function AreJobsOnline()
    for i, v in pairs(Config.Companies) do
        if v.job.enable then
            local online = nil
            local event = AddEventHandler("r3-fooddelivery:client:getJobCount", function(count)
                online = count > 0
            end)
            TriggerServerEvent("r3-fooddelivery:server:getJobCount", v.job.name)
            while online == nil do
                Citizen.Wait(50)
            end
            RemoveEventHandler(event)
            if online then
                return true
            end
        else
            return true
        end
    end
    return false
end

RegisterNetEvent("r3-fooddelivery:client:getOrder")
AddEventHandler("r3-fooddelivery:client:getOrder", function(amount)
	deliveryAmount = amount
    inPickup = false
end)

RegisterNetEvent("r3-fooddelivery:client:deliverOrder")
AddEventHandler("r3-fooddelivery:client:deliverOrder", function()
	deliveryAmount = nil
    inDelivery = false
end)

RegisterNetEvent("r3-fooddelivery:client:startAnimation")
AddEventHandler("r3-fooddelivery:client:startAnimation", function()
	ClearPedSecondaryTask(PlayerPedId())
	loadAnimDict( "anim@heists@keycard@" ) 
	TaskPlayAnim( PlayerPedId(), "anim@heists@keycard@", "exit", 8.0, 1.0, -1, 16, 0, 0, 0, 0 )
	Citizen.Wait(850)
	ClearPedTasks(PlayerPedId())
end)

RegisterNetEvent("r3-fooddelivery:client:deliverAnimation")
AddEventHandler("r3-fooddelivery:client:deliverAnimation", function()
	Citizen.Wait(2500)
    ClearPedSecondaryTask(PlayerPedId())
	RequestAnimDict("mp_safehouselost@")
	loadAnimDict( "mp_safehouselost@" ) 
	TaskPlayAnim( PlayerPedId(), 'mp_safehouselost@', 'package_dropoff', 8.0, 1.0, -1, 16, 0, 0, 0, 0 )
	while IsEntityPlayingAnim(PlayerPedId(), "mp_safehouselost@', 'package_dropoff", 3) do Citizen.Wait(0); end
end)

function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 0 )
    end
end
      
Citizen.CreateThread(function()
    Config.Blips["start"].blip = AddBlipForCoord(Config.StartLocation.x, Config.StartLocation.y, Config.StartLocation.z)
    SetBlipSprite(Config.Blips["start"].blip, Config.Blips["start"].sprite)
    SetBlipDisplay(Config.Blips["start"].blip, 4)
    SetBlipScale(Config.Blips["start"].blip, Config.Blips["start"].scale)
    SetBlipColour(Config.Blips["start"].blip, Config.Blips["start"].colour)
    SetBlipAsShortRange(Config.Blips["start"].blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(Config.Blips["start"].label)
    EndTextCommandSetBlipName(Config.Blips["start"].blip)
end)

function CreateJobBlip(coords, label, type)
    RemoveJobBlip()
    JobBlip = AddBlipForCoord(coords.x, coords.y, coords.z)
    SetBlipSprite(JobBlip, Config.Blips[type].sprite)
    SetBlipDisplay(JobBlip, 4)
    SetBlipScale(JobBlip, Config.Blips[type].scale)
    SetBlipColour(JobBlip, Config.Blips[type].colour)
    SetBlipAsShortRange(JobBlip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(label)
    EndTextCommandSetBlipName(JobBlip)
    SetBlipRoute(JobBlip, true)
    SetBlipRouteColour(JobBlip, Config.Blips[type].colour)
end

function RemoveJobBlip()
    if JobBlip ~= nil then
        RemoveBlip(JobBlip)
        JobBlip = nil
    end
end

function DrawText3D(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end