local composer = require( "composer" )
local scene = composer.newScene()
composer.recycleOnSceneChange = true

-- SFX
local bgMusic
local sfx_select

--UI Elements
local background
local logo
local buttonStart

-- Event functions
local function start(event)
    if ( event.phase == "ended" ) then
        audio.play(sfx_select)
        composer.gotoScene("scenes.planets", { params={} })
    end
end

local function changeLogo( event )
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

    --Load SFX
    sfx_select = audio.loadSound("assets/sounds/sfx/select.wav")
    
    -- Background Image
    background = display.newImage("assets/img/ui/background.png")
    background.x, background.y = centerX, centerY
    background.width, background.height = screenWidth*1.5, screenHeight*1.5

    -- Start Screen Logo
    logo = display.newSprite(logos, {start=1, count=3 })
    logo:setFrame(math.random(1,logo.numFrames))
    logo.alpha = 0
    logo.x, logo.y = centerX, logo.height/2 + 165
    transition.to(logo, { alpha=1, time = 4000, delay=500})

    -- Start Button
    buttonStart = display.newImage("assets/img/ui/start.png")
    buttonStart.anchorX, buttonStart.anchorY = 0.5, 1
    buttonStart.x, buttonStart.y = centerX, screenHeight - 50
    buttonStart.alpha = 0
    transition.to(buttonStart, { alpha=1, time = 4000, delay=1500})
    buttonStart:addEventListener( "touch", start)

    -- Shake Listener
    Runtime:addEventListener( "accelerometer", changeLogo )
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
        audio.stop(1)

        buttonStart:removeEventListener( "touch", start)
        Runtime:removeEventListener( "accelerometer", changeLogo )

        display.remove(background)
        display.remove(logo)
        display.remove(buttonStart)
    elseif ( phase == "did" ) then

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