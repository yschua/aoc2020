require("util")

local Pocket = {numActive = 0}
function Pocket:new()
  local o = {}
  setmetatable(o, self)
  self.__index = self
  return o
end
function Pocket:get(x, y, z, w)
  if not self[w] then return false end
  if not self[w][z] then return false end
  if not self[w][z][y] then return false end
  return (self[w][z][y][x] ~= nil)
end
function Pocket:activate(x, y, z, w)
  if not self[w] then self[w] = {} end
  if not self[w][z] then self[w][z] = {} end
  if not self[w][z][y] then self[w][z][y] = {} end
  self[w][z][y][x] = {}
  self.numActive = self.numActive + 1
end
function Pocket:neighbors(centreX, centreY, centreZ, centreW)
  local count = 0
  for x = centreX - 1, centreX + 1 do
    for y = centreY - 1, centreY + 1 do
      for z = centreZ - 1, centreZ + 1 do
        for w = centreW - 1, centreW + 1 do
          if x ~= centreX or y ~= centreY or z ~= centreZ or w ~= centreW then
            if self:get(x, y, z, w) then count = count + 1 end
          end
        end
      end
    end
  end
  return count
end

local function solve(filename, is3d)
  local rows = io.open(filename, "r"):read("*a"):trim():split("\n")
  local pocket = Pocket:new()
  for y, row in ipairs(rows) do
    for x = 1, #row do
      if row:sub(x, x) == "#" then pocket:activate(x, y, 1, 1) end
    end
  end

  local size = {x = #rows[1], y = #rows, z = 1, w = 1}
  local cycles = 6
  for cycle = 1, cycles do
    local nextPocket = Pocket:new()
    for w = -cycle + 1, size.w + cycle do
      if is3d then w = 1 end
      for x = -cycle + 1, size.x + cycle do
        for y = -cycle + 1, size.y + cycle do
          for z = -cycle + 1, size.z + cycle do
            local active = pocket:get(x, y, z, w)
            local neighbors = pocket:neighbors(x, y, z, w)
            if active and (neighbors == 2 or neighbors == 3) then
              nextPocket:activate(x, y, z, w)
            elseif not active and neighbors == 3 then
              nextPocket:activate(x, y, z, w)
            end
          end
        end
      end
      if is3d then break end
    end
    pocket = nextPocket
  end

  print(pocket.numActive)
end

solve("input1", true)
solve("input2", true)
solve("input1", false)
solve("input2", false)