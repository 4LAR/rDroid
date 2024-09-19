package.path = package.path .. ';/libs/basalt.lua'
local basalt = require("basalt")

--------------------------------------------------------------------------------

local main = basalt.createFrame()

--------------------------------------------------------------------------------

local terminalFrame = main:addFrame()
  :setSize("parent.w", "parent.h")
  :setPosition(1, 1)

terminalFrame:addProgram()
  :setSize("parent.w", "parent.h")
  :execute("shell.lua")

--------------------------------------------------------------------------------

basalt.autoUpdate()
