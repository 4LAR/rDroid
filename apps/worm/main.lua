package.path = package.path .. ';/libs/basalt.lua'
local basalt = require("basalt")

--------------------------------------------------------------------------------

local main = basalt.createFrame()

--------------------------------------------------------------------------------

local wormFrame = main:addFrame()
  :setSize("parent.w", "parent.h")
  :setPosition(1, 1)

wormFrame:addProgram()
  :setSize("parent.w", "parent.h")
  :execute("worm")

--------------------------------------------------------------------------------

basalt.autoUpdate()
