RegisterServerEvent("r3-fooddelivery:server:getOrder")
AddEventHandler("r3-fooddelivery:server:getOrder", function(index)
    local src = source
    local deliveryAmount = 1
    if math.random(1, 100) >= Config.Chances["amount"] then
        deliveryAmount = 2
        if math.random(1, 100) >= Config.Chances["amount"] then
            deliveryAmount = 3
        end
    end
    if AddItem(src, Config.Companies[index].item, deliveryAmount) then
        TriggerClientEvent("r3-fooddelivery:client:getOrder", src, deliveryAmount)
    else
        Notify(src, "You could not carry "..deliveryAmount.." bags!", "error", 5000)
    end
end)

RegisterServerEvent("r3-fooddelivery:server:deliverOrder")
AddEventHandler("r3-fooddelivery:server:deliverOrder", function(index, deliveryAmount)
    local src = source
    if GetItemCount(src, Config.Companies[index].item) >= deliveryAmount then
        RemoveItem(src, Config.Companies[index].item, deliveryAmount)
        local reward = math.random(Config.Reward.min, Config.Reward.max) * deliveryAmount
        TriggerClientEvent("r3-fooddelivery:client:deliverOrder", src)
        if Config.Companies[index].society.enable then
            local societyreward = math.floor((reward / 100) * Config.Companies[index].society.percent)
            local playerreward = reward - societyreward
            AddMoney(src, "cash", playerreward)
            AddSocietyMoney(Config.Companies[index].society.account, societyreward, Config.Companies[index].society.type)
            Notify(src, "You successfully delivered the order and recieved $"..playerreward.."! ($"..societyreward.." went to the company)", "success", 5000)            
        else
            AddMoney(src, "cash", reward)
            Notify(src, "You successfully delivered the order and recieved $"..reward.."!", "success", 5000)
        end
    else
        Notify(src, "You are not carrying the full order with you..", "error", 5000)
    end
end)

RegisterServerEvent("r3-fooddelivery:server:getJobCount")
AddEventHandler("r3-fooddelivery:server:getJobCount", function(name)
    TriggerClientEvent("r3-fooddelivery:client:getJobCount", source, GetOnlineJobCount(name))
end)