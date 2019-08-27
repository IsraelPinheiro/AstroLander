local composer = require( "composer" )
local scene = composer.newScene()
composer.recycleOnSceneChange = true

-- SFX
local bgMusic
local sfx_buttons
local sfx_select

-- UI Elements
local background
local planet
local buttonLeft
local buttonRight
local buttonSelect
local buttonBack

-- Event Functions
local function nextPlanet(event)
    if ( event.phase == "ended" ) then
        audio.play(sfx_buttons)
        if (selectedPlanet == 3) then
            selectedPlanet = 1
        else
            selectedPlanet = selectedPlanet + 1
        end
        planet:setFrame(selectedPlanet)
    end
end

local function previousPlanet(event)
    if ( event.phase == "ended" ) then
        audio.play(sfx_buttons)
        if (selectedPlanet == 1) then
            selectedPlanet = 3
        else
            selectedPlanet = selectedPlanet - 1
        end
        planet:setFrame(selectedPlanet)
    end
end

local function selectPlanet(event)
    if ( event.phase == "ended" ) then
        audio.play(sfx_select)
        composer.gotoScene("scenes.ships", { params={} })
    end
end

local function goBack(event)
    if ( event.phase == "ended" ) then
        --TODO: goBack Action
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

    -- Planet
    planet = display.newSprite(planets, {start=1, count=3 })
    planet.anchorX, planet.anchorY = 0.5, 0
    planet.x, planet.y = centerX, 0

    -- Buttons
    -- Arrow Left
    buttonLeft = display.newImage("assets/img/ui/left.png")
    buttonLeft.anchorX, buttonLeft.anchorY = 0, 0.5 
    buttonLeft.x, buttonLeft.y = 50, centerY
    buttonLeft:addEventListener( "touch", previousPlanet)

    -- Arrow Right
    buttonRight = display.newImage("assets/img/ui/right.png")
    buttonRight.anchorX, buttonRight.anchorY = 1, 0.5
    buttonRight.x, buttonRight.y = screenWidth-50, centerY
    buttonRight:addEventListener( "touch", nextPlanet)

    -- Back
    buttonBack = display.newImage("assets/img/ui/back.png")
    buttonBack.anchorX, buttonBack.anchorY = 0, 0
    buttonBack.x, buttonBack.y = 30, 30
    buttonBack:addEventListener( "touch", goBack)

    -- Select
    buttonSelect = display.newImage("assets/img/ui/select.png")
    buttonSelect.anchorX, buttonSelect.anchorY = 0.5, 1
    buttonSelect.x, buttonSelect.y = centerX, screenHeight - 50
    buttonSelect:addEventListener( "touch", selectPlanet)

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
        -- Code here runs immediately after the scene goes entirely off screen
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