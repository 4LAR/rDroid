
function read(filename)
  local file = fs.open(filename, "r")
  if not file then
    print("Error reading: " .. filename)
    return {}
  end

  local content = file.readAll()
  file.close()

  local data = textutils.unserialiseJSON(content)
  return data
end

function write(filename, data)
  local file = fs.open(filename, "w")
  if not file then
    print("Error writing: " .. filename)
    return false
  end

  local content = textutils.serialiseJSON(data)
  file.write(content)
  file.close()
  return true
end

--------------------------------------------------------------------------------

return {
  read = read,
  write = write
}
