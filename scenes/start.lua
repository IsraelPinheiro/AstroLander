local composer = require( "composer" )
local scene = composer.newScene()
composer.recycleOnSceneChange = true

--UI Elements
local bgMusic
local background
local logo
local buttonStart

-- Event functions
local function start(event)
    if ( event.phase == "ended" ) then
        composer.gotoScene("scenes.planets", { params={} })
    end
end

local function shakeListener( event )
    if (event.isShake) then
        if (logo.frame == 3) then
            logo:setFrame(1)
        else
            logo:setFrame(logo.frame+1)
        end
    end
end
 
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )
    local sceneGroup = self.view

    -- Load Music
    bgMusic = audio.loadSound("assets/sounds/music/Close Your Eyes.mp3")
    
    -- Background Image
    background = display.newImage("assets/img/ui/background.png")
    background.x, background.y = centerX, centerY
    background.width, background.height = screenWidth*2, screenHeight*2

    -- Start Screen Logo
    logo = display.newSprite(logos, {start=1, count=3 })
    logo:setFrame(math.random(1,logo.numFrames))
    logo.alpha = 0
    logo.x, logo.y = centerX, logo.height/2 + 140
    transition.to(logo, { alpha=1, time = 4000, delay=500})

    -- Start Button
    buttonStart = display.newImage("assets/img/ui/start.png")
    buttonStart.anchorX, buttonStart.anchorY = 0.5, 1
    buttonStart.x, buttonStart.y = centerX, screenHeight - 100
    buttonStart.alpha = 0
    transition.to(buttonStart, { alpha=1, time = 4000, delay=1500})
    buttonStart:addEventListener( "touch", start)

    -- Shake Listener
    Runtime:addEventListener( "accelerometer", shakeListener )
    
end

-- show()
function scene:show( event )
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        audio.play(bgMusic, {channel = 1, fadein = 1000, loops = -1})
 
    elseif ( phase == "did" ) then
 
    end
end

-- hide()
function scene:hide( event )
    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then

    elseif ( phase == "did" ) then
        audio.stop(1)
    end
end

-- destroy()
function scene:destroy( event )
    local sceneGroup = self.view

end

-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------

return scene