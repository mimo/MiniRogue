
local Player = {}

Player.sprites = {}
Player.sprites[1] = love.graphics.newImage("images/player_1.png")
Player.sprites[2] = love.graphics.newImage("images/player_2.png")
Player.sprites[3] = love.graphics.newImage("images/player_3.png")
Player.sprites[4] = love.graphics.newImage("images/player_4.png")
Player.targetDeltaS = 0.5
Player.deltaS = 0.0
Player.switchable = false
Player.currentSprite = 1
Player.row = 3
Player.col = 3

local time =  0

function Player.update (dt)
  time = time + dt

  function doswitch()
    if Player.currentSprite < #Player.sprites then
      Player.currentSprite = Player.currentSprite+1
    else
      Player.currentSprite = 1
    end
  end

  if time > Player.deltaS then
    Player.deltaS = Player.deltaS + Player.targetDeltaS
    doswitch()
  end

end

function Player.draw(map)
  local x = (Player.col-1) * map.TILE_WIDTH
  local y = (Player.row-1) * map.TILE_HEIGHT
  love.graphics.draw (Player.sprites[Player.currentSprite], x, y, 0, 2, 2)
  love.graphics.print ("Time : "..tostring(math.floor(time)).."s", 25, 200)
end

return Player
