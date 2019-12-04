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
  love.window.setMode (750, 705)
  love.window.setTitle ("Mini rogue II")

  screenWidth = love.graphics.getWidth()
  screenHeight = love.graphics.getHeight()

  pixelsize = 4
  love.graphics.setPointSize (pixelsize)
  love.graphics.setBackgroundColor (0.2, 0.2, 0.2)

  Game:loadTiles()
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

  if key == "down"      then Game.movePlayer ({ x =  0, y =  1 })
  elseif key == "up"    then Game.movePlayer ({ x =  0, y = -1 })
  elseif key == "right" then Game.movePlayer ({ x =  1, y =  0 })
  elseif key == "left"  then Game.movePlayer ({ x = -1, y =  0 })
  end

end
