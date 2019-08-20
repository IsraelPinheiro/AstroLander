local composer = require( "composer" )
 
local scene = composer.newScene()


local function nextPlanet(event)
    if ( event.phase == "ended" ) then
        if (selectedPlanet == 3) then
            selectedPlanet = 1
        else
            selectedPlanet = selectedPlanet + 1
        end
        print(selectedPlanet)
    end
end

local function previousPlanet(event)
    if ( event.phase == "ended" ) then
        if (selectedPlanet == 1) then
            selectedPlanet = 3
        else
            selectedPlanet = selectedPlanet - 1
        end
        print(selectedPlanet)
    end
end

local function selectPlanet(event)
    if ( event.phase == "ended" ) then

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
    -- Code here runs when the scene is first created but has not yet appeared on screen


    -- Background Image
    local background = display.newImage("assets/img/ui/background.png")
    background.x, background.y = centerX, centerY
    background.width, background.height = screenWidth*2, screenHeight*2


    -- Planet
    local planet = display.newImage(planets[selectedPlanet])
    planet.anchorX, planet.anchorY = 0.5, 0.5
    planet.x, planet.y = centerX, planet.height/2 + 130

    -- Buttons
    -- Arrow Left
    local buttonLeft = display.newImage("assets/img/ui/left.png")
    buttonLeft.anchorX, buttonLeft.anchorY = 0, 0.5 
    buttonLeft.x, buttonLeft.y = 50, centerY
    buttonLeft:addEventListener( "touch", previousPlanet)

    -- Arrow Right
    local buttonRight = display.newImage("assets/img/ui/right.png")
    buttonRight.anchorX, buttonRight.anchorY = 1, 0.5
    buttonRight.x, buttonRight.y = screenWidth-50, centerY
    buttonRight:addEventListener( "touch", nextPlanet)

    -- Select
    local buttonSelect = display.newImage("assets/img/ui/select.png")
    buttonSelect.anchorX, buttonSelect.anchorY = 0.5, 1
    buttonSelect.x, buttonSelect.y = centerX, screenHeight -50

    buttonSelect:addEventListener( "touch", selectPlanet)
    
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