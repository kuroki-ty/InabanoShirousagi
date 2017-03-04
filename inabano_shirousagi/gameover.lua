-----------------------------------------------------------------------------------------
--
-- menu.lua
--
-----------------------------------------------------------------------------------------
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
display.setStatusBar(display.HiddenStatusBar)

local function gotoGame( event )
	if event.phase == "began" then--押された瞬間的な
		--print("test")
		storyboard.gotoScene( "game", "zoomInOut", 400)--２引数に画面遷移の仕方をかける、どのぐらいの速さ
		--time = 10
		--count = 0
		--storyboard.gotoScene("game")
		
		return true
	end
end


function scene:createScene( event )
	local screenGroup = self.view

	gameend = display.newText("(゜Д゜)ウマー",displaySizeX/11,displaySizeY/4,nil,displaySizeX/8)
	screenGroup:insert(gameend)

	gameover = display.newImage("gameover.png")
	gameover.x = 200
	gameover.y = 200
	screenGroup:insert(gameover)

	restart = display.newText("もう１回",displaySizeX/2,displaySizeY/3*2,nil,displaySizeX/10)
	restart.x = restart.x - restart.width /2
	restart:setTextColor(255,0,0)	
	--start.touch = gotoGame
	restart:addEventListener( "touch", gotoGame )--イベント名、関数名
	screenGroup:insert(restart)


-- Called when the scene's view does not exist:

	print( "menu: createScene event")
end


-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	print( "menu: enterScene event" )
	storyboard.purgeScene(storyboard.getPrevious())
	print( "menu: enterScene event" )
end


-- Called when scene is about to move offscreen:
function scene:exitScene( event )
	print( "menu: exitScene event" )
	-- remove touch listener for image
end


-- Called prior to the removal of scene's "view" (display group)
function scene:destroyScene( event )
	print( "menu destroy" )
end
-- "createScene" event is dispatched if scene's view does not exist
scene:addEventListener( "createScene", scene )

-- "enterScene" event is dispatched whenever scene transition has finished
scene:addEventListener( "enterScene", scene )

-- "exitScene" event is dispatched before next scene's transition begins
scene:addEventListener( "exitScene", scene )

-- "destroyScene" event is dispatched before view is unloaded, which can be
-- automatically unloaded in low memory situations, or explicitly via a call to
-- storyboard.purgeScene() or storyboard.removeScene().
scene:addEventListener( "destroyScene", scene )
return scene