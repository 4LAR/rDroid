
function exec(code)
  return assert(loadstring("return " .. code))()
end

function getChar(str, index)
  if index < 1 or index > #str then
    return nil
  end
  return string.sub(str, index, index)
end

function hexToColor(hex)
  hex = hex:gsub("#", "")

  local r = tonumber(hex:sub(1, 2), 16)
  local g = tonumber(hex:sub(3, 4), 16)
  local b = tonumber(hex:sub(5, 6), 16)

  return math.floor(r / 16) * 4 + math.floor(g / 16) * 2 + math.floor(b / 16)
end

colors_dict = {
  ["w"] = colors.white,
  ["r"] = colors.red,
  ["g"] = colors.green,
  ["b"] = colors.blue,
  ["y"] = colors.yellow,
  ["o"] = colors.orange,
  ["p"] = colors.purple,
  ["k"] = colors.black,
  ["br"] = colors.brown,
  ["c"] = colors.cyan,
  ["m"] = colors.magenta,
  ["lg"] = colors.lightGray,
  ["dg"] = colors.darkGray
}

return {
  exec = exec,
  getChar = getChar,
  hexToColor = hexToColor,
  colors_dict = colors_dict
}
