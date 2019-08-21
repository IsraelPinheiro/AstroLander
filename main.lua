local composer = require( "composer" )

display.setStatusBar(display.HiddenStatusBar)
centerX = display.contentCenterX
centerY = display.contentCenterY

screenWidth = display.contentWidth
screenHeight = display.contentHeight

-- Control Variables
selectedPlanet = 1
selectedShip = 1
bestScore = 0

-- Planets
planets = graphics.newImageSheet("assets/img/planets.png", {
    width = 500,
    height = 500,
    numFrames = 3
})

planets_name = { "Moon","Mars","Neptune" }
planets_G = { 1.62, 3.71, 11.15 }

-- Ships
ships_full = graphics.newImageSheet("assets/img/ships_full.png", {
    width = 500,
    height = 500,
    numFrames = 3
})

ships_mini = graphics.newImageSheet("assets/img/ships_mini.png", {
    width = 80,
    height = 80,
    numFrames = 3
})

ships_name = { "Dragon","Apollo Lander","Soyuz" }

composer.gotoScene("scenes.start", { params={} })