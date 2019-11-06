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
local buttonTryAgain
local buttonBackStart


-- Event Functions
local function tryAgain(event)
    if ( event.phase == "began" ) then
        
        
    end
    if ( event.phase == "ended" ) then
        
        
    end
end
local function backStart(event)
    if ( event.phase == "began" ) then
        
        
    end
    if ( event.phase == "ended" ) then
        
        
    end
end

-- Keyboard controls handler
local function onKeyEvent( event )
    if (system.getInfo( "platform" ) == "win32" or system.getInfo( "platform" ) == "macos" ) then

    end

    if(event.keyName == "space" or event.keyName == "buttonA" or event.keyName == "buttonStart") then
        if ( event.phase == "down" ) then
            audio.play(sfx_back)
            composer.gotoScene("scenes.game")
        end
    end

    if(event.keyName == "escape" or event.keyName == "buttonB" or event.keyName == "buttonSelect") then
        if ( event.phase == "down" ) then
            audio.play(sfx_back)
            composer.gotoScene("scenes.start")
        end
    end
 
    -- If the "back" key was pressed on Android, prevent it from backing out of the app
    if (event.keyName == "back") then
        if (system.getInfo("platform") == "android" ) then
            return true
        end
    end

    return false
end

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

    -- Text
    if(lastScore>0) then
        GameOverText = display.newText("You Landed!", centerX, centerY, UIDefaultFont, 150 )
    else
        GameOverText = display.newText("Game Over", centerX, centerY, UIDefaultFont, 150 )
    end
    GameOverText.anchorX, GameOverText.anchorY = 0.5,0.5

    -- Game Score
    GameScore = display.newText(lastScore.." Points", centerX, centerY+100, UIDefaultFont, 150 )
    GameScore.anchorX, GameScore.anchorY = 0.5,0

    -- Try Again Button
    buttonTryAgain = display.newImage("assets/img/ui/tryAgain.png")
    buttonTryAgain.anchorX, buttonTryAgain.anchorY = 0, 1
    buttonTryAgain.x, buttonTryAgain.y = 0, screenHeight
    buttonTryAgain:addEventListener("touch", tryAgain)

    -- Back to Start Button
    buttonBackStart = display.newImage("assets/img/ui/backStart.png")
    buttonBackStart.anchorX, buttonBackStart.anchorY = 0, 1
    buttonBackStart.x, buttonBackStart.y = screenWidth/2, screenHeight
    buttonBackStart:addEventListener("touch", backStart)

    -- Keyboard Listener
    Runtime:addEventListener("key", onKeyEvent)
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
        audio.stop()
        -- Remove Event Listeners
        buttonTryAgain:removeEventListener("touch", tryAgain)
        buttonBackStart:removeEventListener("touch", backStart)
        Runtime:removeEventListener("key", onKeyEvent)

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