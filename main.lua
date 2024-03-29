local composer = require( "composer" )

display.setStatusBar(display.HiddenStatusBar)
centerX = display.contentCenterX
centerY = display.contentCenterY
screenWidth = display.contentWidth
screenHeight = display.contentHeight

-- Control Variables
selectedPlanet = 1
selectedShip = 1

-- Game Settings
-- Fuel Consumption Rate
FCR = 1.50
startingFuel = 1000

--Landing 
maxLandingSpeed = 50
maxLandingAngle = 10

--Score
lastScore = 0

-- Logos
logos = graphics.newImageSheet("assets/img/logos.png", {
    width = 2160,
    height = 500,
    numFrames = 3,
    sheetContentWidth = 2160,
    sheetContentHeight = 1500
})

-- Planets
planets_name = {"Moon","Mars","Neptune"}
planets_map = {"moon.map.png","mars.map.png","neptune.map.png"}
planets_G = {2.37, 4.75, 9.50}
planets = graphics.newImageSheet("assets/img/planets.png",{
    width = 500,
    height = 830,
    numFrames = 3,
    sheetContentWidth = 1500,
    sheetContentHeight = 830
})

-- Ships
ships_name = { "Apollo Lander","Crew Dragon","LK Lander" }
ships_full = graphics.newImageSheet("assets/img/ships.png", {
    width = 1560,
    height = 830,
    numFrames = 3,
    sheetContentWidth = 4680,
    sheetContentHeight = 830
})
ships_body = {"apolo.ship.body.png","dragon.ship.body.png","lk.ship.body.png"}
ships_mini = {"apolo.ship.png","dragon.ship.png","lk.ship.png"}

-- Go To Star Scene
composer.gotoScene("scenes.start")