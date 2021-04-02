-- 1 COAL = 80 BLOCKS
--
-- 1 = COAL
-- 2 = CHEST
-- 3 = TORCH

x = 0
y = 0

function mine()
  while turtle.detect() do
    turtle.dig()
  end
  turtle.forward()
  while turtle.detectUp() do
    turtle.digUp()
  end
  while turtle.detectDown() do
    turtle.digDown()
  end
end

function strip()
  refuel()
  x = 0
  for i = 1, 16 do
    mine()
	x = x + 1
	torch()
  end
  if hasToEmpty() then
    print("> Depositing Items...")
	empty()
  end
end

function refuel()
  turtle.select(1)
  if turtle.getFuelLevel() < 48 then
    turtle.refuel(1)
	print("> Refueling...")
  end
end

function placeTorch()
  turtle.select(3)
  turtle.placeDown()
end

function torch()
  if (x == 8 or x == 16 or x == 1) and (y % 8 == 0) then
    placeTorch()
  end
end

function empty()
  turtle.select(2)
  turtle.placeDown()
  for slot = 4, 16 do
    turtle.select(slot)
    turtle.dropDown()
  end
end

function hasToEmpty()
  turtle.select(16)
  if turtle.getItemSpace() < 48 then
    return true
  end
end

for i = 1, 8 do
  strip()
  turtle.turnRight()
  mine()
  turtle.turnRight()
  y = y + 1
  strip()
  turtle.turnLeft()
  mine()
  turtle.turnLeft()
  y = y + 1
end
print("> Finished, Fuel Wasted:")
print(turtle.getFuelLevel())