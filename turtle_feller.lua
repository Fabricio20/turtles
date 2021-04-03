-- 1 COAL = 80 BLOCKS
--
-- 1 = COAL
-- 2 = BIRCH SAPLING
-- 3 = BIRCH WOOD

-- Birch wood hight = 6

-- yabba:item_barrel
-- minecraft:cobblestone

function refuel()
    turtle.select(1)
    if turtle.getFuelLevel() < 48 then
        turtle.refuel(1)
        print("> Refueling...")
    end
end

function chopWood()
    refuel()
    turtle.select(3)
    turtle.dig()
    turtle.forward()
    local height = 1

    while turtle.detectUp() and isBirchWoodAbove() do
        turtle.digUp()
        turtle.up()
        height = height + 1
    end

    for i = 1, height - 1 do
        turtle.down()
    end

    turn180()
    placeSaplingDown()
    turtle.forward()
    turtle.down()
end

function placeSapling()
    turtle.select(2)
    turtle.place()
end

function placeSaplingDown()
    turtle.select(2)
    turtle.placeDown()
end

function turn180()
    turtle.turnLeft()
    turtle.turnLeft()
end

function isBirchWood()
    local success, data = turtle.inspect()
    return data.name == "minecraft:log"
end

function isBirchWoodAbove()
    local success, data = turtle.inspectUp()
    return data.name == "minecraft:log"
end

function isBirchSapling()
    local success, data = turtle.inspect()
    return data.name == "minecraft:sapling"
end

function chopLeftAndRight()
    turtle.turnLeft()

    if isBirchWood() then
        chopWood()
    elseif isBirchSapling() then
        turn180()
    else
        placeSapling()
        turn180()
    end

    if isBirchWood() then
        chopWood()
        turtle.turnRight()
    elseif isBirchSapling() then
        turtle.turnLeft()
    else
        placeSapling()
        turtle.turnLeft()
    end
end

function chopFront()
    if isBirchWood() then
        chopWood()
        turtle.turnLeft() 
    elseif isBirchSapling() then
        turtle.turnRight()
    else
        placeSapling()
        turtle.turnRight()
    end
end

function chopLeftAndContinue()
    turtle.turnLeft()
    if isBirchWood() then
        chopWood()
    elseif isBirchSapling() then
        turn180()
    else
        placeSapling()
        turn180()
    end
end

function chopLeft()
    turtle.turnLeft()
    chopFront()
end

function chopRight()
    turtle.turnRight()
    if isBirchWood() then
        chopWood()
        turtle.turnRight() 
    elseif isBirchSapling() then
        turtle.turnLeft()
    else
        placeSapling()
        turtle.turnLeft()
    end
end

function forward(times)
    refuel()
    for i = 1, times do
        turtle.forward()
    end
end

function chopAndTurnClockwise()
    turtle.turnRight()
    turtle.forward()
    chopLeft()
    turtle.forward()
    turtle.turnRight()
end

function chopAndTurnAnticlockwise()
    turtle.turnLeft()
    turtle.forward()
    chopRight()
    turtle.forward()
    turtle.turnLeft()
end

function empty()
    for slot = 3, 16 do
      turtle.select(slot)
      turtle.dropDown()
    end
end

while true do
    -- start working
    refuel()
    turtle.forward()
    for i = 1, 5 do
        chopLeftAndRight()
        forward(2)
    end
    chopLeftAndRight()
    turtle.forward()

    -- first corner to third corner
    chopAndTurnClockwise()
    forward(5)
    chopLeft()
    forward(5)

    -- third corner to fifth corner
    chopAndTurnAnticlockwise()
    turtle.forward()
    chopLeftAndRight()
    forward(2)
    chopLeftAndRight()
    forward(4)
    chopLeftAndRight()
    forward(2)
    chopLeftAndRight()
    turtle.forward()

    -- fifth corner to seventh corner
    chopAndTurnClockwise()
    turtle.forward()

    for i = 1, 4 do
        chopLeft()
        forward(2)
    end

    chopLeft()
    turtle.forward()

    -- seventh corner to ninth corner
    chopAndTurnAnticlockwise()
    forward(10)

    -- ninth corner to eleventh corner
    chopAndTurnClockwise()
    turtle.forward()
    for i = 1, 5 do
        chopLeftAndRight()
        forward(2)
    end
    chopLeftAndRight()
    turtle.forward()

    -- eleventh corner
    turtle.turnRight()
    forward(4)

    -- placing wood into barrel
    empty()
    forward(2)

    -- getting sapling from barrel
    turtle.select(2)
    turtle.suckDown()
    forward(4)

    -- went around
    turtle.turnRight()
    print("> Finished, Fuel Wasted:")
    print(turtle.getFuelLevel())
    sleep(300)
end