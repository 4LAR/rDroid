package.path = package.path .. ';/libs/?.lua'
local basalt = require("basalt")
local json = require("json")
local utils = require("utils")

--------------------------------------------------------------------------------

local appsDirectory = "/apps/"
local main = nil
local appsFrame = nil
local appsTable = {}
local appFrame = nil
local exitLabel = nil

--------------------------------------------------------------------------------

-- colors.fromBlit("e")

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

    local appInfoJson = json.read(appsDirectory .. file .. "/info.json")
    if (appInfoJson["icon"] == nil) then
      appsTable[i]:addPane()
        :setSize(6, 4)
        :setPosition(2, 1)
        :setBackground(colors.blue, "#")
    else
      for row = 1, 4 do
        for col = 1, 6 do
          local insertStr = appInfoJson["icon"][row][col]
          if (
            (string.len(insertStr) > 1)
            and (string.sub(insertStr, 1, 1) == "\\")
          ) then
            insertStr = string.char(tonumber(string.sub(insertStr, 2, string.len(insertStr))))
          end
          appsTable[i]:addLabel()
            :setPosition(2 + (col - 1), 1 + (row - 1))
            :setFontSize(1)
            :setText(insertStr)
            :setBackground(utils.colors_dict[appInfoJson["icon_bg_color"][row][col]])
            :setForeground(utils.colors_dict[appInfoJson["icon_fg_color"][row][col]])
        end
      end
    end

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
    :setText("\215")
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
