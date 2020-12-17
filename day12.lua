require("util")

local function solve(filename)
  ---------------------------------------------------------
  -- part 1

  local ship =
  {
    x = 0, y = 0, dirIdx = 1,
    direction = function(self) return ({"E", "S", "W", "N"})[self.dirIdx] end,
    move = function(self, x, y) self.x = self.x + x; self.y = self.y + y end,
    turn = function(self, n) self.dirIdx = util.mod(self.dirIdx + n, 4) end,
    distance = function(self) return math.abs(self.x) + math.abs(self.y) end
  }

  for action, arg in io.open(filename, "r"):read("*a"):gmatch("(%a)(%d+)") do
    arg = tonumber(arg)
    if action == "L" then
      ship:turn(-arg / 90)
    elseif action == "R" then
      ship:turn(arg / 90)
    else
      local moveDirection = (action == "F") and ship:direction() or action
      if moveDirection == "N" then
        ship:move(0, arg)
      elseif moveDirection == "E" then
        ship:move(arg, 0)
      elseif moveDirection == "S" then
        ship:move(0, -arg)
      else
        ship:move(-arg, 0)
      end
    end
  end

  print(ship:distance())

  ---------------------------------------------------------
  -- part 2

  ship.x, ship.y = 0, 0
  local waypoint =
  {
    x = 10, y = 1, move = ship.move,
    rotate = function(self, n)
      for _ = 1, math.abs(n) do
        if n > 0 then
          self.x, self.y = self.y, -self.x
        else
          self.x, self.y = -self.y, self.x
        end
      end
    end
  }

  for action, arg in io.open(filename, "r"):read("*a"):gmatch("(%a)(%d+)") do
    arg = tonumber(arg)
    if action == "N" then
      waypoint:move(0, arg)
    elseif action == "E" then
      waypoint:move(arg, 0)
    elseif action == "S" then
      waypoint:move(0, -arg)
    elseif action == "W" then
      waypoint:move(-arg, 0)
    elseif action == "L" then
      waypoint:rotate(-arg / 90)
    elseif action == "R" then
      waypoint:rotate(arg / 90)
    else
      ship:move(waypoint.x * arg, waypoint.y * arg)
    end
  end

  print(ship:distance())
end

solve("input1")
solve("input2")