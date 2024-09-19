local basalt = require("basalt")

local topLabel = nil
local topLabelBg = nil
local timeTimer = nil

--------------------------------------------------------------------------------

local function updateTime()
  local time = os.time()
  local formattedTime = textutils.formatTime(time, false)
  topLabel:setText(formattedTime)
  timeTimer:start()
end

--------------------------------------------------------------------------------

function create(main)
  topLabelBg = main
    :addPane()
    :setSize("parent.w", 1)
    :setPosition(1, 1)
    :setBackground(colors.gray)

  topLabel = main
    :addLabel()
    :setText("14:88")
    :setFontSize(1)
    :setTextAlign("center")
    :setForeground(colors.white)
    -- :setBackground(colors.black)

  timeTimer = main:addTimer()
  timeTimer:setTime(0.2)

  timeTimer:onCall(updateTime)
  timeTimer:start()
  updateTime()
end

--------------------------------------------------------------------------------

return {
  create = create
}
