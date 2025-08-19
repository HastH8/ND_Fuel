local ox = exports.ox_core

RegisterNetEvent("ND_Fuel:pay", function(amount)
    local src = source
    local player = ox:GetPlayer(src)
    if not player then return end

    local account = player.getAccount() -- default account
    local success = account:remove(math.floor(amount), "Fuel Purchase")

    if success then
        player.emit("ox:notify", {
            type = "inform",
            description = ("Paid: $%.2f for fuel."):format(amount),
            position = "top"
        })
    else
        player.emit("ox:notify", {
            type = "error",
            description = "Not enough money for fuel!",
            position = "top"
        })
    end

    -- tell client if payment succeeded/failed
    TriggerClientEvent("ND_Fuel:result", src, success)
end)