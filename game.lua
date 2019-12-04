local Game = {}
Game.__index = Game

local isFullscreen = false

local gfx = {}

Game.hero = require("player")

Game.messages = {}

Game.map = {}
Game.map.grid =  {
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

Game.map.TILE_WIDTH = 32
Game.map.TILE_HEIGHT = 32

Game.currentCell = {row = 1, col = 1}
Game.tileSheet = nil
Game.tilesTextures = {}

function Game.draw()
  local col, row = 0, 0
  local ox, oy

  sx = love.graphics.getWidth() / #Game.map
  sy = love.graphics.getHeight() / #Game.map.grid[1]

  for row in ipairs(Game.map.grid) do
    for col in ipairs(Game.map.grid[row]) do
      local id = Game.map.grid[row][col]
      local texQuad = Game.tilesTextures[id]
      if texQuad ~= nil then
        ox = (col-1) * Game.map.TILE_WIDTH
        oy = (row-1) * Game.map.TILE_HEIGHT
        love.graphics.draw (Game.tileSheet, texQuad, ox, oy)
      end
    end
  end

  love.graphics.print ("colonne : "..tostring(Game.currentCell.col),love.graphics.getWidth()-200, 20)
  love.graphics.print ("ligne : "..tostring(Game.currentCell.row),love.graphics.getWidth()-200, 35)
  local id = Game.map.grid [Game.currentCell.row][Game.currentCell.col]
  love.graphics.print("Type : ".. Game.getTiletypeName(id),  love.graphics.getWidth()-200, 50)

  for i, msg in pairs (Game.messages) do
    love.graphics.print(msg, love.graphics.getWidth()-230, 60+i*15)
  end

  Game.hero.draw (Game.map)

end

Game.tilesTextures = {}

function Game.getTiletypeName(id)
  local tileTypeNames = {}
  tileTypeNames[19] = "Eau"
  tileTypeNames[10] = "Herbe"
  tileTypeNames[13] = "Gravier"
  tileTypeNames[20] = "Mer"
  tileTypeNames[21] = "Mer"
  tileTypeNames[55] = "Arbre"
  tileTypeNames[58] = "Arbre agé"
  tileTypeNames[61] = "Conifère"
  tileTypeNames[169] = "Rochers"

  if tileTypeNames[id] ~= nil then
    return tileTypeNames[id]
  else
    return "Code : "..tostring(id)
  end
end

function Game.loadTiles()
  print ("Chargement des textures ...")
  Game.tileSheet = love.graphics.newImage("images/tilesheet.png");
  local nbcol = Game.tileSheet:getWidth() / Game.map.TILE_WIDTH
  local nbrow = Game.tileSheet:getHeight() / Game.map.TILE_HEIGHT
  local id = 1

  Game.tilesTextures[0] = nil

  for row=1,nbrow do
    for col=1,nbcol do
      Game.tilesTextures[id] = love.graphics.newQuad ((col-1) * Game.map.TILE_WIDTH, (row-1) * Game.map.TILE_HEIGHT,Game.map.TILE_WIDTH, Game.map.TILE_HEIGHT,Game.tileSheet:getWidth(), Game.tileSheet:getHeight() )
      id = id + 1
    end

  end

  print ("Textures chargées.")
end

function Game.update (dt)
  local mx = love.mouse.getX()
  local my = love.mouse.getY()

  if mx <= Game.map.TILE_WIDTH * #Game.map.grid[1] and mx > 0 and my > 0 and my <= Game.map.TILE_HEIGHT * #Game.map.grid then
    Game.currentCell.col = math.ceil(mx / Game.map.TILE_WIDTH)
    Game.currentCell.row = math.ceil(my / Game.map.TILE_HEIGHT)
  end

  Game.hero.update (dt)
end

function Game.showMessage (msg, id)
  table.insert (Game.messages, msg)
  if #Game.messages > 10 then
    table.remove (Game.messages, 1)
  end
end

function Game.clearMessages ()
  Game.messages = {}
end

function Game.movePlayer (vector)
  local newposx = Game.hero.col + vector.x
  local newposy = Game.hero.row + vector.y

  if newposx < 1 then newposx = 1 end
  if newposy < 1 then newposy = 1 end

  local tileType = Game.map.grid[newposy][newposx]
  Game.showMessage ("Moved to tileType "..Game.getTiletypeName (tileType).." at "..tostring(newposx).."x"..tostring(newposy), 1)

  if not (tileType == 21 or
     tileType == 55 or
     tileType == 58 or
     tileType == 61 or
     tileType == 129 or
     tileType == 169)
  then
    Game.hero.col = newposx
    Game.hero.row = newposy
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
