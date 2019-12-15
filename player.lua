
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
Player.row = 1
Player.col = 1
Player.moving = false

local time =  0

function Player.move (vector)
	local newposx = Player.col
	local newposy = Player.row

	if love.keyboard.isDown ("down")      then newposy = Player.row + 1
	elseif love.keyboard.isDown ("up")    then newposy = Player.row - 1
	elseif love.keyboard.isDown ("right") then newposx = Player.col + 1
	elseif love.keyboard.isDown ("left")  then newposx = Player.col - 1
	end

	if not Player.world.checkHit ({x = newposx, y = newposy}) then
		Player.col = newposx
		Player.row = newposy
	end
end

function Player.setCoordinates (row, col)
	Player.row = row
	Player.col = col
end

function Player.update (dt)

	if love.keyboard.isDown ("up", "right", "down", "left") then
		if not Player.moving then
			Player.moving = true
			Player.move ()
		end
	else
		Player.moving = false
	end

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
	local x = (Player.col - 1) * Player.world.TILE_WIDTH
	local y = (Player.row - 1) * Player.world.TILE_HEIGHT
	love.graphics.draw (Player.sprites[Player.currentSprite], x, y, 0, 2, 2)
end

return Player
