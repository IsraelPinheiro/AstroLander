local composer = require( "composer" )
local scene = composer.newScene()
composer.recycleOnSceneChange = true

-- SFX
local bgMusic
local sfx_buttons
local sfx_select

-- UI Elements
local background
local ship
local buttonLeft
local buttonRight
local buttonLaunch
local buttonBack

-- Event Functions
local function nextShip(event)
    if ( event.phase == "ended" ) then
        audio.play(sfx_buttons)
        if (selectedShip == 3) then
            selectedShip = 1
        else
            selectedShip = selectedShip + 1
        end
        ship:setFrame(selectedShip)
    end
end

local function previousShip(event)
    if ( event.phase == "ended" ) then
        audio.play(sfx_buttons)
        if (selectedShip == 1) then
            selectedShip = 3
        else
            selectedShip = selectedShip - 1
        end
        ship:setFrame(selectedShip)
    end
end

local function launchShip(event)
    if ( event.phase == "ended" ) then
        audio.play(sfx_select)
        composer.gotoScene("scenes.game")
    end
end

local function goBack(event)
    if ( event.phase == "ended" ) then
        composer.gotoScene("scenes.planets")
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

    -- Load SFX
    sfx_buttons = audio.loadSound("assets/sounds/sfx/Beep.wav")
    sfx_select = audio.loadSound("assets/sounds/sfx/Beep.wav")

    -- Background Image
    background = display.newImage("assets/img/ui/background.png")
    background.x, background.y = centerX, centerY
    background.width, background.height = screenWidth*2, screenHeight*2

    -- Ship
    ship = display.newSprite(ships_full, {start=1, count=3 })
    ship.anchorX, ship.anchorY = 0.5, 0
    ship.x, ship.y = centerX, 0

    -- Buttons
    -- Arrow Left
    buttonLeft = display.newImage("assets/img/ui/left.png")
    buttonLeft.anchorX, buttonLeft.anchorY = 0, 0.5 
    buttonLeft.x, buttonLeft.y = 50, centerY
    buttonLeft:addEventListener( "touch", previousShip)

    -- Arrow Right
    buttonRight = display.newImage("assets/img/ui/right.png")
    buttonRight.anchorX, buttonRight.anchorY = 1, 0.5
    buttonRight.x, buttonRight.y = screenWidth-50, centerY
    buttonRight:addEventListener( "touch", nextShip)

    -- Back
    buttonBack = display.newImage("assets/img/ui/back.png")
    buttonBack.anchorX, buttonBack.anchorY = 0, 0
    buttonBack.x, buttonBack.y = 30, 30
    buttonBack:addEventListener( "touch", goBack)

    -- Launch
    buttonLaunch = display.newImage("assets/img/ui/launch.png")
    buttonLaunch.anchorX, buttonLaunch.anchorY = 0.5, 1
    buttonLaunch.x, buttonLaunch.y = centerX, screenHeight - 50
    buttonLaunch:addEventListener( "touch", launchShip)

end

-- show()
function scene:show( event )
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        audio.play(bgMusic, {channel = 1, fadein = 1000, loops = -1})
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
        audio.stop(1)
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