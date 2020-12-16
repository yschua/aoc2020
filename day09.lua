require("util")

local function solve(filename, preamble)
  ---------------------------------------------------------
  -- part 1

  local cypher = {}

  local function validate(number)
    local from, to = #cypher - preamble, #cypher - 1
    for i = from, to do
      local diff = number - cypher[i]
      if diff > 0 then
        for j = from, to do
          if cypher[j] == diff then return true end
        end
      end
    end
    return false
  end

  for line in io.lines(filename) do
    local number = tonumber(line)
    table.insert(cypher, number)
    if #cypher > preamble and not validate(number) then
      print(number)
      break
    end
  end

  ---------------------------------------------------------
  -- part 2

  local invalidNumber = table.remove(cypher, #cypher)

  local from, to = 1, 2
  local sum = cypher[from] + cypher[to]
  while sum ~= invalidNumber do
    if sum < invalidNumber then
      to = to + 1
      sum = sum + cypher[to]
    else
      sum = sum - cypher[from]
      from = from + 1
    end
  end

  local min, max = cypher[from], cypher[from]
  for i = from + 1, to do
    min = math.min(min, cypher[i])
    max = math.max(max, cypher[i])
  end
  print(min + max)
end

solve("input1", 5)
solve("input2", 25)