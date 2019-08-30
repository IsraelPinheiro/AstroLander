local composer = require( "composer" )
local scene = composer.newScene()
composer.recycleOnSceneChange = true

-- SFX
local gameMusic
local sfx_thrust
local sfx_pause

-- UI Elements
local background

local map

local player

local fuel = 1000
local fuelBar
local fuelBarFill
local fuelIndicator

local altitude
local vSpeed
local hSpeed

local buttonPause
local buttonLeft
local buttonRight
local buttonThrust

-- Event Functions

local function rotateRight(event)
    if ( event.phase == "ended" ) then
       -- TODO:
    end
end
local function rotateLeft(event)
    if ( event.phase == "ended" ) then
       -- TODO:
    end
end
local function thrust(event)
    if ( event.phase == "ended" ) then
       -- TODO:
    end
end

local function pause(event)
    if ( event.phase == "ended" ) then
       -- TODO:
    end
end





-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event ) 
    local sceneGroup = self.view

    -- Load Music
    bgMusic = audio.loadSound("assets/sounds/music/Lockdown.mp3")

    -- Load SFX
    -- TODO: Load SFX

    -- Background Image
    background = display.newImage("assets/img/ui/background.png")
    background.x, background.y = centerX, centerY
    background.width, background.height = screenWidth*1.5, screenHeight*1.5

    --Map
    -- TODO:
    --Fuel Bar
    fuelBar = display.newImage("assets/img/ui/fuelBar.png")
    fuelBar.anchorX, fuelBar.anchorY = 0,0
    --Fuel Bar Fill
    fuelBarFill = display.newImage("assets/img/ui/fuelBarFill.png")
    fuelBarFill.anchorX, fuelBarFill.anchorY = 0,0
    fuelBarFill.width = screenWidth*0.01
    --Fuel Indicator
    fuelIndicator = display.newText( fuel, screenWidth-10, 25, "assets/fonts/ConsoleClassic.ttf", 50 )
    fuelIndicator.anchorX, fuelIndicator.anchorY = 1,0.5
    fuelIndicator:setFillColor(245/255, 134/255, 52/255)

    -- Altitude Indicator
    -- TODO:
    -- Vertical Speed Indicator
    -- TODO:
    -- Horizontal Speed indicator
    -- TODO:

    -- Pause Button
    buttonPause = display.newImage("assets/img/ui/pause.png")
    buttonPause.anchorX, buttonPause.anchorY = 0, 0
    buttonPause.x, buttonPause.y = 30, 80
    buttonPause:addEventListener( "touch", pause)

    -- Arrow Right
    buttonRight = display.newImage("assets/img/ui/right.png")
    buttonRight.anchorX, buttonRight.anchorY = 1, 1
    buttonRight.x, buttonRight.y = screenWidth-30, screenHeight-30
    buttonRight:addEventListener( "touch", rotateRight)

    -- Arrow Left
    buttonLeft = display.newImage("assets/img/ui/left.png")
    buttonLeft.anchorX, buttonLeft.anchorY = 1, 1 
    buttonLeft.x, buttonLeft.y = screenWidth-buttonRight.width-25, screenHeight-30
    buttonLeft:addEventListener( "touch", rotateLeft)

    -- Thrust
    buttonThrust = display.newImage("assets/img/ui/thrust.png")
    buttonThrust.anchorX, buttonThrust.anchorY = 0, 1
    buttonThrust.x, buttonThrust.y = 30, screenHeight - 30
    buttonThrust:addEventListener( "touch", thrust)
end

-- show()
function scene:show( event )
    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then

    elseif ( phase == "did" ) then

    end
end

-- hide()
function scene:hide( event )
    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then

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