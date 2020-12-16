require("util")

local function solve(filename)
  ---------------------------------------------------------
  -- part 1

  local adapters = {0}
  for line in io.lines(filename) do
    table.insert(adapters, tonumber(line))
  end

  table.sort(adapters)

  local diffs = {0, 0, 1}
  for i = 1, #adapters - 1 do
    local diff = adapters[i + 1] - adapters[i]
    diffs[diff] = diffs[diff] + 1
  end
  print(diffs[1] * diffs[3])

  ---------------------------------------------------------
  -- part 2

  -- check number does not have 3 contiguous zeros
  local function valid(number, size)
    local zeros = 0
    for _ = 1, size do
      if number & 1 == 0 then
        zeros = zeros + 1
        if zeros == 3 then return false end
      else
        zeros = 0
      end
      number = number >> 1
    end
    return true
  end

  local permutations = {}

  -- count of numbers with no 3 contiguous zeros
  local function permutation(size)
    if size < 3 then return 1 end
    size = size - 2 -- exclude leftmost and rightmost bits, as they must be one
    if permutations[size] then return permutations[size] end

    local count = 0
    for i = 0, (2 ^ size) - 1 do
      if valid(i, size) then count = count + 1 end
    end
    permutations[size] = count
    return count
  end

  local total = 1
  local size = 1
  for i = 1, #adapters - 1 do
    local diff = adapters[i + 1] - adapters[i]
    if diff == 1 then
      size = size + 1
    else
      -- calculate permutation for a series of adapters all with 1 jolt diff
      total = total * permutation(size)
      size = 1
    end
  end
  total = total * permutation(size)
  print(total)
end

solve("input1")
solve("input2")
solve("input3")