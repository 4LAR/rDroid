
function read(filename)
  local file = fs.open(filename, "r")
  if not file then
      print("Error reading: " .. filename)
  end

  local content = file.readAll()
  file.close()

  local data = textutils.unserialiseJSON(content)
  return data
end

--------------------------------------------------------------------------------

return {
  read = read
}
