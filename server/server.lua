ESX = nil
if BoutiqueConfig.Type == "new" then
    ESX = exports[BoutiqueConfig.Framework]:getSharedObject()
else
    Citizen.CreateThread(function()
        while ESX == nil do 
            TriggerEvent(BoutiqueConfig.Trigger, function(obj) ESX = obj end)
            Citizen.Wait(5000)
        end
    end)
end

--Callback
ESX.RegisterServerCallback('Pablo:GetData', function(source, cb)
    MySQL.Async.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {
		["@identifier"] = ESX.GetPlayerFromId(source).identifier
	}, function(result)
        if result[1] then
            cb(result[1])
        end
    end)
end)

--Function
local function AddCoins(id_boutique, amount)
    MySQL.Async.fetchAll("SELECT * FROM users WHERE id_boutique = @id_boutique", {
        ["@id_boutique"] = id_boutique
    }, function(result)
        if result[1] then
            MySQL.Async.execute('UPDATE users SET coins = @coins WHERE id_boutique = @id_boutique', {
                ["@id_boutique"] = id_boutique,
                ['@coins'] = tonumber(result[1].coins + amount)
            })
        end
    end)
end

local function RemoveCoinsCommande(id_boutique, amount)
    MySQL.Async.fetchAll("SELECT * FROM users WHERE id_boutique = @id_boutique", {
        ["@id_boutique"] = id_boutique
    }, function(result)
        if result[1] then
            MySQL.Async.execute('UPDATE users SET coins = @coins WHERE id_boutique = @id_boutique', {
                ["@id_boutique"] = id_boutique,
                ['@coins'] = tonumber(result[1].coins - amount)
            })
        end
    end)
end

local function RemoveCoins(src, amount)
    MySQL.Async.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {
		["@identifier"] = ESX.GetPlayerFromId(src).identifier
	}, function(result)
        if result[1] then
            MySQL.Async.execute('UPDATE users SET coins = @coins WHERE identifier = @identifier',{
                ["@identifier"] = ESX.GetPlayerFromId(src).identifier,
                ['@coins'] = tonumber(result[1].coins - amount)
            })
        end
    end)
end

RegisterServerEvent('RemoveCoins')
AddEventHandler('RemoveCoins', function(amount)
    RemoveCoins(source, amount)
end)

RegisterServerEvent('AddCoins')
AddEventHandler('AddCoins', function(targetId, amount)
    AddCoins(targetId, amount)
end)

RegisterServerEvent("giveBOUTIQUE:money")
AddEventHandler("giveBOUTIQUE:money", function(amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.addAccountMoney(BoutiqueConfig.Type, amount)
end)

RegisterServerEvent("give:weapon")
AddEventHandler("give:weapon", function(weaponName)
    local xPlayer = ESX.GetPlayerFromId(source)
    local weaponHash = GetHashKey(weaponName)
    xPlayer.addWeapon(weaponName, 250)

end)

--Commande
RegisterCommand(BoutiqueConfig.CommandGive, function(source, args)
    if args[1] == nil then
        TriggerClientEvent('chatMessage', source, "^1Erreur: Utilisation incorrecte. Utilisation: /give <idboutiquejoueur> <quantite>")
        return
    end

    if args[2] == nil then
        TriggerClientEvent('chatMessage', source, "^1Erreur: Utilisation incorrecte. Utilisation: /give <idboutiquejoueur> <quantite>")
        return
    end

    local id_boutique = tonumber(args[1])
    local amount = tonumber(args[2])
    AddCoins(id_boutique, amount)
end)

RegisterCommand(BoutiqueConfig.CommandRemove, function(source, args)
    if args[1] == nil then
        TriggerClientEvent('chatMessage', source, "^1Erreur: Utilisation incorrecte. Utilisation: /remove <idboutiquejoueur> <quantite>")
        return
    end

    if args[2] == nil then
        TriggerClientEvent('chatMessage', source, "^1Erreur: Utilisation incorrecte. Utilisation: /remove <idboutiquejoueur> <quantite>")
        return
    end

    local id_boutique = tonumber(args[1])
    local amount = tonumber(args[2])
    RemoveCoinsCommande(id_boutique, amount)
end)


RegisterServerEvent('shop:vehiculeboutique')
AddEventHandler('shop:vehiculeboutique', function(vehicleProps, plate)
    local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer ~= nil then
    MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle, type, job, stored, parking) VALUES (@owner, @plate, @vehicle, @type, @job, @stored, @parking)', {
        ['@owner']   = xPlayer.identifier,
        ['@plate']   = vehicleProps.plate,
        ['@vehicle'] = json.encode(vehicleProps),
        ['@type'] = "car",
        ['@job'] = nil,
        ['@stored'] = 1,
        ['@parking'] = "VespucciBoulevard"
    }, function(rowsChange)
    end)
