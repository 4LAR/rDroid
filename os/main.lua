package.path = package.path .. ';/libs/?.lua'
local basalt = require("basalt")
local readJson = require("json")
local topFrame = require("topFrame")
-- local controlButtons = require("controlButtons")
local appList = require("appList")

--------------------------------------------------------------------------------

local main = basalt.createFrame()

topFrame.create(main)
-- controlButtons.create(main)
appList.create(main)

basalt.autoUpdate()
