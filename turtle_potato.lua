-- 1 = Fuel
-- 2 = Seed

function isGrown()
    success, data = turtle.inspectDown()
    if success then
        return data.metadata == 7
    else
        return false
    end
end

function canPlace()
    return false == turtle.detectDown()
end

-- Refuels if necessary
function refuel()
    turtle.select(1)
    if turtle.getFuelLevel() < 16 then
      turtle.refuel(1)
      print("> Refueling...")
      print(turtle.getFuelLevel())
    end
end

-- Break actually breaks 6 blocks for some reason
function fixFuckup()
    turtle.forward()
    turtle.suckDown()
    turtle.back()
    for x = 1,2 do
        turtle.back()
        turtle.suckDown()
        if canPlace() then
            turtle.placeDown()
        end
    end
    turtle.forward()
    turtle.forward()
end

-- Farms a straight line
function farmLine()
    refuel()
    for i = 1, 13 do
        hasFarmed = false
        turtle.forward()
        turtle.select(2)
        if isGrown() then
            turtle.digDown()
            hasFarmed = true
        end
        turtle.suckDown()
        if canPlace() then
            turtle.placeDown()
        end
        if hasFarmed then
            fixFuckup()
        end
    end
    -- Exit to wood
    turtle.forward()
end

-- Skips the 1-block wide water patch
function skipWater()
    refuel()
    turtle.turnRight()
    turtle.forward()
    turtle.forward()
    turtle.turnRight()
end

function farmRow()
    farmLine()
    turtle.turnLeft()
    turtle.forward()
    turtle.turnLeft()
    farmLine()
    turtle.turnRight()
    turtle.forward()
    turtle.turnRight()
    farmLine()
    turtle.turnLeft()
    turtle.forward()
    turtle.turnLeft()
    farmLine()
end

-- Empties the inventory
function emptyInventory()
    for slot = 2, 16 do
        turtle.select(slot)
        turtle.dropDown()
    end
end

-- Back to chest
function returnHome()
    refuel()
    turtle.turnLeft()
    for i = 1, 9 do
        turtle.forward()
    end
    turtle.down()
    emptyInventory()
    turtle.up()
end

-- Leave chest, prepare to move
function resetStart()
    refuel()
    turtle.turnLeft()
    turtle.turnLeft()
    turtle.forward()
    turtle.turnRight()
end

while (true) do
    resetStart()
    farmRow()
    skipWater()
    farmRow()
    returnHome()
    sleep(300)
end
