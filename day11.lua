require("util")

local function solve(filename, part)
  local seats = {}
  for line in io.lines(filename) do
    local row = {}
    for seat in line:gmatch(".") do
      table.insert(row, seat)
    end
    table.insert(seats, row)
  end

  local function occupied(x, y)
    if x <= 0 or y <= 0 or x > #seats[1] or y > #seats then return 0 end
    if part ~= 1 and seats[y][x] == "." then return nil end
    return (seats[y][x] == "#") and 1 or 0
  end

  local function adjacent(x, y, xoff, yoff)
    return occupied(x + xoff, y + yoff)
  end

  local function vision(x, y, xoff, yoff)
    repeat
      x = x + xoff
      y = y + yoff
    until occupied(x, y) ~= nil
    return occupied(x, y)
  end

  local occupiedRule = (part == 1) and adjacent or vision
  local maxOccupied = (part == 1) and 4 or 5

  local function countOccupied(x, y)
    local count = 0
    for xoff = -1, 1 do
      for yoff = -1, 1 do
        (function()
          if xoff == 0 and yoff == 0 then return end
          count = count + occupiedRule(x, y, xoff, yoff)
        end)()
      end
    end
    return count
  end

  local changed = true
  while changed do
    changed = false
    local newSeats = {}
    for y = 1, #seats do
      table.insert(newSeats, {})
      for x = 1, #seats[1] do
        local type = seats[y][x]
        newSeats[y][x] = type
        if type ~= "." then
          local count = countOccupied(x, y)
          if type == "L" and count == 0 then
            newSeats[y][x] = "#"
            changed = true
          elseif type == "#" and count >= maxOccupied then
            newSeats[y][x] = "L"
            changed = true
          end
        end
      end
    end
    seats = newSeats
  end

  local finalOccupied = 0
  for y = 1, #seats do
    for x = 1, #seats[1] do
      if seats[y][x] == "#" then finalOccupied = finalOccupied + 1 end
    end
  end
  print(finalOccupied)
end

solve("input1", 1)
solve("input2", 1)
solve("input1", 2)
solve("input2", 2)