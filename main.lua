-- Cette ligne permet d'afficher des traces dans la console pendant l'éxécution
io.stdout:setvbuf('no')

-- Empèche Love de filtrer les contours des images quand elles sont redimentionnées
-- Indispensable pour du pixel art
love.graphics.setDefaultFilter("nearest")

-- Cette ligne permet de déboguer pas à pas dans ZeroBraneStudio
if arg[#arg] == "-debug" then require("mobdebug").start() end

local GFX = require("gfx")
local Game  = require("game")

local pixelsize
local screenWidth
local screenHeight


function love.load()
	love.window.setMode (1200, 800)
	love.window.setTitle ("Mini rogue II")

	screenWidth = love.graphics.getWidth()
	screenHeight = love.graphics.getHeight()

	pixelsize = 4
	love.graphics.setPointSize (pixelsize)
	love.graphics.setBackgroundColor (0.2, 0.2, 0.2)

	local hero = require("player")
	Game:loadTiles()
	Game.spawn (hero, 3, 3)
end

function love.update(dt)
  Game.update (dt)
end

function love.draw()
  Game.draw()
end

function love.keypressed(key)

  if key == "escape"  then
    love.event.quit(0)
  end

  if key == "f"  then
    Game.toggleFullscreen()
  end

end
