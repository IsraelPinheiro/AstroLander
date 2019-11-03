local composer = require( "composer" )
local physics = require( "physics" )

local scene = composer.newScene()
composer.recycleOnSceneChange = true

physics.start()
physics.setGravity( 0, planets_G[selectedPlanet] )

-- Activate Multitouch
system.activate( "multitouch" )

-- Load Music
local bgMusic

-- SFX
local sfx_select
local sfx_thruster
local sfx_explode

-- UI Elements
local UIDefaultFont = "assets/fonts/ConsoleClassic.ttf"
local background

local map
local mapFile
local mapOutline

local ship
local shipFile
local shipOutline

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

--Auxiliar Functions

local function absoluteValue(number)
    if number >= 0 then
        return number
    else
        return number*-1
    end
end

-- Event Functions
local function rotateRight(event)
    if ( event.phase == "began" ) then
        display.getCurrentStage():setFocus(event.target)
        isRotatingRight = true
    end
    if ( event.phase == "ended" ) then
        display.getCurrentStage():setFocus(nil)
        isRotatingRight = false
    end
end

local function rotateLeft(event)
    if ( event.phase == "began" ) then
        display.getCurrentStage():setFocus(event.target)
        isRotatingLeft = true
    end
    if ( event.phase == "ended" ) then
        display.getCurrentStage():setFocus(nil)
        isRotatingLeft = false
    end
end

local function thrust(event)
    if ( event.phase == "began" ) then
        display.getCurrentStage():setFocus(event.target)
        audio.play(sfx_thruster, {channel = 2, loops = -1})
        isThrusting = true
    end
    if ( event.phase == "ended" ) then
        display.getCurrentStage():setFocus(nil)
        audio.stop(2)
        isThrusting = false
    end
end

local function pause(event)
    if ( event.phase == "ended" ) then
        if isPaused then
            physics.start()
            isPaused = false
        else
            physics.pause()
            isPaused = true
        end
    end
end

-- Collision / Game Over
local function onShipCollision( self, event )
    vX, vY = ship:getLinearVelocity()
    rotation = ship.rotation
    if ( event.phase == "began" ) then
        distance = ship.x-centerX
        distance = absoluteValue(math.floor(distance))
        if(vY<maxLandingSpeed and absoluteValue(rotation)<maxLandingAngle) then
            -- Score Calc
            score =math.floor(((distance+1)*(fuel/10))/(vY/10))
            print("You Landed - Final Score "..score)
            --composer.gotoScene("scenes.start")
        else
            audio.play(sfx_explode)
            print("You Exploded - Game Over ")
            --composer.gotoScene("scenes.start")
        end
    end
end

-- Game Loop
local function updateSpeed()
    vX, vY = ship:getLinearVelocity()
    vSpeedIndicator.text = "Vertical Speed: "..string.format("%.2f", absoluteValue(vY))
    hSpeedIndicator.text = "Horizontal Speed: "..string.format("%.2f", absoluteValue(vX))
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

local function updateRotation()
    if isRotatingRight then
        ship.rotation = ship.rotation + 1
    elseif isRotatingLeft then
        ship.rotation = ship.rotation - 1
    end
end

-- Calc Ship Thrust Vector
local function angle2VecDeg (angle)
    angle = angle*math.pi/180
    return math.cos(angle), math.sin(angle)
end

local function updateThrust()
    if isThrusting and fuel>0 then
        local vecX, vecY = angle2VecDeg( ship.rotation-90 ) 
        ship:applyForce ( vecX, vecY, ship.x, ship.y )
    end
end

local function gameLoop (event)
    if isPaused then
        return false
    else
        updateFuel()
        updateAltitude()
        updateSpeed()
        updateRotation()
        updateThrust()
    end
end

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event ) 
    local sceneGroup = self.view
    -- Reserve 3 Audio Channels
    audio.reserveChannels(3)
    
    -- Load Music
    bgMusic = audio.loadSound("assets/sounds/music/Lockdown.mp3")
    
    -- Load SFX
    sfx_select = audio.loadSound("assets/sounds/sfx/select.wav")
    sfx_thruster = audio.loadSound("assets/sounds/sfx/rocketThruster.mp3")
    sfx_explode = audio.loadSound("assets/sounds/sfx/explode.mp3")
    
    -- Background Image
    background = display.newImage("assets/img/ui/background.png")
    background.x, background.y = centerX, centerY
    background.width, background.height = screenWidth*1.5, screenHeight*1.5
    
    --Map
    mapFile = "assets/img/maps/"..planets_map[selectedPlanet]
    mapOutline = graphics.newOutline( 2, mapFile )
    map = display.newImage( mapFile )
    map.anchorX, map.anchorY = 0.5,1
    map.x, map.y = centerX, screenHeight
    physics.addBody( map, "static", { outline=mapOutline, bounce=0, friction=1 } )
    
    -- Player Ship
    shipOutline = graphics.newOutline( 2, "assets/img/ships/"..ships_body[selectedShip] )
    ship = display.newImage("assets/img/ships/"..ships_mini[selectedShip])
    ship.x, ship.y = centerX, 50
    physics.addBody( ship, "dynamic",{outline=shipOutline, bounce=0, friction=1})
    ship.collision = onShipCollision
    ship:addEventListener( "collision" )
    
    --Fuel Bar
    fuelBar = display.newImage("assets/img/ui/fuelBar.png")
    fuelBar.anchorX, fuelBar.anchorY = 0,0
    
    --Fuel Bar Fill
    fuelBarFill = display.newImage("assets/img/ui/fuelBarFill.png")
    fuelBarFill.anchorX, fuelBarFill.anchorY = 0,0
    fuelBarFill.width = (screenWidth/startingFuel)*fuel
    
    --Fuel Indicator
    fuelIndicator = display.newText( fuel, screenWidth-10, 25, UIDefaultFont, 50 )
    fuelIndicator.anchorX, fuelIndicator.anchorY = 1,0.5
    fuelIndicator:setFillColor(245/255, 134/255, 52/255)

    -- Altitude Indicator
    altitudeIndicator = display.newText("Altitude: "..altitude, screenWidth-10, 70, UIDefaultFont, 50 )
    altitudeIndicator.anchorX, altitudeIndicator.anchorY = 1,0.5
    
    -- Vertical Speed Indicator
    vSpeedIndicator = display.newText("Vertical Speed: "..vSpeed, screenWidth-10, 110, UIDefaultFont, 50 )
    vSpeedIndicator.anchorX, vSpeedIndicator.anchorY = 1,0.5
    
    -- Horizontal Speed indicator
    hSpeedIndicator = display.newText("Horizontal Speed: "..hSpeed, screenWidth-10, 150, UIDefaultFont, 50 )
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

    -- Game Loop Listener
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
        audio.stop()
        physics.stop()
        -- Remove Event Listeners
        buttonPause:removeEventListener( "touch", pause)
        buttonRight:removeEventListener( "touch", rotateRight)
        buttonLeft:removeEventListener( "touch", rotateLeft)
        buttonThrust:removeEventListener( "touch", thrust)
        Runtime:removeEventListener( "enterFrame", gameLoop )
        -- Remove Display Elements
        display.remove(background)
        display.remove(planet)
        display.remove(buttonLeft)
        display.remove(buttonRight)
        display.remove(buttonSelect)
        display.remove(buttonBack)
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