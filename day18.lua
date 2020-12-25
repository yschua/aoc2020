require("util")

local function solve(filename, addFirst)
  local expr = {}

  local function evaluate(from, to)
    if to == nil then
      -- return single number
      if type(expr[from]) == "number" then
        return expr[from], from + 1
      end
      -- return evaluated parenthesis expression
      if expr[from] == "(" then
        local excess = 1
        for i = from + 1, #expr do
          if expr[i] == ")" then
            excess = excess - 1
          elseif expr[i] == "(" then
            excess = excess + 1
          end
          if excess == 0 then
            return evaluate(from + 1, i - 1), i + 1
          end
        end
      end
    end

    if not addFirst then
      ---------------------------------------------------------
      -- part 1 evaluation
      local n, i = evaluate(from)
      while i <= to do
        local op = expr[i]
        local eval
        eval, i = evaluate(i + 1)
        if op == "+" then
          n = n + eval
        elseif op == "*" then
          n = n * eval
        end
      end
      return n, to + 1
    else
      ---------------------------------------------------------
      -- part 2 evaluation
      local multList = {}
      local n, i = evaluate(from)
      while i <= to do
        local op = expr[i]
        local eval
        eval, i = evaluate(i + 1)
        if op == "+" then
          n = n + eval
        elseif op == "*" then
          table.insert(multList, n)
          n = eval
        end
      end
      table.insert(multList, n)
      n = 1
      for _, v in ipairs(multList) do n = n * v end
      return n, to + 1
    end
  end

  local sum = 0
  for line in io.lines(filename) do
    ---------------------------------------------------------
    -- parse input
    expr = {}
    while #line > 0 do
      local n = line:match("^%d+")
      if n then
        table.insert(expr, tonumber(n))
        line = line:gsub("^%d+%s?", "")
      else
        local p = line:match("^%p")
        table.insert(expr, p)
        line = line:gsub("^%p%s?", "")
      end
    end

    ---------------------------------------------------------
    -- evaluate expression
    local eval = evaluate(1, #expr)
    -- print(eval)
    sum = sum + eval
  end
  print(sum)
end

-- solve("input1")
solve("input2", false)
-- solve("input1", true)
solve("input2", true)