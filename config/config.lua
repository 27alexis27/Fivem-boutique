BoutiqueConfig = {
    Framework = "es_extended",
    
        -- ------------------------------ Apparence de la boutique -----------------------------------------
    
    FullCustom = 1500, -- prix pour full custom son vehicules
    Theme = "~p~", -- couleur / theme de la boutique 
    Command = "boutique", -- a modifier ( mettre sans le "/")
    CommandGive = "givecoins", -- Commande pour give les coins
    CommandRemove = "removecoins", -- Commande pour give les coins
    Touche = "F1", -- touche pour ouvrir la boutique 
    Hash = "288", -- hash qui permet d'ouvrir le menu
    Type = "money", -- type d'argent a give
    Namecoin = "Pcoins~s~", -- le nom des coins de la boutique
    Lien = "https://pablo-script.tebex.io", -- lien de votre boutique , discord...
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
    Icon = "https://media.discordapp.net/attachments/1174751284205715486/1191695251111411732/52c3aFN.png?ex=65d48430&is=65c20f30&hm=999b3dddab2a28a6d97ec4f8df8af9137b0be7eba19af79afc2b4426aaa8c153&=&format=webp&quality=lossless&width=671&height=671", -- lien de l'icon des logs
    Webhookmoney = "https://discord.com/api/webhooks/1175586851856318565/png3yCNkWrslkC0w91p7ApV5zYqyWZAHMDfWf8kOdw_cDIIeA95Hb9QTQ9olny4xQRNU", -- webhook pour les achats d'argent... 
    Webhookcar = "https://discord.com/api/webhooks/1175586851856318565/png3yCNkWrslkC0w91p7ApV5zYqyWZAHMDfWf8kOdw_cDIIeA95Hb9QTQ9olny4xQRNU",
    Webhookweapon = "https://discord.com/api/webhooks/1175586851856318565/png3yCNkWrslkC0w91p7ApV5zYqyWZAHMDfWf8kOdw_cDIIeA95Hb9QTQ9olny4xQRNU",
    Webhookpack = "https://discord.com/api/webhooks/1175586851856318565/png3yCNkWrslkC0w91p7ApV5zYqyWZAHMDfWf8kOdw_cDIIeA95Hb9QTQ9olny4xQRNU",
    Webhooktransfer = "https://discord.com/api/webhooks/1175586851856318565/png3yCNkWrslkC0w91p7ApV5zYqyWZAHMDfWf8kOdw_cDIIeA95Hb9QTQ9olny4xQRNU",
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
