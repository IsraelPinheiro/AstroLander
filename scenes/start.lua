local composer = require( "composer" )

local function start(event)
    if ( event.phase == "ended" ) then
        composer.gotoScene("scenes.planets", { params={} })
    end
end
 
local scene = composer.newScene()
 
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


    -- Code here runs when the scene is first created but has not yet appeared on screen

    -- Load Music
    local menuMusic = audio.loadSound("assets/sounds/music/Close Your Eyes.mp3")
    audio.play(menuMusic, {channel = 1, fadein = 1000, loops = -1})
    -- Background Image
    local background = display.newImage("assets/img/ui/background.png")
    background.x, background.y = centerX, centerY
    background.width, background.height = screenWidth*2, screenHeight*2

    -- Start Screen Logo
    local logo = display.newImage("assets/img/ui/logo.png")
    logo.alpha = 0
    logo.x, logo.y = centerX, logo.height/2 + 130
    transition.to(logo, { alpha=1, time = 4000, delay=500})

    -- Start Button
    local buttonStart = display.newImage("assets/img/ui/start.png")
    buttonStart.anchorX, buttonStart.anchorY = 0.5, 1
    buttonStart.x, buttonStart.y = centerX, screenHeight -50
    buttonStart.alpha = 0
    transition.to(buttonStart, { alpha=1, time = 4000, delay=1500})
    buttonStart:addEventListener( "touch", start)
    
end
 
 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        
        -- Code here runs when the scene is still off screen (but is about to come on screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
 
    end
end
 
-- hide()
function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        audio.stop(1)
        -- Code here runs when the scene is on screen (but is about to go off screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen
 
    end
end
 
 
-- destroy()
function scene:destroy( event )
 
    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view
 
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