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

-- Logos
logos = graphics.newImageSheet("assets/img/logos.png", {
    width = 2160,
    height = 500,
    numFrames = 3,
    sheetContentWidth = 2160,
    sheetContentHeight = 1500
})

-- Planets
planets = graphics.newImageSheet("assets/img/planets.png", {
    width = 500,
    height = 500,
    numFrames = 3,
    sheetContentWidth = 1500,
    sheetContentHeight = 500
})

planets_name = { "Moon","Mars","Neptune" }
planets_G = { 1.62, 3.71, 11.15 }

-- Ships
ships_full = graphics.newImageSheet("assets/img/ships_full.png", {
    frames ={
        {   -- Apollo Lander
            x = 0,
            y = 0,
            width = 810,
            height = 500
        },
        {   -- Dragon
            x = 810,
            y = 0,
            width = 434,
            height = 500
        }
        ,
        {   -- Soyuz
            x = 1244,
            y = 0,
            width = 202,
            height = 500
        }
    }
})

ships_mini = graphics.newImageSheet("assets/img/ships_mini.png", {
    frames ={
        {   -- Apollo Lander
            x = 0,
            y = 0,
            width = 138,
            height = 85
        },
        {   -- Dragon
            x = 810,
            y = 0,
            width = 74,
            height = 85
        }
        ,
        {   -- Soyuz
            x = 1244,
            y = 0,
            width = 35,
            height = 85
        }
    }
})

ships_name = { "Dragon","Apollo Lander","Soyuz" }

-- Go To Star Scene
composer.gotoScene("scenes.start", { params={} })