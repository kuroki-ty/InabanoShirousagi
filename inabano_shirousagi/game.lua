-----------------------------------------------------------------------------------------
--
-- menu.lua
--
-----------------------------------------------------------------------------------------
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
display.setStatusBar(display.HiddenStatusBar)

count = 0
time  = 10
--point = 0

gyou = {}
retu = {}
sameposi = {}

board = {}
for i = 0,3,1 do
	board[i] = {}
end

for k = 0,3,1 do
	gyou[k]={}
	retu[k]={}
	sameposi[k]={}
end

local function makeKameSame()

	--サメとカメを並べるところ
	--配列の準備
	
	--配置する位置
	for i = 0,3,1 do
		sametmp = math.random(0,3)
		sameposi[i] = sametmp
		for j = 0,3,1 do
			gyou[i] = (displaySizeY / 4) * i
			retu[j] = (displaySizeX / 4) * j
			if(sametmp ~= j)then
				board[i][j] = display.newImage("kame.png")
				board[i][j].x = retu[j] + (board[i][j].width / 2)
				board[i][j].y = gyou[i] + (board[i][j].height / 2)
			else 
				board[i][j] = display.newImage("same.png")
				board[i][j].x = retu[sametmp] + (board[i][j].width / 2)
				board[i][j].y =  gyou[i] + (board[i][j].height / 2)
			end
		end
	end

	--うさぎの位置
	usagi = display.newImage("usagi.png")
	usagi:scale(0.8,0.8)
	usagi.x = retu[sameposi[3]] + 40
	usagi.y = gyou[3] + 60

	
end

--ゲームオーバーかどうかのチェック
local function checkGame(time)
	if(time == 0)then 
		for i = 0,3,1 do
			for j = 0,3,1 do
				board[i][j]:removeSelf()
				print(board[i][j])
			end
		end
		usagi:removeSelf()
		storyboard.gotoScene( "goal", "zoomInOut", 400)
	end		
end

--[[local function timeOut()
	time = 0
	checkGame(time)
end]]

--タッチした位置の取得
local function move(event)
	if(event.phase == "began")then
		touchX = event.x
		touchY = event.y
		--上から３番目の行が押された時の処理
		if(touchY > gyou[2] and touchY < gyou[3] and touchX > retu[sameposi[2]] and touchX < retu[sameposi[2]] + 80)then
				--点数
				point = point + 1
				pointLabel.text = point
			
				--サメポジションを下にずらす
				for i = 3,1,-1 do
					sameposi[i] = sameposi[i-1]
				end

				--サメ生成
				sametmp = math.random(0,3)
				sameposi[0] = sametmp

				for i = 0,3,1 do
					for j = 0,3,1 do
						board[i][j]:removeSelf()
						if(sameposi[i] ~= j)then
							board[i][j] = display.newImage("kame.png")
							board[i][j].x = retu[j] + (board[i][j].width / 2)
							board[i][j].y = gyou[i] + (board[i][j].height / 2)
						else 
							board[i][j] = display.newImage("same.png")
							board[i][j].x = retu[sameposi[i]] + (board[i][j].width / 2)
							board[i][j].y =  gyou[i] + (board[i][j].height / 2)
						end
					end
				end
				usagi:removeSelf()
				usagi = display.newImage("usagi.png")
				usagi:scale(0.8,0.8)
				usagi.x = retu[sameposi[3]] + 40
				usagi.y = gyou[3] + 60
		--[[else
			timeOut()]]
		end
	end
end





function scene:createScene( event )
	local screenGroup = self.view

	haikei = display.newImage("haikei.png")
	haikei.x = displaySizeX / 2
	haikei.y = displaySizeY / 2
	screenGroup:insert(haikei)


	time = 10
	point = 0
	--タッチした位置の取得
	local stage = display.getCurrentStage() 
	stage:addEventListener("touch",move);

	--点数の表示
	pointLabel = display.newText("0",(displaySizeX / 4) + 150,(displaySizeY / 4) - 20,nil,displaySizeX/8)--表示文字列、x座標、y座標、フォント、フォントサイズ
	pointLabel.x = pointLabel.x - pointLabel.width /2
	pointLabel:setTextColor(255,255,255)
	screenGroup:insert(pointLabel)



	--時間の表示
	title = display.newText(time,(displaySizeX / 4) + 20,(displaySizeY / 4) - 20,nil,displaySizeX/8)--表示文字列、x座標、y座標、フォント、フォントサイズ
	title.x = title.x - title.width /2
	title:setTextColor(255,255,255)
	screenGroup:insert(title)

	--usagi:addEventListener("touch",jumpUsagi)
	--circle = display.newCircle(retu[3] + (kame.width/2),gyou[2] + (kame.height),30)
	--circle:setFillColor(0,0,0)
	--screenGroup:insert(circle)


-- Called when the scene's view does not exist:

	print( "menu: createScene event")
	makeKameSame()
	
end

local function enterFrameEvent(event)
	count = count + 1
	if(count == 30)then
		time = time - 1
		title.text = time
		count = 0
	end
	checkGame(time)
end


-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	print( "menu: enterScene event" )
	storyboard.purgeScene(storyboard.getPrevious())
	print( "menu: enterScene event" )
	Runtime:addEventListener("enterFrame",enterFrameEvent)
end


-- Called when scene is about to move offscreen:
function scene:exitScene( event )
	print( "menu: exitScene event" )
	Runtime:removeEventListener("enterFrame",enterFrameEvent)
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