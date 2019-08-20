local composer = require( "composer" )

display.setStatusBar(display.HiddenStatusBar)
centerX = display.contentCenterX
centerY = display.contentCenterY

planets = {"assets/img/planets/moon.png", "assets/img/planets/mars.png", "assets/img/planets/neptune.png"}
ships_full = {"assets/img/ships/apollo_full.png", "assets/img/ships/dragon_full.png", "assets/img/ships/soyuz_full.png"}
ships_mini = {"assets/img/ships/apollo_mini.png", "assets/img/ships/dragon_mini.png", "assets/img/ships/soyuz_mini.png"}

screenWidth = display.contentWidth
screenHeight = display.contentHeight

selectedPlanet = nil
selectedShip = nil
bestScore = 0

composer.gotoScene("scenes.start", { params={} })