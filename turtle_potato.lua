-- 1 = Fuel
-- 2 = Hand Item
-- 3 = Seed

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

function swapItem()
    turtle.select(2)
    turtle.equipRight()
    turtle.select(3)
end

-- Farms a straight line
function farmLine()
    for i = 1, 13 do
        refuel()
        turtle.forward()
        if isGrown() then
            swapItem()
            turtle.digDown()
            swapItem()
        end
        turtle.select(3)
        if canPlace() then
            turtle.placeDown()
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
    for slot = 3, 16 do
        turtle.select(slot)
        if slot == 3 then
            cnt = turtle.getItemCount()
            if cnt > 16 then
                turtle.dropDown(cnt - 16)
            end
        else
            turtle.dropDown()
        end
    end
end

-- Back to chest
function returnHome()
    refuel()
    turtle.turnLeft()
    for i = 1, 4 do
        turtle.forward()
    end
    turtle.turnLeft()
    for i = 1, 7 do
        turtle.forward()
    end
    turtle.suckDown()
    for i = 1, 7 do
        turtle.back()
    end
    turtle.turnRight()
    for i = 1, 5 do
        turtle.forward()
    end
    emptyInventory()
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
