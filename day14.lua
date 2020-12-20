require("util")

local function solve1(filename)
  local zeroMask, oneMask
  local memory = {}
  for line in io.lines(filename) do
    if line:find("mask") then
      local mask = line:match("mask = (%w+)")
      zeroMask = tonumber(mask:gsub("X", "1"), 2)
      oneMask = tonumber(mask:gsub("X", "0"), 2)
    else
      local address, value = line:match("mem%[(%d+)%] = (%d+)")
      memory[address] = (value | oneMask) & zeroMask
    end
  end

  local sum = 0
  for _, v in pairs(memory) do sum = sum + v end
  print(sum)
end

solve1("input1")
solve1("input2")

local function solve2(filename)
  local function decodeMask(mask, numBits, value)
    mask = table.fromstring(mask)
    local i = #mask
    while numBits > 0 do
      if mask[i] == "X" then
        mask[i] = tostring(value & 1)
        value = value >> 1
        numBits = numBits - 1
      end
      i = i - 1
    end
    return tonumber(table.tostring(mask), 2)
  end

  local offsets = {}
  local function getOffsets(mask)
    if not offsets[mask] then
      local _, n = mask:gsub("X", "")
      offsets[mask] = {}
      for i = 0, 2^n - 1 do
        table.insert(offsets[mask], decodeMask(mask, n, i))
      end
    end
    return offsets[mask]
  end

  local zeroMask, oneMask, floatingMask
  local memory = {}
  for line in io.lines(filename) do
    if line:find("mask") then
      local mask = line:match("mask = (%w+)")
      zeroMask = tonumber(mask:gsub("0", "1"):gsub("X", "0"), 2)
      oneMask = tonumber(mask:gsub("X", "0"), 2)
      floatingMask = mask:gsub("1", "0")
    else
      local baseAddress, value = line:match("mem%[(%d+)%] = (%d+)")
      baseAddress = (baseAddress | oneMask) & zeroMask
      for _, offset in ipairs(getOffsets(floatingMask)) do
        memory[baseAddress + offset] = value
      end
    end
  end

  local sum = 0
  for _, v in pairs(memory) do sum = sum + v end
  print(math.floor(sum))
end

solve2("input3")
solve2("input2")