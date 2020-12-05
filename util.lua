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