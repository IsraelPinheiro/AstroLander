local composer = require( "composer" )
local scene = composer.newScene()
composer.recycleOnSceneChange = true

-- SFX
local gameMusic
local sfx_thrust
local sfx_pause

-- UI Elements
local background

local fuelBar
local fuelBarFill

local buttonPause
local buttonLeft
local buttonRight
local buttonThrust

-- Event Functions
local function pause(event)
    if ( event.phase == "ended" ) then
       
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

    --FuelBar

    -- Pause Button
    buttonPause = display.newImage("assets/img/ui/pause.png")
    buttonPause.anchorX, buttonPause.anchorY = 0, 0
    buttonPause.x, buttonPause.y = 30, 30
    buttonPause:addEventListener( "touch", pause)

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