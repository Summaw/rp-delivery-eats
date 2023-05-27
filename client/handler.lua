-- start of framework integration
QBCore = nil

if Config.OldQBCore then
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(10)
            if QBCore == nil then
                TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
                Citizen.Wait(200)
            end
        end
    end)
else
    QBCore = exports['qb-core']:GetCoreObject()
end

-- notification
function Notify(v, type, duration)
	QBCore.Functions.Notify(v, type, duration)
end

-- progressbar
function Progressbar(name, label, duration, useWhileDead, canCancel, disableControls, animation, prop, onFinish, onCancel)
    exports['progressbar']:Progress({
        name = name:lower(),
        duration = duration,
        label = label,
        useWhileDead = useWhileDead,
        canCancel = canCancel,
        controlDisables = disableControls,
        animation = animation,
        prop = prop,
        propTwo = nil,
    }, function(cancelled)
        if not cancelled then
            if onFinish ~= nil then
                onFinish()
            end
        else
            if onCancel ~= nil then
                onCancel()
            end
        end
    end)
end

-- end of framework integration