local composer = require( "composer" )
local physics = require( "physics" )

local scene = composer.newScene()
composer.recycleOnSceneChange = true

physics.start()
physics.setGravity( 0, planets_G[selectedPlanet] )

-- Activate Multitouch
system.activate( "multitouch" )

-- Load Music
bgMusic = audio.loadSound("assets/sounds/music/Lockdown.mp3")

-- SFX
local gameMusic
local sfx_thrust
local sfx_pause

-- UI Elements
local background

local map
local player

local fuel = startingFuel
local fuelBar
local fuelBarFill
local fuelIndicator

local altitude = 0
local altitudeIndicator
local vSpeed = 0
local vSpeedIndicator
local hSpeed = 0
local hSpeedIndicator

local buttonPause
local buttonLeft
local buttonRight
local buttonThrust

-- Event Flags
local isPaused = false
local isThrusting = false
local isRotatingLeft = false
local isRotatingRight = false

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
    if ( event.phase == "began" ) then
        display.getCurrentStage():setFocus(event.target)
        isThrusting = true
     end
    if ( event.phase == "ended" ) then
        display.getCurrentStage():setFocus(nil)
        isThrusting = false
    end
end
local function pause(event)
    if ( event.phase == "ended" ) then
        if isPaused then
            isPaused = false
            physics.start()
        else
            isPaused = true
            physics.stop()
        end
    end
end

-- Game Loop
local function updateVSpeed()

end
local function updateHSpeed()

end
local function updateAltitude()

end
local function updateFuel()
    if isThrusting and fuel>0 then
        fuel = fuel-FCR
        fuelIndicator.text = math.floor(fuel)
        fuelBarFill.width = (screenWidth/startingFuel)*fuel
    end
end

local function gameLoop (event)
    if isPaused then
        return false
    else
        updateFuel()
        updateAltitude()
        updateVSpeed()
        updateHSpeed()
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
    fuelBarFill.width = (screenWidth/startingFuel)*fuel
    --Fuel Indicator
    fuelIndicator = display.newText( fuel, screenWidth-10, 25, "assets/fonts/ConsoleClassic.ttf", 50 )
    fuelIndicator.anchorX, fuelIndicator.anchorY = 1,0.5
    fuelIndicator:setFillColor(245/255, 134/255, 52/255)

    -- Altitude Indicator
    altitudeIndicator = display.newText("Altitude: "..altitude, screenWidth-10, 70, "assets/fonts/ConsoleClassic.ttf", 50 )
    altitudeIndicator.anchorX, altitudeIndicator.anchorY = 1,0.5
    -- Vertical Speed Indicator
    vSpeedIndicator = display.newText("Vertical Speed: "..vSpeed, screenWidth-10, 110, "assets/fonts/ConsoleClassic.ttf", 50 )
    vSpeedIndicator.anchorX, vSpeedIndicator.anchorY = 1,0.5
    -- Horizontal Speed indicator
    hSpeedIndicator = display.newText("Horizontal Speed: "..hSpeed, screenWidth-10, 150, "assets/fonts/ConsoleClassic.ttf", 50 )
    hSpeedIndicator.anchorX, hSpeedIndicator.anchorY = 1,0.5

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

    Runtime:addEventListener( "enterFrame", gameLoop )
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