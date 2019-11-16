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
        audio.play(sfx_back)
        composer.gotoScene("scenes.game")
    end
end

local function backStart(event)
    if ( event.phase == "began" ) then
        audio.play(sfx_back)
        selectedPlanet = 1
        selectedShip = 1
        composer.gotoScene("scenes.start")
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
            selectedPlanet = 1
            selectedShip = 1
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
    display.setStatusBar(display.HiddenStatusBar)

    -- Audio Message
    if(lastScore>0) then
        audio.play(audio.loadSound("assets/sounds/sfx/eagle_has_landed.mp3"))
    else
        audio.play(audio.loadSound("assets/sounds/sfx/houston_problem.mp3"))
    end
    
    -- Background Image
    background = display.newImage("assets/img/ui/background.png")
    background.x, background.y = centerX, centerY
    background.width, background.height = screenWidth*1.5, screenHeight*1.5

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

    -- Text
    GameOverText = display.newText("", centerX, (screenHeight-buttonBackStart.height)/2, UIDefaultFont, 150 )
    if(lastScore>0) then
        GameOverText.text = "You Landed!"
    else
        GameOverText.text = "Game Over!"
    end
    GameOverText.anchorX, GameOverText.anchorY = 0.5,1

    -- Game Score
    GameScore = display.newText(lastScore.." Points", centerX, GameOverText.y+50, UIDefaultFont, 150 )
    GameScore.anchorX, GameScore.anchorY = 0.5,0

    -- Keyboard Listener
    Runtime:addEventListener("key", onKeyEvent)
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
        audio.stop()
        -- Remove Event Listeners
        buttonTryAgain:removeEventListener("touch", tryAgain)
        buttonBackStart:removeEventListener("touch", backStart)
        Runtime:removeEventListener("key", onKeyEvent)

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