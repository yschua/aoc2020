util = {}

function util.xor(a, b)
  return not a ~= not b
end

function util.mod(a ,b)
  return math.floor((a - 1) % b + 1)
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

local function gcd( m, n )
  while n ~= 0 do
      local q = m
      m = n
      n = q % n
  end
  return m
end

local function lcm( m, n )
  return ( m ~= 0 and n ~= 0 ) and m * n / gcd( m, n ) or 0
end

function util.lcm(tab)
  local n = lcm(tab[1], tab[2])
  if #tab > 2 then
    for i = 3, #tab do n = lcm(n, tab[i]) end
  end
  return n
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

function table.fromstring(str)
  local tab = {}
  for i = 1, #str do table.insert(tab, str:sub(i, i)) end
  return tab
end

function table.tostring(tab)
  local str = ""
  for i = 1, #tab do str = str..tab[i] end
  return str
end