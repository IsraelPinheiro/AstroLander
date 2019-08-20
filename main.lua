local composer = require( "composer" )

display.setStatusBar(display.HiddenStatusBar)
centerX = display.contentCenterX
centerY = display.contentCenterY

screenWidth = display.contentWidth
screenHeight = display.contentHeight

selectedPlanet = nil
selectedShip = nil
bestScore = 0


composer.gotoScene("scenes.start", { params={} })