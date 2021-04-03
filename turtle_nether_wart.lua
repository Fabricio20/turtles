-- Slot 1 = Coal
-- Slot 2 = Nether Wart

-- minecraft:nether_wart
-- metadata 3 = Fully grown

function refuel()
    turtle.select(1)
    if turtle.getFuelLevel() < 48 then
        turtle.refuel(1)
        print("> Refueling...")
    end
end

function forward(times)
    refuel()
    for i = 1, times do
        turtle.forward()
    end
end

function collectNetherWart()
    local success, data = turtle.inspectDown()

    if data.name == "minecraft:nether_wart" and data.metadata == 3 then
        turtle.digDown()
        plantNetherWart()
    elseif not data.name then
        plantNetherWart()
    end
end

function plantNetherWart()
    for slot = 2, 3 do
        if turtle.getItemSpace(slot) < 64 then
            turtle.select(slot)
            turtle.placeDown()
            break
        end
    end
end

function pickUpNetherWart()
    for slot = 2, 3 do
        local amount = turtle.getItemSpace(slot)
        if amount > 0 then
            turtle.select(slot)
            turtle.suckDown(amount)
        end
    end
end

function empty()
    for slot = 4, 16 do
      turtle.select(slot)
      turtle.dropDown()
    end
end

while true do
    -- prepareing to start
    refuel()
    pickUpNetherWart()
    forward(6)
    turtle.turnRight()
    turtle.forward()
    turtle.turnRight()

    -- collecting nether warts
    for y = 1, 13 do
        refuel()
        for x = 1, 13 do
            if y ~= 7 or x ~= 7 then
                collectNetherWart()
            end

            if x ~= 13 then
                turtle.forward()
            end
        end
        if y % 2 == 0 then
            turtle.turnRight()
            turtle.forward()
            turtle.turnRight()
        elseif y ~= 13 then
            turtle.turnLeft()
            turtle.forward()
            turtle.turnLeft()
        end
    end

    -- going to barrel
    turtle.forward()
    turtle.turnRight()
    forward(13)
    turtle.turnRight()
    forward(7)
    empty()

    -- wait 10min
    sleep(600)
end