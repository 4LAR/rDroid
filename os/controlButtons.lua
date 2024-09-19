local basalt = require("basalt")

--------------------------------------------------------------------------------

local main = nil
local bottomLabelBg = nil
local bottomLabel = nil
local backButton = nil
local homeButton = nil
local tasksButton = nil

--------------------------------------------------------------------------------

function create(global_main)
  main = global_main

  local w, h = term.getSize()
  topLabelBg = main
    :addPane()
    :setSize("parent.w", 1)
    :setPosition(1, h)
    :setBackground(colors.lightgray)

  backButton = main:addLabel()
    :setText("\17")
    :setFontSize(1)
    :setForeground(colors.white)
    :setPosition(2, h)

end

--------------------------------------------------------------------------------

return {
  create = create
}
