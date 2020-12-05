require("util")

local function solve(filename)
  local numValid1, numValid2 = 0, 0
  for line in io.lines(filename) do
    local min, max, letter, pass = string.match(line, "(%d+)-(%d+) (%a): (%a+)")
    min, max = tonumber(min), tonumber(max)
    local count = 0

    for c in string.gmatch(pass, ".") do
      if c == letter then
        count = count + 1
      end
      if count > max then break end
    end

    if count >= min and count <= max then
      numValid1 = numValid1 + 1
    end

    if util.xor(string.sub(pass, min, min) == letter, string.sub(pass, max, max) == letter) then
      numValid2 = numValid2 + 1
    end
  end

  print(numValid1)
  print(numValid2)
end

solve("input1")
solve("input2")