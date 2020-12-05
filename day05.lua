require("util")

local function solve(filename)
  local seats = {}

  for seat in io.lines(filename) do
    seat = string.gsub(seat, "F", "0")
    seat = string.gsub(seat, "B", "1")
    seat = string.gsub(seat, "R", "1")
    seat = string.gsub(seat, "L", "0")
    seat = tonumber(seat, 2)
    table.insert(seats, seat)
  end

  table.sort(seats)

  print(seats[#seats])

  for i = 1, #seats - 1 do
    if seats[i + 1] - seats[i] > 1 then print(seats[i] + 1) end
  end
end

solve("input1")
solve("input2")