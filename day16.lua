require("util")

local function solve1(filename)
  local input = io.open(filename, "r"):read("*a"):trim():split("\n\n")

  local rules = {}
  for a, b, c, d in input[1]:gmatch("%a+: (%d+)%-(%d+) or (%d+)%-(%d+)") do
    table.insert(rules, {tonumber(a), tonumber(b)})
    table.insert(rules, {tonumber(c), tonumber(d)})
  end

  local function valid(n)
    for _, rule in ipairs(rules) do
      if n >= rule[1] and n <= rule[2] then
        return true
      end
    end
    return false
  end

  local error = 0
  for n in input[3]:gmatch("(%d+)") do
    n = tonumber(n)
    if not valid(n) then error = error + n end
  end
  print(error)
end

local function solve2(filename)
  local input = io.open(filename, "r"):read("*a"):trim():split("\n\n")

  local rules = {}
  for name, a, b, c, d in input[1]:gmatch("([%a ]*): (%d+)%-(%d+) or (%d+)%-(%d+)") do
    table.insert(rules, {tonumber(a), tonumber(b), tonumber(c), tonumber(d), name = name})
  end

  local function valid(n, ruleIdx)
    local rule = rules[ruleIdx]
    return (n >= rule[1] and n <= rule[2]) or (n >= rule[3] and n <= rule[4])
  end

  local function validAll(n)
    for i = 1, #rules do
      if valid(n, i) then return true end
    end
    return false
  end

  local validTickets = {}
  local nearbyTickets = input[3]:split("\n")
  for i = 2, #nearbyTickets do
    local ticket = {}
    for n in nearbyTickets[i]:gmatch("(%d+)") do
      n = tonumber(n)
      if not validAll(n) then ticket = nil; break end
      table.insert(ticket, n)
    end
    if ticket then table.insert(validTickets, ticket) end
  end

  local fieldRules = {}
  for _ = 1, #rules do
    local allRuleIdxs = {}
    for i = 1, #rules do table.insert(allRuleIdxs, i) end
    table.insert(fieldRules, allRuleIdxs)
  end

  for _, ticket in ipairs(validTickets) do
    for fieldIdx, value in ipairs(ticket) do
      local ruleIdxs = fieldRules[fieldIdx]
      local i = 1
      while i <= #ruleIdxs do
        local ruleIdx = ruleIdxs[i]
        if not valid(value, ruleIdx) then
          table.removevalue(ruleIdxs, ruleIdx)
        else
          i = i + 1
        end
      end
    end
  end

  local clean = false
  while not clean do
    clean = true
    for _, ruleIdxs in ipairs(fieldRules) do
      if #ruleIdxs == 1 then
        local confirmedRuleIdx = ruleIdxs[1]
        for _, otherRuleIdxs in ipairs(fieldRules) do
          if #otherRuleIdxs > 1 then
            table.removevalue(otherRuleIdxs, confirmedRuleIdx)
          end
        end
      end
      if #ruleIdxs > 1 then clean = false end
    end
  end

  local fieldName = "departure"
  local answer = 1
  local fieldIdx = 1
  for n in input[2]:gmatch("(%d+)") do
    n = tonumber(n)
    local ruleIdx = fieldRules[fieldIdx][1]
    if rules[ruleIdx].name:find(fieldName) then
      answer = answer * n
    end
    fieldIdx = fieldIdx + 1
  end
  print(answer)
end

solve1("input1")
solve2("input2")
-- solve2("input3")