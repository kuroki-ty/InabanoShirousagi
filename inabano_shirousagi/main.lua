-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here
local stage = display.getCurrentStage() --画面を取得
displaySizeX = stage.contentWidth
displaySizeY = stage.contentHeight

display.setDefault("background", 84, 156, 221)

print(displaySizeX,displaySizeY)
local storyboard = require("storyboard")--画面遷移
storyboard.gotoScene("menu");--画面遷移をする関数