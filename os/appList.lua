package.path = package.path .. ';/libs/?.lua'
local basalt = require("basalt")
-- local json = require("json")

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

local appsDirectory = "/apps/"
local main = nil
local appsFrame = nil
local appsTable = {}
local appFrame = nil
local exitLabel = nil

--------------------------------------------------------------------------------

local function closeApp()
  appFrame:remove()
  appFrame = nil
  exitLabel:hide()
end

local function openApp(name)

  -- basalt.debug(appsDirectory .. name)
  appFrame = main:addFrame()
    :setSize("parent.w", "parent.h - 1")
    -- :setSize("parent.w", "parent.h - 2")
    :setPosition(1, 2)

  appFrame:addProgram()
    :setSize("parent.w", "parent.h")
    :execute(appsDirectory .. name .. "/main.lua")

  exitLabel:show()
end

--------------------------------------------------------------------------------

local function listApps()
  local FileList = fs.list(appsDirectory)
  for i, file in ipairs(FileList) do
    table.insert(appsTable, appsFrame:addFrame()
      :setSize("parent.w", 4)
      :setPosition(1, (i - 1) * 5 + 2)
      :setBackground(colors.white)
      :onClick(
        function()
          openApp(file)
          -- basalt.debug("OPEN")
        end
      )
    )

    -- local appInfoJson = json.read(appsDirectory .. file .. "/info.json")
    local appInfoJson = read(appsDirectory .. file .. "/info.json")

    appsTable[i]:addPane()
      :setSize(6, 4)
      :setPosition(2, 1)
      :setBackground(colors.blue, "#")

    appsTable[i]:addLabel()
      :setText(appInfoJson["title"])
      :setFontSize(1)
      :setForeground(colors.black)
      :setPosition(9, 2)

    appsTable[i]:addLabel()
      :setText(appInfoJson["info"])
      :setFontSize(1)
      :setForeground(colors.lightGray)
      :setPosition(9, 3)

  end
end

--------------------------------------------------------------------------------

function create(global_main)
  main = global_main

  appsFrame = main
    :addFrame()
    :setScrollable()
    :setSize("parent.w", "parent.h - 1")
    -- :setSize("parent.w", "parent.h - 2")
    :setPosition(1, 2)
    :setBackground(colors.white)

  exitLabel = main
    :addLabel()
    :setText("x")
    :setFontSize(1)
    :setTextAlign("center")
    :setForeground(colors.red)
    :setPosition("parent.w", 1)
    :hide()
    :onClick(
      function()
        closeApp()
      end)

  listApps()
end

--------------------------------------------------------------------------------

return {
  create = create
}
