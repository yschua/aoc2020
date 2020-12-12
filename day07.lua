require("util")

local function solve(filename)
  ---------------------------------------------------------
  -- parse input
  local rules = {}
  for line in io.lines(filename) do
    local parent, children = line:match("(.+) bags contain (.+)")
    rules[parent] = {contain = {}}
    for count, child in children:gmatch("(%d+) (%a+ %a+) bag") do
      rules[parent].contain[child] = count
    end
  end
  
  ---------------------------------------------------------
  -- part 1
  local function searchGold(bag)
    if rules[bag].hasShinyGold ~= nil then
      return rules[bag].hasShinyGold
    end

    if next(rules[bag].contain) == nil then
      rules[bag].hasShinyGold = false
      return false
    end

    for childBag, _ in pairs(rules[bag].contain) do
      if childBag == "shiny gold" then
        rules[bag].hasShinyGold = true
        return true
      end

      if searchGold(childBag) then
        rules[bag].hasShinyGold = true
        return true
      end
    end

    rules[bag].hasShinyGold = false
    return false
  end

  local count = 0
  for bag, _ in pairs(rules) do
    if searchGold(bag) then count = count + 1 end
  end
  print(count)

  ---------------------------------------------------------
  -- part 2
  local function countBags(bag)
    if rules[bag].totalBags ~= nil then
      return rules[bag].totalBags
    end

    if next(rules[bag].contain) == nil then
      rules[bag].totalBags = 0
      return 0
    end

    local totalBags = 0
    for childBag, count in pairs(rules[bag].contain) do
      totalBags = totalBags + count
      totalBags = totalBags + (count * countBags(childBag))
    end
    rules[bag].totalBags = totalBags
    return totalBags
  end

  print(countBags('shiny gold'))
end

solve("input1")
solve("input2")
solve("input3")