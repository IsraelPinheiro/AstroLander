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

-- Game Settings
-- Fuel Consumption Rate
FCR = 0.50
startingFuel = 1000

-- Logos
logos = graphics.newImageSheet("assets/img/logos.png", {
    width = 2160,
    height = 500,
    numFrames = 3,
    sheetContentWidth = 2160,
    sheetContentHeight = 1500
})

-- Planets
planets_name = { "Moon","Mars","Neptune" }
planets_G = { 1.62, 3.71, 11.15 }
planets = graphics.newImageSheet("assets/img/planets.png", {
    width = 500,
    height = 830,
    numFrames = 3,
    sheetContentWidth = 1500,
    sheetContentHeight = 830
})

-- Ships
ships_full = graphics.newImageSheet("assets/img/ships.png", {
    width = 1560,
    height = 830,
    numFrames = 3,
    sheetContentWidth = 4680,
    sheetContentHeight = 830
})

ships_mini = graphics.newImageSheet("assets/img/ships_mini.png", {
    frames ={
        {   -- Apollo Lander
            x = 0,
            y = 0,
            width = 138,
            height = 85
        },
        {   -- Crew Dragon
            x = 810,
            y = 0,
            width = 74,
            height = 85
        }
        ,
        {   -- LK Lander
            x = 1244,
            y = 0,
            width = 35,
            height = 85
        }
    }
})

ships_name = { "Apollo Lander","Crew Dragon","LK Lander" }

-- Go To Star Scene
composer.gotoScene("scenes.game", { params={} })