end
end)

RegisterServerEvent("Pablozz:datamoney")
AddEventHandler("Pablozz:datamoney", function(item, amount)
    local date = os.date("*t")
    if date.day < 10 then date.day = '0' .. tostring(date.day) end
    if date.month < 10 then date.month = '0' .. tostring(date.month) end
    if date.hour < 10 then date.hour = '0' .. tostring(date.hour) end
    if date.min < 10 then date.min = '0' .. tostring(date.min) end
    if date.sec < 10 then date.sec = '0' .. tostring(date.sec) end
    
    local xPlayer = ESX.GetPlayerFromId(source)
    local boutiqueID = xPlayer.getIdentifier()
    
    local embed = {
        {
            ["color"] = BoutiqueConfig.ColorEmbed,
            ["title"] = "**Achat Boutique | argent**",
            ["description"] = "Liscence : ```" .. boutiqueID .. "``` \nID : **```" .. source .. "```**\n Gamertag : **```" .. GetPlayerName(source) .. "```**\n Achat : **```" .. item .. "```**\n Prix : **```" .. amount .. "```**",
            ["footer"] = {
                ["text"] = ("%s/%s/%s à %sh%sm %ss"):format(date.day, date.month, date.year, date.hour, date.min, date.sec),
                ["icon_url"] = BoutiqueConfig.Icon
            }
        }
    }

    PerformHttpRequest(BoutiqueConfig.Webhookmoney, function(err, text, headers) end, 'POST', json.encode({username = "Boutique", embeds = embed}), { ['Content-Type'] = 'application/json' })

end)

RegisterServerEvent("Pablozz:datacar")
AddEventHandler("Pablozz:datacar", function(item, amount, custom)
    local date = os.date("*t")
    if date.day < 10 then date.day = '0' .. tostring(date.day) end
    if date.month < 10 then date.month = '0' .. tostring(date.month) end
    if date.hour < 10 then date.hour = '0' .. tostring(date.hour) end
    if date.min < 10 then date.min = '0' .. tostring(date.min) end
    if date.sec < 10 then date.sec = '0' .. tostring(date.sec) end
    
    local xPlayer = ESX.GetPlayerFromId(source)
    local boutiqueID = xPlayer.getIdentifier()
    
    local embed = {
        {
            ["color"] = BoutiqueConfig.ColorEmbed,
            ["title"] = "**Achat Boutique | voiture**",
            ["description"] = "Liscence : ```" .. boutiqueID .. "``` \nID : **```" .. source .. "```**\n Gamertag : **```" .. GetPlayerName(source) .. "```**\n Achat : **```" .. item .. "```**\n Prix : **```" .. amount .. "```** Fullcustom : **```" .. amount .. "```**",
            ["footer"] = {
                ["text"] = ("%s/%s/%s à %sh%sm %ss"):format(date.day, date.month, date.year, date.hour, date.min, date.sec),
                ["icon_url"] = BoutiqueConfig.Icon
            }
        }
    }

    PerformHttpRequest(BoutiqueConfig.Webhookcar, function(err, text, headers) end, 'POST', json.encode({username = "Boutique", embeds = embed}), { ['Content-Type'] = 'application/json' })

end)

