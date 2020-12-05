local function solve(filename)
  local entries = {}
  for entry in io.lines(filename) do
    local n = tonumber(entry)
    if n <= 2020 then table.insert(entries, tonumber(entry)) end
  end

  table.sort(entries)

  local function sum(...)
    local s = 0
    for _, i in ipairs({...}) do s = s + entries[i] end
    return s
  end

  local lower, upper = 1, #entries

  while sum(lower, upper) ~= 2020 do
    if sum(lower, upper - 1) < 2020 then
      lower = lower + 1
    else
      upper = upper - 1
    end
  end

  print(entries[lower] * entries[upper])

  lower, upper = 1, #entries

  while true do
    for i = lower + 1, upper - 1 do
      if sum(lower, i, upper) == 2020 then
        print(entries[lower] * entries[upper] * entries[i])
        return
      end
    end

    if sum(lower, upper - 2, upper - 1) < 2020 then
      lower = lower + 1
    else
      upper = upper - 1
    end
  end
end

solve("input1")
solve("input2")