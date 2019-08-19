local composer = require( "composer" )

display.setStatusBar(display.HiddenStatusBar)
local centerX = display.contentCenterX
local centerY = display.contentCenterY

bestScore = 0
composer.gotoScene("scenes.start", { params={} })