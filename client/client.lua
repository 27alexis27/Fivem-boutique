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

Fullcustomcheck = false
GarageOption = false
voituregive = {}

local menuState = false
local main_menu = RageUI.CreateMenu("Boutique", "Intéraction :")
local menu_caisse = RageUI.CreateSubMenu(main_menu, BoutiqueConfig.NameCaisse, "Intéraction :")
local menu_pack = RageUI.CreateSubMenu(main_menu, BoutiqueConfig.NamePack, "Intéraction :")
local menu_arme = RageUI.CreateSubMenu(main_menu, BoutiqueConfig.NameWeapon, "Intéraction :")
local menu_car = RageUI.CreateSubMenu(main_menu, BoutiqueConfig.NameCar, "Intéraction :")
local menu_tool = RageUI.CreateSubMenu(main_menu, BoutiqueConfig.NameTool, "Intéraction :")
local menu_setting = RageUI.CreateSubMenu(main_menu, BoutiqueConfig.NameSetting, "Intéraction :")
local menu_money = RageUI.CreateSubMenu(main_menu, BoutiqueConfig.NameMoney, "Intéraction :")
local sous_menu_car = RageUI.CreateSubMenu(menu_car, "Achat", "Achat :")

local disabledKeys = {}
local disabledKeysDuration = 20000 

function DisableKey(key)
    disabledKeys[key] = true
    Citizen.SetTimeout(disabledKeysDuration, function()
        disabledKeys[key] = nil
    end)
end

function IsKeyDisabled(key)
    return disabledKeys[key] == true
end