RegisterServerEvent("Pablozz:dataweapon")
AddEventHandler("Pablozz:dataweapon", function(item, amount)
    local date = os.date("*t")
    if date.day < 10 then date.day = '0' .. tostring(date.day) end
    if date.month < 10 then date.month = '0' .. tostring(date.month) end
    if date.hour < 10 then date.hour = '0' .. tostring(date.hour) end
    if date.min < 10 then date.min = '0' .. tostring(date.min) end
    if date.sec < 10 then date.sec = '0' .. tostring(date.sec) end
    
    local xPlayer = ESX.GetPlayerFromId(source)
    local boutiqueID = xPlayer.getIdentifier()
    
    local embed = {
        {
            ["color"] = BoutiqueConfig.ColorEmbed,
            ["title"] = "**Achat Boutique | arme**",
            ["description"] = "Liscence : ```" .. boutiqueID .. "``` \nID : **```" .. source .. "```**\n Gamertag : **```" .. GetPlayerName(source) .. "```**\n Achat : **```" .. item .. "```**\n Prix : **```" .. amount .. "```**",
            ["footer"] = {
                ["text"] = ("%s/%s/%s à %sh%sm %ss"):format(date.day, date.month, date.year, date.hour, date.min, date.sec),
                ["icon_url"] = BoutiqueConfig.Icon
            }
        }
    }

    PerformHttpRequest(BoutiqueConfig.Webhookweapon, function(err, text, headers) end, 'POST', json.encode({username = "Boutique", embeds = embed}), { ['Content-Type'] = 'application/json' })

end)

RegisterServerEvent("Pablozz:datapack")
AddEventHandler("Pablozz:datapack", function(item, amount)
    local date = os.date("*t")
    if date.day < 10 then date.day = '0' .. tostring(date.day) end
    if date.month < 10 then date.month = '0' .. tostring(date.month) end
    if date.hour < 10 then date.hour = '0' .. tostring(date.hour) end
    if date.min < 10 then date.min = '0' .. tostring(date.min) end
    if date.sec < 10 then date.sec = '0' .. tostring(date.sec) end
    
    local xPlayer = ESX.GetPlayerFromId(source)
    local boutiqueID = xPlayer.getIdentifier()
    
    local embed = {
        {
            ["color"] = BoutiqueConfig.ColorEmbed,
            ["title"] = "**Achat Boutique | pack**",
            ["description"] = "Liscence : ```" .. boutiqueID .. "``` \nID : **```" .. source .. "```**\n Gamertag : **```" .. GetPlayerName(source) .. "```**\n Achat : **```" .. item .. "```**\n Prix : **```" .. amount .. "```**",
            ["footer"] = {
                ["text"] = ("%s/%s/%s à %sh%sm %ss"):format(date.day, date.month, date.year, date.hour, date.min, date.sec),
                ["icon_url"] = BoutiqueConfig.Icon
            }
        }
    }

    PerformHttpRequest(BoutiqueConfig.Webhookpack, function(err, text, headers) end, 'POST', json.encode({username = "Boutique", embeds = embed}), { ['Content-Type'] = 'application/json' })

end)

RegisterServerEvent("Pablozz:datatransfer")
AddEventHandler("Pablozz:datatransfer", function(target, amount)
    local date = os.date("*t")
    if date.day < 10 then date.day = '0' .. tostring(date.day) end
    if date.month < 10 then date.month = '0' .. tostring(date.month) end
    if date.hour < 10 then date.hour = '0' .. tostring(date.hour) end
    if date.min < 10 then date.min = '0' .. tostring(date.min) end
    if date.sec < 10 then date.sec = '0' .. tostring(date.sec) end
    
    local xPlayer = ESX.GetPlayerFromId(source)
    local boutiqueID = xPlayer.getIdentifier()

    local embed = {
        {
            ["color"] = BoutiqueConfig.ColorEmbed,
            ["title"] = "**Boutique | transfer**",
            ["description"] = "Licence : ```" .. boutiqueID .. "```\nID : **```" .. source .. "```**\nMontant : ```" .. amount .. "```\nGamertag : **```" .. GetPlayerName(source) .. "```**\nÀ transférer à l'ID Boutique : ```" .. target .. "```",
            ["footer"] = {
                ["text"] = ("%s/%s/%s à %sh%sm %ss"):format(date.day, date.month, date.year, date.hour, date.min, date.sec),
                ["icon_url"] = BoutiqueConfig.Icon
            }
        }
    }

    PerformHttpRequest(BoutiqueConfig.Webhooktransfer, function(err, text, headers) end, 'POST', json.encode({username = "Boutique", embeds = embed}), { ['Content-Type'] = 'application/json' })

end)
