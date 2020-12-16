require("util")

local function solve(filename)
  ---------------------------------------------------------
  -- parse input
  local code = {}
  for line in io.lines(filename) do
    local codeLine = {}
    codeLine.instruction, codeLine.argument = line:match("(%a+) (%p%d+)")
    codeLine.argument = tonumber(codeLine.argument)
    table.insert(code, codeLine)
  end

  ---------------------------------------------------------
  -- part 1
  local function execute(changeIdx)
    local acc = 0
    local i = 1
    local visited = {}
    while not visited[i] and i <= #code do
      visited[i] = true
      local instruction = code[i].instruction
      local argument = code[i].argument
      if changeIdx == i then
        if instruction == "jmp" then
          instruction = "nop"
        elseif instruction == "nop" then
          instruction = "jmp"
        end
      end
      if instruction == "acc" then
        acc = acc + argument
        i = i + 1
      elseif instruction == "jmp" then
        i = i + argument
      elseif instruction == "nop" then
        i = i + 1
      end
    end
    return acc, (i > #code)
  end

  print(execute())

  ---------------------------------------------------------
  -- part 2
  for i = 1, #code do
    if code[i].instruction ~= "acc" then
      local acc, terminated = execute(i)
      if terminated then
        print(acc)
        return
      end
    end
  end
end

solve("input1")
solve("input2")