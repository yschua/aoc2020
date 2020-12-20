require("util")

local function solve1(filename)
  local file = io.open(filename, "r")
  local arriveTime = tonumber(file:read("*line"))
  local shortestWaitTime = math.huge
  local earliestBus
  for bus in file:read("*line"):gmatch("(%d+)") do
    local waitTime = (math.ceil(arriveTime / bus) * bus) - arriveTime
    if waitTime < shortestWaitTime then
      shortestWaitTime = waitTime
      earliestBus = bus
    end
  end
  print(math.floor(shortestWaitTime * earliestBus))
end

solve1("input1")
solve1("input2")

local function solve2(filename)
  for line in io.lines(filename) do
    local buses = {}
    for i, id in ipairs(line:split(",")) do
      id = tonumber(id)
      if id then
        table.insert(buses, {id = id, offset = i - 1})
      end
    end

    local function verify(time)
      local count = 0
      for _, bus in ipairs(buses) do
        if (time + bus.offset) % bus.id == 0 then
          count = count + 1
        else
          return count
        end
      end
      return true
    end

    local time = buses[1].id
    local increment = 1
    local highestCount = 1
    local lcmList = {buses[1].id}
    while true do
      local count = verify(time)
      if count == true then break end
      if count > highestCount then
        highestCount = count
        table.insert(lcmList, buses[highestCount].id)
        increment = util.lcm(lcmList)
      end
      time = time + increment
    end
    print(math.floor(time))
  end
end

solve2("input3")
solve2("input4")
