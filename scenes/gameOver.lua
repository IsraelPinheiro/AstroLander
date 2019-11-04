local composer = require( "composer" )
 
local scene = composer.newScene()
composer.recycleOnSceneChange = true

-- Activate Multitouch
system.activate( "multitouch" )


-- Load Music
local bgMusic = audio.loadSound("assets/sounds/music/Lockdown.mp3")

-- UI Elements
local UIDefaultFont = "assets/fonts/ConsoleClassic.ttf"
local background

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
 
-- create()
function scene:create( event )
    local sceneGroup = self.view
    
    -- Background Image
    background = display.newImage("assets/img/ui/background.png")
    background.x, background.y = centerX, centerY
    background.width, background.height = screenWidth*1.5, screenHeight*1.5

    -- Game Over
    GameOverText = display.newText("Game Over", centerX, centerY, UIDefaultFont, 150 )
    GameOverText.anchorX, GameOverText.anchorY = 0.5,0

    -- Game Score
    GameScore = display.newText(lastScore.." Points", centerX, centerY+100, UIDefaultFont, 150 )
    GameScore.anchorX, GameScore.anchorY = 0.5,0
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