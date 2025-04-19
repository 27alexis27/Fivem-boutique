BoutiqueConfig = {
    Type = "new", -- old/new        pour la version ESX
    Trigger = "esx:getSharedObject", -- trigger esx de la base
    Framework = "es_extended", -- Le nom du framework pour l'importation ESX
    
        -- ------------------------------ Apparence de la boutique -----------------------------------------
    
    FullCustom = 1500, -- prix pour full custom son vehicules
    Theme = "~p~", -- couleur / theme de la boutique 
    Command = "boutique", -- a modifier ( mettre sans le "/")
    CommandGive = "givecoins", -- Commande pour give les coins
    CommandRemove = "removecoins", -- Commande pour give les coins
    Touche = "F1", -- touche pour ouvrir la boutique 
    Hash = "288", -- hash qui permet d'ouvrir le menu
    Type = "money", -- type d'argent a give
    Namecoin = "Coins~s~", -- le nom des coins de la boutique
    Lien = "https://discord.gg/arizonarp", -- lien de votre boutique , discord...
    LineR = "100", -- couleur du rageUI.Line Red
    LineG = "0", -- couleur du rageUI.Line Green
    LineB = "255", -- couleur du rageUI.Line Blue


    -- ------------------------------ Permissions -----------------------------------------
    GroupAcces = { -- permission voulu pour gives les coins et les removes
    "_dev",
    "owner",
    },

    -- ------------------------------Contenue de la section Logs -----------------------------------------

    ColorEmbed = "743891", -- couleur des embeds
    Icon = "https://discord.com/api/webhooks/", -- lien de l'icon des logs
    Webhookmoney = "https://discord.com/api/webhooks/", -- webhook pour les achats d'argent... 
    Webhookcar = "https://discord.com/api/webhooks/",
    Webhookweapon = "https://discord.com/api/webhooks/",
    Webhookpack = "https://discord.com/api/webhooks/",
    Webhooktransfer = "https://discord.com/api/webhooks/",
    -- ------------------------------ Bouton actif -----------------------------------------
    
    Coin = true, -- ajouter le boutons boutique (lien/bouton)
    Argent = true, -- ajouter le argent
    Pack = true, -- ajouter le pack
    
    -- ------------------------------ Nom des boutons -----------------------------------------
    
    NameMoney = "Argent(s)", -- titre sous menu du menu Argent
    NamePack = "Pack", -- titre sous menu pack
    NameTool = "Accessoire d'arme", -- titre sous menu des caisses
    NameWeapon = "Arme(s)", -- titre sous menu des armes
    NameCar = "Voiture(s)", -- titre sous menu des voitures
    NameSetting = "Option", -- titre sous menu option

    -- -- ------------------------------Contenue de la section argent -----------------------------------------

    cash = { 
        {label = "100k ~g~$", amount = 100000, price = 1000},
        {label = "250k ~g~$", amount = 250000, price = 2000},
        {label = "500k ~g~$", amount = 500000, price = 3500},
            -- Ajoutez d'autres somme d'argent ici
        },
        

    -- ------------------------------Contenue des caisses -----------------------------------------

    caisse = { 
        {label = "Caisse ~p~Rare", desc = "Vous permet d'acheter une caisse rare", rare = 1000},
        {label = "Caisse ~o~Légendaire", desc = "Vous permet d'acheter une caisse ~o~legendaire", rare = 1500},
        {label = "Caisse ~r~Mythique", desc = "Vous permet d'acheter une caisse ~r~mythique", rare = 2000},

            -- Ajoutez d'autres caisse ici
        },

    -- ------------------------------Contenue de la section pack -----------------------------------------

    pack = { 
        {label = "~s~Pack ~r~Illégal~s~", desc = "Vous permet d'obtenir une organisation ~r~illégal", price = 3000},
        {label = "~s~Pack ~g~Légal~s~", desc = "Vous permet de crée/obtenir une ~g~enterprise", price = 3000},

            -- Ajoutez d'autres pack ici
        },

    -- ------------------------------Contenue de la section arme -----------------------------------------

    weapons = { 
    {label = "Batte", model = "weapon_bat", price = 1000},
    {label = "Ak47 Mk2", model = "weapon_assaultrifle_mk2", price = 2000},
    {label = "Pistolet", model = "weapon_pistol_mk2", price = 1500},
    {label = "Fusil a pompe ~y~[IMPORT]", model = "weapon_sawnoffshotgun", price = 5000},
    {label = "Sniper ~y~[IMPORT]", model = "weapon_heavyrifle", price = 4500},  
        -- Ajoutez d'autres armes ici
    },

    -- -- ------------------------------Contenue de la section véhicule -----------------------------------------

    cars = { 
        {label = "Zentorno", model = "zentorno", price = 2000},
        {label = "Nero", model = "nero", price = "1500"},
        {label = "Porsche 911 ~y~[IMPORT]", model = "voltic", price = 5000},
        {label = "Lamborgini Aventador ~y~[IMPORT]", model = "zentorno", price = 4500}
            -- Ajoutez d'autres véhicules ici
        }
}
