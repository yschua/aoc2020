require("util")

local function solve(filename)
  local passports = {}
  local passport = {}

  for line in io.lines(filename) do
    if line == "" then
      table.insert(passports, passport)
      passport = {}
    end

    for field in string.gmatch(line, "%a+:%S+") do
      local key, value = string.match(field, "(%a+):(%S+)")
      passport[key] = value
    end
  end

  if next(passport) then table.insert(passports, passport) end

  local function validate(passport)
    -- return true

    local function validateDigit(n, min, max)
      n = tonumber(n)
      if not n then return false end
      return n >= min and n <= max
    end

    if not validateDigit(passport.byr, 1920, 2002) then return false end
    if not validateDigit(passport.iyr, 2010, 2020) then return false end
    if not validateDigit(passport.eyr, 2020, 2030) then return false end

    local height, unit = string.match(passport.hgt, "(%d+)(%a+)")
    if unit == "cm" then
      if not validateDigit(height, 150, 193) then return false end
    elseif unit == "in" then
      if not validateDigit(height, 59, 76) then return false end
    else
      return false
    end

    if string.len(passport.hcl) ~= 7 or not string.find(passport.hcl, "#%x%x%x%x%x%x") then
      return false
    end

    local validColors = {"amb", "blu", "brn", "gry", "grn", "hzl", "oth"}
    if not util.contains(validColors, passport.ecl) then return false end

    if string.len(passport.pid) ~= 9 or not string.find(passport.pid, "%d%d%d%d%d%d%d%d%d") then
      return false
    end

    return true
  end

  local numValid = 0

  for _, passport in ipairs(passports) do
    local isValid = false
    local numFields = util.size(passport)
    if numFields == 8 then
      isValid = validate(passport)
    elseif numFields == 7 and passport.cid == nil then
      isValid = validate(passport)
    end
    if isValid then numValid = numValid + 1 end
  end

  print(numValid)
end

solve("input1")
solve("input2")