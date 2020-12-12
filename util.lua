util = {}

function util.xor(a, b)
  return not a ~= not b
end

function util.mod(a ,b)
  return (a - 1) % b + 1
end

function util.size(tab)
  local n = 0
  for v in pairs(tab) do n = n + 1 end
  return n
end

function util.contains(tab, value)
  for _, v in ipairs(tab) do
    if v == value then return true end
  end
  return false
end

function string:split(delimiter)
  local result = {}
  local from  = 1
  local delim_from, delim_to = string.find(self, delimiter, from)
  while delim_from do
    table.insert(result, string.sub(self, from , delim_from - 1))
    from  = delim_to + 1
    delim_from, delim_to = string.find(self, delimiter, from)
  end
  table.insert(result, string.sub(self, from))
  return result
end

function string:trim()
  return self:gsub("^%s*(.-)%s*$", "%1")
end