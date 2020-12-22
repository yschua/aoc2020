require("util")

local function solve(filename, maxTurns)
  local Buffer = {}
  function Buffer:add(n)
    self[2] = self[1]
    self[1] = n
  end
  function Buffer:age()
    if not self[1] or not self[2] then return 0 end
    return self[1] - self[2]
  end
  function Buffer:new()
    local o = {nil, nil}
    setmetatable(o, self)
    self.__index = self
    return o
  end

  for line in io.lines(filename) do
    local spoken = {}
    local turn = 1
    local n
    for s in line:gmatch("(%d+)") do
      n = tonumber(s)
      spoken[n] = Buffer:new()
      spoken[n]:add(turn)
      turn = turn + 1
    end
    while turn <= maxTurns do
      n = spoken[n]:age()
      if not spoken[n] then spoken[n] = Buffer:new() end
      spoken[n]:add(turn)
      turn = turn + 1
    end
    print(n)
  end
end

solve("input1", 2020)
solve("input2", 2020)
solve("input1", 30000000)
solve("input2", 30000000)