package.path = package.path .. ';/libs/basalt.lua'
local basalt = require("basalt")

--------------------------------------------------------------------------------

local main = basalt.createFrame()

local fileListFrame = nil
local pathLabel = nil
local filesTable = {}

local path = "/"

--------------------------------------------------------------------------------

local function backFolder()
  local finalPath = ""
  local dir = ""
  local pushFlag = false
  for c in path:gmatch(".") do
    if (pushFlag) then
      finalPath = finalPath .. dir
      dir = ""
      pushFlag = false
    end
    dir = dir .. c
    if (c == "/") then
      pushFlag = true
    end
  end
  path = finalPath
end

local function openFolder(dir)
  filesTable = {}
  path = dir
  topLabel:setText("root:" .. dir)

  if (fileListFrame ~= nil) then
    fileListFrame:remove()
  end

  fileListFrame = main
    :addFrame()
    :setScrollable()
    :setSize("parent.w", "parent.h - 2")
    :setPosition(1, 2)
    :setBackground(colors.white)
    :setForeground(colors.black)

  local backButtonFlag = 0
  -- if (path ~= "/") then
  --   backButtonFlag = 1
  --   fileListFrame:addLabel()
  --     :setPosition(1, 1)
  --     :setText("...")
  --     :onClick(
  --       function()
  --         backFolder()
  --         openFolder(path)
  --       end
  --     )
  -- end

  -- local w, h = term.getSize()
  local FileList = fs.list(dir)
  for i, file in ipairs(FileList) do
    local typeIndex = 0
    if (fs.isDir(dir .. file)) then
      typeIndex = 0
    else
      typeIndex = 1
    end
      table.insert(filesTable,
        fileListFrame:addFrame()
          :setSize("parent.w", 3)
          :setBackground(colors.white)
          :setPosition(1, (i - 1) * 3 + 1)
          :onClick(
            function()
              if (typeIndex == 0) then
                openFolder(path .. file .. "/")
              end
            end)
      )

      filesTable[i]:addLabel()
        :setPosition(5, 1)
        :setText(file)
        :setFontSize(1)
        :setBackground(colors.white)
        :setForeground(colors.black)

      filesTable[i]:addLabel()
        :setPosition(5, 2)
        :setText(file)
        :setFontSize(1)
        :setBackground(colors.white)
        :setForeground(colors.gray)

      filesTable[i]:addPane()
        :setSize("parent.w", 1)
        :setPosition(1, 3)
        :setBackground(colors.white, "-", colors.lightGray)

      if (typeIndex == 0) then
        filesTable[i]:addLabel()
          :setPosition(2, 1)
          :setSize(2, 2)
          -- :setText("\136\142\n\130\131")
          :setText(" \144\n\143\133")
          -- :setText("\141\142\n\143\143")
          :setForeground(colors.yellow)
      else
        filesTable[i]:addLabel()
          :setPosition(2, 1)
          :setSize(2, 2)
          -- :setText("\136\142\n\130\131")
          :setText(" \144\n\143\133")
          :setForeground(colors.blue)
      end




    -- fileListFrame:addLabel()
    --   :setPosition(1, backButtonFlag + i)
    --   :setText("[" .. typeStr .. "] " .. file)
    --   :onClick(
    --     function()
    --       if (typeStr == "dir ") then
    --         openFolder(path .. file .. "/")
    --       end
    --     end)
  end
end

topLabel = main
  :addLabel()
  :setText("")
  :setFontSize(1)
  :setTextAlign("left")
  :setForeground(colors.black)
  :setPosition(1, 1)

openFolder(path)

--------------------------------------------------------------------------------

basalt.autoUpdate()
