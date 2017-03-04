-----------------------------------------------------------------------------------------
--
-- menu.lua
--
-----------------------------------------------------------------------------------------
local storyboard = require( "storyboard" )--画面遷移するとき使う
local scene = storyboard.newScene()--画面遷移するとき使う（一番最後にreturnつける）
display.setStatusBar(display.HiddenStatusBar)

local start, title

local function startAnimation(event)
	--print(start.alpha)
	if(start.alpha == 0)then
		start.alpha = 1
	else
		if start.alpha < 0.04 then
			start.alpha = 0
		else
			start.alpha = start.alpha - 0.04
		end
	end
end
local function gotoGame( event )
	if event.phase == "began" then--押された瞬間的な
		--print("test")
		storyboard.gotoScene( "game", "zoomInOut", 400)--２引数に画面遷移の仕方をかける、どのぐらいの速さ
		--storyboard.gotoScene("game")
		return true
	end
end

function scene:createScene( event )--初期設定する
	local screenGroup = self.view

	usagiomote = display.newImage("usagi_omote.png")
	usagiomote.x = displaySizeX / 2
	usagiomote.y = displaySizeY / 2
	usagiomote:scale(0.5,0.5)
	screenGroup:insert(usagiomote)
	--title
	title = display.newText("因幡の白兎",displaySizeX/2,displaySizeY/4,nil,displaySizeX/8)--表示文字列、x座標、y座標、フォント、フォントサイズ
	title.x = title.x - title.width /2
	title:setTextColor(255,255,255)
	screenGroup:insert(title)

	--touch to start
	start = display.newText("touch to start",displaySizeX/2,displaySizeY/3*2,nil,displaySizeX/10)
	start.x = start.x - start.width /2
	start:setTextColor(255,0,0)	
	--start.touch = gotoGame
	start:addEventListener( "touch", gotoGame )--イベント名、関数名
	screenGroup:insert(start)

	



-- Called when the scene's view does not exist:

	print( "menu: createScene event")
end


-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )--時間系のイベントリスナーつける
	storyboard.purgeScene(storyboard.getPrevious())
	Runtime:addEventListener("enterFrame",startAnimation)
	print( "menu: enterScene event" )
end


-- Called when scene is about to move offscreen:
function scene:exitScene( event )
	print( "menu: exitScene event" )
	-- remove touch listener for image
	Runtime:removeEventListener("enterFrame",startAnimation)
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