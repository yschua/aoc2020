require("util")

local function solve(filename)
  local rawInput = io.open(filename, "r"):read("*a"):trim()
  local groups = rawInput:split("\n\n")
  for i, group in ipairs(groups) do
    groups[i] = group:split("\n")
  end
  
  local sum1, sum2 = 0, 0

  for _, group in ipairs(groups) do
    local set = {}
    for _, person in ipairs(group) do
      for c in person:gmatch(".") do
        set[c] = true
      end
    end
    sum1 = sum1 + util.size(set)

    for v in pairs(set) do
      local yes = true
      for _, person in ipairs(group) do
        if not person:find(v) then yes = false end
      end
      if yes then sum2 = sum2 + 1 end
    end
  end
  
  print(sum1)
  print(sum2)
end

solve("input1")
solve("input2")