-- start of framework integration
QBCore = nil

if Config.OldQBCore then
    TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
else
    QBCore = exports['qb-core']:GetCoreObject()
end

-- add items
function AddItem(target, v, amount)
	local src = target
	local Player = QBCore.Functions.GetPlayer(src)
	if Player.Functions.AddItem(v, amount) then
		TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[v], "add")
		return true
	end
	return false
end

-- remove items
function RemoveItem(target, v, amount)
	local src = target
	local Player = QBCore.Functions.GetPlayer(src)
	if Player.Functions.RemoveItem(v, amount) then
		TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[v], "remove")
		return true
	end
	return false
end

-- get item count
function GetItemCount(target, v)
	local src = target
	local Player = QBCore.Functions.GetPlayer(src)
	local item = Player.Functions.GetItemByName(v)
	return (item ~= nil and item.amount) or 0
end

-- add money
function AddMoney(target, v, amount)
	local src = target
	local Player = QBCore.Functions.GetPlayer(src)
	Player.Functions.AddMoney(v, amount, "fooddelivery-add")
end

-- add society money
function AddSocietyMoney(target, amount, type)
	TriggerEvent("qb-bossmenu:server:addAccountMoney", target, amount)
end

-- get online job count
function GetOnlineJobCount(name)
	local Players = QBCore.Functions.GetPlayers()
	local count = 0
	for i=1, #Players, 1 do
 		local Player = QBCore.Functions.GetPlayer(Players[i])
 		if Player.PlayerData.job.name == name then
			count = count + 1
		end
	end
	return count
end

-- notification
function Notify(target, v, type, duration)
	local src = target
	TriggerClientEvent('QBCore:Notify', src, v, type, duration)
end

-- end of framework integration