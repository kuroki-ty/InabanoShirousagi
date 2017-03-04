-----------------------------------------------------------------------------------------
--
-- menu.lua
--
-----------------------------------------------------------------------------------------
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
display.setStatusBar(display.HiddenStatusBar)

local count2 = 0

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

	usagiomote = display.newImage("gameover.png")
	usagiomote.x = displaySizeX / 2
	usagiomote.y = displaySizeY / 2
	usagiomote:scale(0.5,0.5)
	screenGroup:insert(usagiomote)

	s = tostring(point)
	title = display.newText(s.."ぴょん",displaySizeX/2,displaySizeY/4,nil,displaySizeX/8)--表示文字列、x座標、y座標、フォント、フォントサイズ
	title.x = title.x - title.width /2
	title:setTextColor(255,255,255)
	screenGroup:insert(title)

	start = display.newText("もう１回",displaySizeX/2,displaySizeY/3*2,nil,displaySizeX/10)
	start.x = start.x - start.width /2
	start:setTextColor(255,0,0)	
	--start.touch = gotoGame
	start:addEventListener( "touch", gotoGame )--イベント名、関数名
	screenGroup:insert(start)

	--[[title = display.newText("因幡の白兎",displaySizeX/2,displaySizeY/4,nil,displaySizeX/8)--表示文字列、x座標、y座標、フォント、フォントサイズ
	title.x = title.x - title.width /2
	title:setTextColor(255,255,255)
	screenGroup:insert(title)]]


-- Called when the scene's view does not exist:

	print( "menu: createScene event")
end

--[[local function enterEvent(event)
	count2 = count2 + 1
	if(count2 == 15)then
		usagiomote.x = usagiomote.x + 1
	elseif(count2 == 30)then
		usagiomote.x = usagiomote.x - 1
		count2 = 0
end]]



-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	print( "menu: enterScene event" )
	storyboard.purgeScene(storyboard.getPrevious())
	print( "menu: enterScene event" )
	--Runtime:addEventListener("enterFrame",enterEvent)
end


-- Called when scene is about to move offscreen:
function scene:exitScene( event )
	print( "menu: exitScene event" )
	--Runtime:removeEventListener("enterFrame",enterEvent)
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