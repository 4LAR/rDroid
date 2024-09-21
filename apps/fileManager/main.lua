package.path = package.path .. ';/libs/basalt.lua'
local basalt = require("basalt")

--------------------------------------------------------------------------------

local main = basalt.createFrame()

local fileListFrame = nil
local pathLabel = nil
local filesTable = {}

local path = "/"

--------------------------------------------------------------------------------

function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

function bytesToSize(bytes)
  local sizes = {"B", "KB", "MB", "GB", "TB"}
  local i = 1
  local size = bytes

  while size >= 1024 and i < #sizes do
    size = size / 1024
    i = i + 1
  end

  return string.format("%.2f %s", size, sizes[i])
end

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

local function getSizeFolder(dir)
  return tablelength(fs.list(dir))
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

      filesTable[i]:addPane()
        :setSize("parent.w", 1)
        :setPosition(1, 3)
        :setBackground(colors.white, "-", colors.lightGray)

      local infoFile = ""
      if (typeIndex == 0) then
          filesTable[i]:addLabel()
            :setPosition(2, 1)
            :setSize(2, 1)
            :setText("\131")
            :setForeground(colors.white)
            :setBackground(colors.yellow)
          filesTable[i]:addLabel()
            :setPosition(2, 2)
            :setSize(2, 1)
            :setText("\131\131")
            :setForeground(colors.yellow)
            :setBackground(colors.white)
        infoFile = getSizeFolder(dir .. "/" .. file) .. " entries"
      else
        filesTable[i]:addLabel()
          :setPosition(2, 1)
          :setSize(2, 1)
          :setText("\129")
          :setForeground(colors.white)
          :setBackground(colors.blue)
        filesTable[i]:addLabel()
          :setPosition(2, 2)
          :setSize(2, 1)
          :setText("\143\143")
          :setForeground(colors.blue)
          :setBackground(colors.white)
        infoFile = bytesToSize(fs.getSize(dir .. "/" .. file))
      end

      filesTable[i]:addLabel()
        :setPosition(5, 2)
        :setText(infoFile)
        :setFontSize(1)
        :setBackground(colors.white)
        :setForeground(colors.gray)

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
