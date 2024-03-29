local Game = {}
Game.__index = Game

local isFullscreen = false

local GFX = require("gfx")

Game.level = {}
Game.level.map =  {
	{10,10,10,10,10,10,10,10,10,61,10,13,10,10,10,10,10,10,13,14,15,15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15},
	{10, 10, 10, 10, 10, 11, 11, 11, 10, 10, 10, 13, 10, 10, 10, 10, 10, 10, 10, 14, 15, 15, 129, 15, 15, 15, 15, 15, 15, 68, 15, 15},
	{10, 10, 61, 10, 11, 19, 19, 19, 11, 10, 10, 13, 10, 10, 169, 10, 10, 10, 10, 13, 14, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15},
	{10, 10, 10, 11, 19, 19, 19, 19, 19, 11, 10, 13, 10, 10, 10, 10, 10, 10, 10, 10, 13, 14, 15, 15, 15, 68, 15, 15, 15, 15, 15, 15},
	{10, 10, 10, 11, 19, 19, 19, 19, 19, 11, 10, 13, 10, 10, 10, 10, 10, 10, 61, 10, 10, 14, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15},
	{10, 10, 61, 10, 11, 19, 19, 19, 11, 10, 10, 13, 10, 10, 10, 10, 10, 10, 10, 10, 10, 14, 15, 15, 129, 15, 15, 15, 68, 15, 129, 15},
	{10, 10, 10, 10, 10, 11, 11, 11, 10, 10, 61, 13, 10, 10, 10, 10, 10, 10, 10, 10, 10, 14, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15},
	{10, 10, 10, 10, 10, 13, 13, 13, 13, 13, 13, 13, 10, 10, 10, 10, 10, 169, 10, 10, 10, 13, 14, 15, 15, 15, 15, 15, 15, 15, 15, 15},
	{10, 10, 10, 10, 10, 10, 10, 10, 13, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 61, 10, 13, 14, 14, 14, 14, 14, 14, 14, 15, 129},
	{10, 10, 10, 10, 10, 10, 10, 10, 13, 55, 10, 58, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 13, 14, 14},
	{10, 10, 10, 10, 10, 10, 10, 10, 13, 10, 10, 10, 55, 10, 58, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10},
	{10, 10, 10, 10, 10, 10, 10, 10, 13, 10, 58, 10, 10, 10, 10, 10, 10, 169, 10, 10, 10, 10, 10, 10, 61, 10, 10, 10, 10, 10, 1, 1},
	{10, 10, 10, 10, 10, 10, 10, 10, 13, 10, 10, 10, 58, 10, 10, 10, 10, 10, 10, 10, 10, 61, 10, 10, 10, 10, 10, 10, 10, 1, 37, 37},
	{13, 13, 13, 13, 13, 13, 13, 13, 13, 10, 55, 10, 10, 10, 55, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 1, 1, 37, 37, 37},
	{10, 10, 10, 10, 13, 10, 10, 10, 10, 10, 10, 10, 55, 10, 10, 10, 10, 169, 10, 10, 10, 10, 10, 10, 10, 10, 1, 37, 37, 37, 37, 37},
	{10, 10, 10, 10, 13, 10, 10, 10, 10, 142, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 1, 37, 37, 37, 37, 37, 37},
	{10, 10, 10, 10, 13, 10, 10, 10, 10, 10, 10, 10, 10, 142, 10, 10, 10, 10, 10, 10, 10, 169, 10, 10, 1, 37, 37, 37, 37, 37, 37, 37},
	{14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 1, 37, 37, 37, 37, 37, 37, 37},
	{14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 1, 37, 37, 37, 37, 37, 37, 37},
	{19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 1, 37, 37, 37, 37, 37, 37, 37},
	{20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 1, 37, 37, 37, 37, 37, 37},
	{21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 1, 37, 37, 37, 37},
	{21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 1, 37, 37, 37}
}

Game.mouseAtCell = {row = 1, col = 1}
Game.level.mapTileSheet = nil
Game.level.tilesTextures = {}
Game.level.fog = {}
Game.entities = {}
Game.playerSurroundings = {}