function give_vehi(veh)
    local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
    Citizen.Wait(10)
    if GarageOption == false then
    ESX.Game.SpawnVehicle(veh, {x = plyCoords.x+2 ,y = plyCoords.y, z = plyCoords.z+2}, 313.4216, function (vehicle)
        if Fullcustomcheck == true then
            FullVehicleBoost(vehicle)
        end
        local plate = GeneratePlate()
        table.insert(voituregive, vehicle)		
        local vehicleProps = ESX.Game.GetVehicleProperties(voituregive[#voituregive])
        vehicleProps.plate = plate
        SetVehicleNumberPlateText(voituregive[#voituregive] , plate)
        TriggerServerEvent('shop:vehiculeboutique', vehicleProps, plate)
        TriggerEvent('esx:showAdvancedNotification', 'Boutique', '', 'Vous avez reçu votre :\n '..veh, Config.img_notif, 3)
    end)
    else
        ESX.Game.SpawnVehicle(veh, {x = plyCoords.x+2 ,y = plyCoords.y, z = plyCoords.z+2}, 313.4216, function (vehicle)
            if Fullcustomcheck == true then
                FullVehicleBoost(vehicle)
            end
            local plate = GeneratePlate()
            table.insert(voituregive, vehicle)		
            local vehicleProps = ESX.Game.GetVehicleProperties(voituregive[#voituregive])
            vehicleProps.plate = plate
            SetVehicleNumberPlateText(voituregive[#voituregive] , plate)
            TriggerServerEvent('shop:vehiculeboutique', vehicleProps, plate)
            TriggerEvent('esx:showAdvancedNotification', 'Boutique', '', 'Vous avez reçu votre : '..veh.." directement dans votre garage", Config.img_notif, 3)
            ESX.Game.DeleteVehicle(vehicle)
            TriggerServerEvent('rGarage:changestateveh', vehicleProps.plate, true)
        end)
    end
end

function FullVehicleBoost(vehicle)
    SetVehicleModKit(vehicle, 0)
    SetVehicleMod(vehicle, 14, 0, true)
    SetVehicleNumberPlateTextIndex(vehicle, 5)
    ToggleVehicleMod(vehicle, 18, true)
    SetVehicleColours(vehicle, 0, 0)
    SetVehicleModColor_2(vehicle, 5, 0)
    SetVehicleExtraColours(vehicle, 111, 111)
    SetVehicleWindowTint(vehicle, 2)
    ToggleVehicleMod(vehicle, 22, true)
    SetVehicleMod(vehicle, 23, 11, false)
    SetVehicleMod(vehicle, 24, 11, false)
    SetVehicleWheelType(vehicle, 120)
    SetVehicleWindowTint(vehicle, 3)
    ToggleVehicleMod(vehicle, 20, true)
    SetVehicleTyreSmokeColor(vehicle, 0, 0, 0)
    LowerConvertibleRoof(vehicle, true)
    SetVehicleIsStolen(vehicle, false)
    SetVehicleIsWanted(vehicle, false)
    SetVehicleHasBeenOwnedByPlayer(vehicle, true)
    SetVehicleNeedsToBeHotwired(vehicle, false)
    SetCanResprayVehicle(vehicle, true)
    SetPlayersLastVehicle(vehicle)
    SetVehicleFixed(vehicle)
    SetVehicleDeformationFixed(vehicle)
    SetVehicleTyresCanBurst(vehicle, false)
    SetVehicleWheelsCanBreak(vehicle, false)
    SetVehicleCanBeTargetted(vehicle, false)
    SetVehicleExplodesOnHighExplosionDamage(vehicle, false)
    SetVehicleHasStrongAxles(vehicle, true)
    SetVehicleDirtLevel(vehicle, 0)
    SetVehicleCanBeVisiblyDamaged(vehicle, false)
    IsVehicleDriveable(vehicle, true)
    SetVehicleEngineOn(vehicle, true, true)
    SetVehicleStrong(vehicle, true)
    RollDownWindow(vehicle, 0)
    RollDownWindow(vehicle, 1)
    
    SetPedCanBeDraggedOut(PlayerPedId(), false)
    SetPedStayInVehicleWhenJacked(PlayerPedId(), true)
    SetPedRagdollOnCollision(PlayerPedId(), false)
    ResetPedVisibleDamage(PlayerPedId())
    ClearPedDecorations(PlayerPedId())
    SetIgnoreLowPriorityShockingEvents(PlayerPedId(), true)
end

local function Keyboard(TextEntry, ExampleText, MaxStringLenght)
    AddTextEntry('FMMC_KEY_TIP1', TextEntry)
    blockinput = true
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght)
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do 
        Wait(0)
    end 
        
    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult()
        Wait(500)
        blockinput = false
        return result
    else
        Wait(500)
        blockinput = false
        return nil
    end
end

main_menu.Closed = function()
    menuState = false
end

function CloseMenuBOUTIQUE()
    RageUI.CloseAll()
    menuState = false
end

function spawnuniCar(car)
    local car = GetHashKey(car)
    RequestModel(car)
    while not HasModelLoaded(car) do
        RequestModel(car)
        Citizen.Wait(0)
    end
    local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), false))
    local vehicle = CreateVehicle(car, -899.62, -3298.74, 13.94, 58.0, true, false)
    SetEntityAsMissionEntity(vehicle, true, true) 
    SetPedIntoVehicle(GetPlayerPed(-1),vehicle,-1)
	SetVehicleDoorsLocked(vehicle, 4)
	RageUI.Text({ message = "Vous avez 20 secondes pour tester le véhicule.", time_display = 3000 })
	local timer = 20
	local breakable = false
	breakable = false
	while not breakable do
		Wait(1000)
		timer = timer - 1
		if timer == 10 then
			RageUI.Text({ message = "Il vous reste plus que 10 secondes.", time_display = 3000 })
		end
		if timer == 5 then
			RageUI.Text({ message = "Il vous reste plus que 5 secondes.", time_display = 3000 })
		end
		if timer <= 0 then
			local veh,dist4 = ESX.Game.GetClosestVehicle(playerCoords)
			DeleteEntity(vehicle)
			RageUI.Text({ message = "~r~Vous avez terminé la période d'essai.", time_display = 3000 })
			SetEntityCoords(PlayerPedId(), posessaie)
			breakable = true
			break
		end
	end
end

BoutiqueID = 0
function OpenMenuBoutique()
    local CountCoins = 0
    if menuState then 
        return 
    end

    ESX.TriggerServerCallback('Pablo:GetData', function(data)
        if data ~= nil then
            BoutiqueID = data.id_boutique
            CountCoins = data.coins
        else
            ESX.ShowNotification("Erreur lors de la récupération des données de la boutique.")
            return
        end
    end)

    Wait(100)
    menuState = true
    CreateThread(function()
        RageUI.Visible(main_menu, true)

        while menuState do
            RageUI.IsVisible(main_menu, function()
                RageUI.Info("Boutique", {"", BoutiqueConfig.Theme.."Code Boutique : ", BoutiqueConfig.Theme.."Coin(s) : "}, {"", BoutiqueID, CountCoins})
                RageUI.Separator("Vos coin(s) : "..BoutiqueConfig.Theme..""..CountCoins)
                if BoutiqueConfig.Argent == true then 
                    RageUI.Button("Boutique - Argent", "achetez de l'"..BoutiqueConfig.Theme.."Argent", {RightLabel = BoutiqueConfig.Theme.."→→→"}, true, {}, menu_money)
                else 
                    print("")
                end
                RageUI.Button("Boutique - Armes", "achetez des"..BoutiqueConfig.Theme.." Arme(s)", {RightLabel = BoutiqueConfig.Theme.."→→→"}, true, {}, menu_arme)
                RageUI.Button("Boutique - Voitures", "achetez des"..BoutiqueConfig.Theme.." Voiture(s)", {RightLabel = BoutiqueConfig.Theme.."→→→"}, true, {}, menu_car)
                -- RageUI.Button("Boutique - Caisse", "achetez des"..BoutiqueConfig.Theme.." Caisse(s)", {RightLabel = BoutiqueConfig.Theme.."→→→"}, true, {}, menu_caisse)
                if BoutiqueConfig.Pack == true then 
                    RageUI.Button("Boutique - Pack", "achetez des"..BoutiqueConfig.Theme.." Pack(s)", {RightLabel = BoutiqueConfig.Theme.."→→→"}, true, {}, menu_pack)
                else 
                    print("")
                end
                RageUI.Line(BoutiqueConfig.LineR, BoutiqueConfig.LineG, BoutiqueConfig.LineB)
                if BoutiqueConfig.Coin == true then 
                    RageUI.Button(BoutiqueConfig.Theme.."~s~Acheter des coins", "Vous permet d'acheter des "..BoutiqueConfig.Theme.."coin(s)~s~ à un ", {RightLabel = BoutiqueConfig.Theme.."→→→"}, true, {
                        onSelected = function()
                            SendNUIMessage({LinkShop = BoutiqueConfig.Lien})
                            Wait(10)
                        end
                    })
                else 
                    print("")
                end
                if BoutiqueConfig.Vip == true then 
                    RageUI.Button("Acheter le vip", "achetez le"..BoutiqueConfig.Theme.." V.I.P", {RightLabel = BoutiqueConfig.Theme.."→→→"}, false, {
                        onSelected = function()
                            buyvip = Keyboard("Êtes vous sur ~g~oui~s~/~r~non", "", 3)
                            Wait(10)
                            if buyvip == "oui" then 
                                ESX.ShowNotification("Vous avez Achetez le ~y~V.I.P")
                            else
                                print("achat annulé")
                            end

                        end
                    })
                else
                    print("")
                end
                RageUI.Button("Option", nil, {RightLabel = BoutiqueConfig.Theme.."→→→"}, true, {}, menu_setting)
            end)

            RageUI.IsVisible(menu_money, function()
                RageUI.Info("Boutique", {"", BoutiqueConfig.Theme.."Code Boutique : ", BoutiqueConfig.Theme.."Coin(s) : "}, {"", BoutiqueID, CountCoins})

                RageUI.Line(BoutiqueConfig.LineR, BoutiqueConfig.LineG, BoutiqueConfig.LineB)

                for _, cash in pairs(BoutiqueConfig.cash) do
                    RageUI.Button(cash.label, nil, {RightLabel = BoutiqueConfig.Theme..BoutiqueConfig.Namecoin.." "..cash.price}, true, {
                        onSelected = function()
                            buycash = Keyboard("Êtes vous sur ~g~oui~s~/~r~non", "", 3)
                            Wait(10)
                            if buycash == "oui" then 
                                if tonumber(CountCoins) >= cash.price then 
                                    print("assez de coins")
                                    if 0 == true then
                                        reducode = Keyboard("Entrer le code de réduction", "", 25)
                                        if reducode == BoutiqueConfig.CodeReduc then 
                                            ESX.ShowNotification("Argent achetée avec la réduction --> ~r~"..cash.label)
                                            print("Reduction activé :"..BoutiqueConfig.CodeReduc.." "..BoutiqueConfig.Reduc.."%")
                                            TriggerServerEvent("RemoveCoins", cash.price)
                                            TriggerServerEvent('giveBOUTIQUE:money', cash.amount)
                                        else
                                            ESX.ShowNotification("Argent achetée --> ~r~"..cash.label)
                                            TriggerServerEvent("RemoveCoins", cash.price)
                                            TriggerServerEvent("Pablozz:datamoney", id)
                                            TriggerServerEvent('giveBOUTIQUE:money', cash.amount)
                                        end
                                    else
                                        ESX.ShowNotification("Argent achetée --> ~r~"..cash.label)
                                        TriggerServerEvent("RemoveCoins", cash.price)
                                        TriggerServerEvent("Pablozz:datamoney",cash.label , cash.price)
                                        TriggerServerEvent('giveBOUTIQUE:money', cash.amount)
                                    end

                                    CloseMenuBOUTIQUE()
                                else
                                    ESX.ShowNotification("~r~Pas assez d'argent pour achetez "..cash.label)
                                end
                            else
                                print("achat annulé")
                            end
                        end
                    }, menu_money)
                end

                RageUI.Line(BoutiqueConfig.LineR, BoutiqueConfig.LineG, BoutiqueConfig.LineB)

            end)

            RageUI.IsVisible(menu_caisse, function()
                RageUI.Info("Boutique", {"", BoutiqueConfig.Theme.."Code Boutique : ", BoutiqueConfig.Theme.."Coin(s) : "}, {"", BoutiqueID, CountCoins})

                RageUI.Line(BoutiqueConfig.LineR, BoutiqueConfig.LineG, BoutiqueConfig.LineB)

                -- for _, caisse in pairs(BoutiqueConfig.caisse) do
                --     RageUI.Button(caisse.label, caisse.desc, {RightLabel = BoutiqueConfig.Theme..BoutiqueConfig.Namecoin.." "..caisse.price}, true, {
                --         onSelected = function()
                --             buycaisse = Keyboard("Êtes vous sur ~g~oui~s~/~r~non", "", 3)
                --             Wait(10)
                --             if buycaisse == "oui" then 
                --                 if tonumber(CountCoins) >= caisse.price then 
                --                     ESX.ShowNotification("Caisse achetée --> ~r~"..caisse.label)
                --                     TriggerServerEvent("RemoveCoins", caisse.price)
                --                     CloseMenuBOUTIQUE()
                --                 else
                --                     ESX.ShowNotification("~r~Pas assez d'argent pour achetez "..caisse.label)
                --                 end
                --             else
                --                 print("achat annulé")
                --             end
                --         end
                --     }, menu_caisse)
                -- end

                RageUI.Line(BoutiqueConfig.LineR, BoutiqueConfig.LineG, BoutiqueConfig.LineB)

            end)

            RageUI.IsVisible(menu_pack, function()
                RageUI.Info("Boutique", {"", BoutiqueConfig.Theme.."Code Boutique : ", BoutiqueConfig.Theme.."Coin(s) : "}, {"", BoutiqueID, CountCoins})

                RageUI.Line(BoutiqueConfig.LineR, BoutiqueConfig.LineG, BoutiqueConfig.LineB)

                for _, pack in pairs(BoutiqueConfig.pack) do
                    RageUI.Button(pack.label, pack.desc, {RightLabel = BoutiqueConfig.Theme..BoutiqueConfig.Namecoin.." "..pack.price}, true, {
                        onSelected = function()
                            buypack = Keyboard("Êtes vous sur ~g~oui~s~/~r~non", "", 3)
                            Wait(10)
                            if buypack == "oui" then 
                                if tonumber(CountCoins) >= pack.price then 
                                    ESX.ShowNotification("Pack achetée --> ~r~"..pack.label)
                                    TriggerServerEvent("RemoveCoins", pack.price)
                                    TriggerServerEvent("Pablozz:datapack",pack.label , pack.price)
                                    CloseMenuBOUTIQUE()
                                else
                                    ESX.ShowNotification("~r~Pas assez d'argent pour achetez "..pack.label)
                                end
                            else
                                print("achat annulé")
                            end
                        end
                    }, menu_pack)
                end

                RageUI.Line(BoutiqueConfig.LineR, BoutiqueConfig.LineG, BoutiqueConfig.LineB)

            end)

            RageUI.IsVisible(menu_arme, function()
                RageUI.Info("Boutique", {"", BoutiqueConfig.Theme.."Code Boutique : ", BoutiqueConfig.Theme.."Coin(s) : "}, {"", BoutiqueID, CountCoins})
                RageUI.Line(BoutiqueConfig.LineR, BoutiqueConfig.LineG, BoutiqueConfig.LineB)
                for _, weapons in pairs(BoutiqueConfig.weapons) do
                    RageUI.Button(weapons.label, nil, {RightLabel = BoutiqueConfig.Theme..BoutiqueConfig.Namecoin.." "..weapons.price}, true, {
                        onSelected = function()
                            buyweapon = Keyboard("Êtes vous sur ~g~oui~s~/~r~non", "", 3)
                            Wait(10)
                            if buyweapon == "oui" then 
                                if tonumber(CountCoins) >= weapons.price then 
                                    ESX.ShowNotification("Arme achetée --> ~r~"..weapons.label)
                                    TriggerServerEvent("RemoveCoins", weapons.price)
                                    TriggerServerEvent('give:weapon', weapons.model)
                                    TriggerServerEvent("Pablozz:dataweapon",weapons.label , weapons.price)
                                    CloseMenuBOUTIQUE()
                                else
                                    ESX.ShowNotification("~r~Pas assez d'argent pour achetez "..weapons.label)
                                end
                            else
                                print("achat annulé")
                            end
                        end
                    }, menu_arme)
                end
                RageUI.Line(BoutiqueConfig.LineR, BoutiqueConfig.LineG, BoutiqueConfig.LineB)
            end)            

            RageUI.IsVisible(menu_tool, function()
                RageUI.Info("Boutique", {"", BoutiqueConfig.Theme.."Code Boutique : ", BoutiqueConfig.Theme..BoutiqueConfig.Theme.."Coin(s) : "}, {"", BoutiqueID, CountCoins})

                RageUI.Line(BoutiqueConfig.LineR, BoutiqueConfig.LineG, BoutiqueConfig.LineB)
                RageUI.Line(BoutiqueConfig.LineR, BoutiqueConfig.LineG, BoutiqueConfig.LineB)

            end)

            RageUI.IsVisible(menu_car, function()
                RageUI.Info("Boutique", {"", BoutiqueConfig.Theme.."Code Boutique : ", BoutiqueConfig.Theme..BoutiqueConfig.Theme.."Coin(s) : "}, {"", BoutiqueID, CountCoins})
                RageUI.Line(BoutiqueConfig.LineR, BoutiqueConfig.LineG, BoutiqueConfig.LineB)

                for _, cars in pairs(BoutiqueConfig.cars) do
                    RageUI.Button(BoutiqueConfig.Theme.."→ ~s~"..cars.label,  nil, {RightLabel = BoutiqueConfig.Theme..BoutiqueConfig.Namecoin.." "..cars.price}, true, {
                        onSelected = function()
                            PROUTE = BoutiqueConfig.cars[_]
                        end
                    }, sous_menu_car)
                end


                RageUI.Line(BoutiqueConfig.LineR, BoutiqueConfig.LineG, BoutiqueConfig.LineB)

            end)

            RageUI.IsVisible(sous_menu_car, function()
                RageUI.Info("Boutique", {"", BoutiqueConfig.Theme.."Code Boutique : ", BoutiqueConfig.Theme.."Coin(s) : "}, {"", BoutiqueID, CountCoins})

                RageUI.Line(BoutiqueConfig.LineR, BoutiqueConfig.LineG, BoutiqueConfig.LineB)
                    RageUI.Button(""..BoutiqueConfig.Theme.."→ ~s~Essayer", "Vous permet d'~g~essayer~s~ le vehicule pendant 20 sec", {RightLabel = ""..BoutiqueConfig.Theme.."→→"}, true, {
                        onSelected = function()
                            posessaie = GetEntityCoords(PlayerPedId())
                            Wait(350)
                            CloseMenuBOUTIQUE()
                            spawnuniCar(PROUTE.model)
                        end
                    })

                    RageUI.Checkbox(""..BoutiqueConfig.Theme.."→ ~s~Full custom ~s~", "Vous permet de ~g~full custom~s~ le véhicule", Fullcustomcheck, {RightLabel = ""}, {
                        onChecked = function()
                            Wait(10)
                            Fullcustomcheck = true
                            pricecustom = PROUTE.price + BoutiqueConfig.FullCustom
                            print(pricecustom)
                        end,
                        onUnChecked = function()
                            Wait(10)
                            Fullcustomcheck = false

                            pricecustom = PROUTE.price
                            print(pricecustom)
                        end
                    })

                    RageUI.Checkbox(""..BoutiqueConfig.Theme.."→ ~s~Dans le garage~s~", "Vous permet de faire spawn le vehicule dans le ~g~garage", GarageOption , {RightLabel = ""}, {
                        onChecked = function()
                            Wait(10)
                            GarageOption  = true
                        end,
                        onUnChecked = function()
                            Wait(10)
                            GarageOption  = false
                        end
                    })

                    RageUI.Button(""..BoutiqueConfig.Theme.."→ ~g~Acheter", "Vous permet d'avoir le ~g~véhicule~s~ dans votre garage", {RightLabel = ""..BoutiqueConfig.Theme.."→→"}, true, {
                        onSelected = function()
                            buycar = Keyboard("Êtes vous sur ~g~oui~s~/~r~non", "", 3)
                            Wait(10)
                            if buycar == "oui" then 
                                if tonumber(CountCoins) >= tonumber(PROUTE.price) then 
                                    ESX.ShowNotification("Voiture achetée --> ~r~"..PROUTE.label)
                                    TriggerServerEvent("RemoveCoins", PROUTE.price)
                                    give_vehi(PROUTE.model)
                                    TriggerServerEvent("Pablozz:datacar",PROUTE.label , PROUTE.price, Fullcustomcheck)
                                    CloseMenuBOUTIQUE()
                                else
                                    ESX.ShowNotification("~r~Pas assez d'argent pour achetez "..PROUTE.label)
                                end
                            else
                                print("achat annulé")
                            end
                        end
                    })

                RageUI.Line(BoutiqueConfig.LineR, BoutiqueConfig.LineG, BoutiqueConfig.LineB)

            end)

            RageUI.IsVisible(menu_setting, function()
                RageUI.Info("Boutique", {"", BoutiqueConfig.Theme.."Code Boutique : ", BoutiqueConfig.Theme.."Coin(s) : "}, {"", BoutiqueID, CountCoins})

                RageUI.Line(BoutiqueConfig.LineR, BoutiqueConfig.LineG, BoutiqueConfig.LineB)
                
                RageUI.Button(BoutiqueConfig.Theme.."→ ~s~Transferer des ~o~coin(s)", "Vous permet de transferer des coin(s) à un "..BoutiqueConfig.Theme.."joueur", {RightLabel = BoutiqueConfig.Theme.."→→→"}, true, {
                    onSelected = function()
                        local idsend = Keyboard("Entrer l "..BoutiqueConfig.Theme.."id boutique~s~ de la personne pour transferer les coins", "", 5)
                        local coinsend = Keyboard("Entrer le nomdre de "..BoutiqueConfig.Theme.."coins~s~ a donner", "", 15)
                        if tonumber(CountCoins) >= tonumber(coinsend) then 
                            ESX.ShowNotification("Vous avez envoyez des coins a l'id boutique : ~g~"..idsend.."~s~")
                            TriggerServerEvent("RemoveCoins", coinsend)
                            TriggerServerEvent("Pablozz:datatransfer", idsend, coinsend)
                            Wait(5000)
                            TriggerServerEvent("AddCoins", idsend, coinsend) 
                        else
                            ESX.ShowNotification("Vous n avez pas les fonds necessaire")
                        end
                    end
                })

                
                RageUI.Line(BoutiqueConfig.LineR, BoutiqueConfig.LineG, BoutiqueConfig.LineB)
            end)

            Wait(1)
        end
    end)
end

function CreateVeh(model)
    ESX.Game.SpawnLocalVehicle(model, vec3(0.0, 0.0, 0.0), 0.0, function(vehicle)
        local plate = GeneratePlate()--Function à def dans le opensource :)
        local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
        vehicleProps.plate = plate
        SetVehicleNumberPlateText(vehicle, plate)
        TriggerServerEvent("give:vehicle", model)
        Wait(1000)
        DeleteEntity(vehicle)
    end)
end

RegisterCommand(BoutiqueConfig.Command, function()
    OpenMenuBoutique(v)
end)

Keys.Register(BoutiqueConfig.Touche, BoutiqueConfig.Hash, "Ouvrir le menu", function()
    OpenMenuBoutique(v)
end)
