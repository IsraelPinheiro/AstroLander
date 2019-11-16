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

local barrierTop
local barrierLeft
local barrierRight

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
    if(isPaused == false) then
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

-- Collision and Game Over handling
local function gameOver()
    if(isPaused == false) then
        isPaused = true
        if(lastScore<=0) then
            audio.play(sfx_explode)
        end
        timer.performWithDelay(2000, function () composer.gotoScene("scenes.gameOver") end)
    end
end

local function onShipCollision( self, event )
    print(event.other.name)
    vX, vY = ship:getLinearVelocity()
    rotation = ship.rotation
    if (event.phase == "began" and event.other.name~="barrier") then
        distance = ship.x-centerX
        distance = absoluteValue(math.floor(distance))
        if(vY<maxLandingSpeed and absoluteValue(rotation)<=maxLandingAngle) then
            -- Score Calc
            lastScore = math.floor(((distance+1)*(fuel/10))/(vY/10))
        else
            lastScore = 0
        end
        gameOver()
    end
end

-- Keyboard controls handler
local function onKeyEvent( event )
    if (system.getInfo( "platform" ) == "win32" or system.getInfo( "platform" ) == "macos" ) then

    end

    if(event.keyName == "space" or event.keyName == "up" or event.keyName == "buttonA") then
        if ( event.phase == "down" ) then
            display.getCurrentStage():setFocus(event.target)
            audio.play(sfx_thruster, {channel = 2, loops = -1})
            isThrusting = true
        end
        if ( event.phase == "up" ) then
            display.getCurrentStage():setFocus(nil)
            audio.stop(2)
            isThrusting = false
        end
    end

    if(event.keyName == "left") then
        if ( event.phase == "down" ) then
            display.getCurrentStage():setFocus(event.target)
            isRotatingLeft = true
        end
        if ( event.phase == "up" ) then
            display.getCurrentStage():setFocus(nil)
            isRotatingLeft = false
        end
    end

    if(event.keyName == "right") then
        if ( event.phase == "down" ) then
            display.getCurrentStage():setFocus(event.target)
            isRotatingRight = true
        end
        if ( event.phase == "up" ) then
            display.getCurrentStage():setFocus(nil)
            isRotatingRight = false
        end
    end

    if(event.keyName == "escape" or event.keyName == "P") then
        if isPaused then
            physics.start()
            isPaused = false
        else
            physics.pause()
            isPaused = true
        end
    end
 
    -- If the "back" key was pressed on Android, prevent it from backing out of the app
    if ( event.keyName == "back" ) then
        if (system.getInfo("platform") == "android" ) then
            return true
        end
    end

    return false
end

-- Game Loop
local function updateSpeed()
    vX, vY = ship:getLinearVelocity()
    vSpeedIndicator.text = "Vertical Speed: "..string.format("%.2f", absoluteValue(vY))
    hSpeedIndicator.text = "Horizontal Speed: "..string.format("%.2f", absoluteValue(vX))
end

local function updateAltitude()
    local hits = physics.rayCast( ship.x, ship.y-1, ship.x , ship.y+1000, "closest" )
    altitudeIndicator.text = "Altitude: "..string.format("%.2f", math.floor(screenHeight - ship.y-(ship.height/2)) - (screenHeight - hits[1].position.y))

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
    display.setStatusBar(display.HiddenStatusBar)
    
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
    -- Map Boundaries
    barrierTop = display.newLine(0,0,screenWidth,0)
    barrierTop.name = "barrier"
    physics.addBody(barrierTop, "static",{bounce=0, friction=0})
    barrierLeft = display.newLine(0,0,0,screenHeight)
    barrierLeft.name = "barrier"
    physics.addBody(barrierLeft, "static",{bounce=0, friction=0})
    barrierRight = display.newLine(screenWidth,0,screenWidth,screenHeight)
    barrierRight.name = "barrier"
    physics.addBody(barrierRight, "static",{bounce=0, friction=0})

    -- Player Ship
    shipOutline = graphics.newOutline( 3, "assets/img/ships/"..ships_body[selectedShip] )
    ship = display.newImage("assets/img/ships/"..ships_mini[selectedShip])
    --ship.anchorX = 0.5
    ship.x, ship.y = centerX, 50
    physics.addBody( ship, "dynamic",{outline=shipOutline, bounce=0, friction=1})
    ship.isFixedRotation = true
    ship.collision = onShipCollision
    ship:addEventListener("collision")
    
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
    Runtime:addEventListener("enterFrame", gameLoop)

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
        ship:removeEventListener("collision")
        buttonPause:removeEventListener("touch", pause)
        buttonRight:removeEventListener("touch", rotateRight)
        buttonLeft:removeEventListener("touch", rotateLeft)
        buttonThrust:removeEventListener("touch", thrust)
        Runtime:removeEventListener("enterFrame", gameLoop)
        Runtime:removeEventListener("key", onKeyEvent)
        -- Remove Display Elements
        display.remove(background)
        display.remove(map)
        display.remove(ship)
        display.remove(buttonLeft)
        display.remove(buttonRight)
        display.remove(buttonThrust)
        display.remove(buttonPause)
        display.remove(fuelIndicator)
        display.remove(fuelBar)
        display.remove(fuelBarFill)
        display.remove(altitudeIndicator)
        display.remove(hSpeedIndicator)
        display.remove(vSpeedIndicator)
        display.remove(barrier)
    elseif (phase == "did") then
        physics.stop()
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