function Game.draw()
	local col, row = 0, 0
	local ox, oy

	sx = love.graphics.getWidth() / #Game.level
	sy = love.graphics.getHeight() / #Game.level.map[1]

	for row in ipairs (Game.level.map) do
		for col in ipairs (Game.level.map[row]) do
			local id = Game.level.map[row][col]
			local texQuad = Game.level.tilesTextures[id]
			if texQuad ~= nil then
				ox = (col-1) * Game.level.TILE_WIDTH
				oy = (row-1) * Game.level.TILE_HEIGHT
				love.graphics.draw (Game.level.mapTileSheet, texQuad, ox, oy)
				fogShade = Game.level.fog[row][col]
				if Game.playerSurroundings [row] ~= nil then
					if Game.playerSurroundings [row][col] ~= nil then
						fogShade = Game.playerSurroundings [row][col]
					end
				end
				love.graphics.setColor(0, 0, 0, fogShade)
				love.graphics.rectangle ("fill", ox, oy, Game.level.TILE_WIDTH, Game.level.TILE_HEIGHT)
				love.graphics.reset ()
			end
		end
	end

	for i, entity in ipairs (Game.entities) do
		entity.draw (Game.map)
	end
end

function Game.level.clearFog (hRow, hCol)
	local range = 6
	local sRow = hRow-range
	local eRow = hRow+range
	local sCol = hCol-range
	local eCol = hCol+range
	local worldEnd = {row = #Game.level.map, col = #Game.level.map[1]}

	if sRow < 1 then sRow = 1 end
	if eRow >= worldEnd.row then eRow = worldEnd.row end

	if sCol < 1 then sCol = 1 end
	if eCol >= worldEnd.col then eCol = worldEnd.col end

	for row=sRow,eRow do
		Game.playerSurroundings [row] = {}
		for col=sCol,eCol do
			local dx = row - hRow
			local dy = col - hCol
			local dist = math.sqrt(dx * dx + dy * dy)
			local surroundShading = 1.0 / range * dist / 2
			local fogShading = 0.6
			if dist < range then
				Game.level.fog[row][col] = 0.6
				if fogShading > surroundShading then
					Game.playerSurroundings [row][col] = surroundShading
				end
			end
		end
	end
end

function Game.loadTiles()
	print ("Chargement des textures ...")
	Game.level.mapTileSheet = love.graphics.newImage("images/tilesheet.png");
	Game.level.TILE_WIDTH = 32
	Game.level.TILE_HEIGHT = 32

	local nbcol = Game.level.mapTileSheet:getWidth() / Game.level.TILE_WIDTH
	local nbrow = Game.level.mapTileSheet:getHeight() / Game.level.TILE_HEIGHT
	local id = 1

	Game.level.tilesTextures[0] = nil

	for row=1,nbrow do
		for col=1,nbcol do
			local tileSprite = love.graphics.newQuad (
				(col-1) * Game.level.TILE_WIDTH,
				(row-1) * Game.level.TILE_HEIGHT,
				Game.level.TILE_WIDTH,
				Game.level.TILE_HEIGHT,
				Game.level.mapTileSheet:getWidth(),
				Game.level.mapTileSheet:getHeight() )
			Game.level.tilesTextures[id] = tileSprite
			id = id + 1
		end

	end

	print ("Textures chargées.")

	local col, row = 0, 0
	for row in ipairs (Game.level.map) do
		Game.level.fog[row] = {}
		for col in ipairs (Game.level.map[row]) do
			Game.level.fog[row][col] = 1.0
		end
	end
end

function Game.spawn (entity, posx, posy)
	entity.world = Game.level
	entity.setCoordinates (posx, posy)
	table.insert (Game.entities, entity)
end

function Game.level.checkHit (coordinates)

	if coordinates.x < 1
	   or coordinates.y < 1
	   or coordinates.x > #Game.level.map[1]
	   or coordinates.y > #Game.level.map
	then
		return true
	end

	local tileType = Game.level.map[coordinates.y][coordinates.x]

	if tileType == 21 or
		tileType == 55 or
		tileType == 58 or
		tileType == 61 or
		tileType == 129 or
		tileType == 169
	then
		return true
	else
		return false
	end
end

function Game.update (dt)
	local mx = love.mouse.getX()
	local my = love.mouse.getY()

	if mx <= Game.level.TILE_WIDTH * #Game.level.map[1] and mx > 0 and my > 0 and my <= Game.level.TILE_HEIGHT * #Game.level.map then
		Game.mouseAtCell.col = math.ceil(mx / Game.level.TILE_WIDTH)
		Game.mouseAtCell.row = math.ceil(my / Game.level.TILE_HEIGHT)
	end

	Game.playerSurroundings = {}

	for i, entity in ipairs (Game.entities) do
		entity.update (dt)
	end
end



function Game.toggleFullscreen()
	if isFullscreen
	then love.window.setFullscreen(false)
	else love.window.setFullscreen(true)
	end

	isFullscreen = not isFullscreen
end

return Game
