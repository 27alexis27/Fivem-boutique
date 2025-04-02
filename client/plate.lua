function GeneratePlate()
    local generatedPlate
    local doBreak = false

    while true do
        Citizen.Wait(2)
        math.randomseed(GetGameTimer())
        generatedPlate = string.upper(GetRandomLetter(2) .. GetRandomNumber(2))

        local isPlateTaken = IsPlateTaken(generatedPlate)

        if not isPlateTaken then
            doBreak = true
        end

        if doBreak then
            break
        end
    end

    return generatedPlate
end

function IsPlateTaken(plate)
    local callback = 'waiting'

    ESX.TriggerServerCallback('esx_vehicleshop:isPlateTaken', function(isPlateTaken)
        callback = isPlateTaken
    end, plate)

    while type(callback) == 'string' do
        Citizen.Wait(0)
    end

    return callback
end

function GetRandomLetter(length)
    local letters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
    local letter = ''
    for i = 1, length do
        letter = letter .. string.sub(letters, math.random(1, #letters), math.random(1, #letters))
    end
    return letter
end

function GetRandomNumber(length)
    local numbers = '0123456789'
    local number = ''
    for i = 1, length do
        number = number .. string.sub(numbers, math.random(1, #numbers), math.random(1, #numbers))
    end
    return number
end
