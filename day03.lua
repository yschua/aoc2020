require("util")

local function solve(filename)
  local map = {}
  for line in io.lines(filename) do table.insert(map, line) end

  local function traverse(right, down)
    local trees = 0
    local col = 1

    for row = 1, #map, down do
      if string.sub(map[row], col, col) == "#" then
        trees = trees + 1
      end
      col = util.mod(col + right, #map[row])
    end

    return trees
  end

  print(traverse(3, 1))
  print(traverse(1, 1) * traverse(3, 1) * traverse(5, 1) * traverse(7, 1) * traverse(1, 2))
end

solve("input1")
solve("input2")