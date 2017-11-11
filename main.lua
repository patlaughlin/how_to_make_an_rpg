LoadLibrary("Renderer")
LoadLibrary("Sprite")
LoadLibrary("System")
LoadLibrary("Texture")

gTextures =
{
    Texture.Find("tiles_00.png"),
    Texture.Find("tiles_01.png"),
    Texture.Find("tiles_02.png"),
    Texture.Find("tiles_03.png"),
    Texture.Find("tiles_04.png"),
    Texture.Find("tiles_05.png"),
    Texture.Find("tiles_06.png"),
    Texture.Find("tiles_07.png"),
    Texture.Find("tiles_08.png"),
    Texture.Find("tiles_09.png"),
    Texture.Find("tiles_10.png"),
}

function GenerateUVs(texture, tileSize)
local uvs = {}
local textureWidth = texture:GetWidth() local textureHeight = texture:GetHeight() local width = tileSize / textureWidth local height = tileSize / textureHeight local cols = textureWidth / tileSize local rows = textureHeight / tileSize
local u0 = 0 local v0 = 0 local u1 = width local v1 = height
for j = 0, rows - 1 do for i = 0, cols -1 do table.insert(uvs, {u0, v0, u1, v1}) u0 = u0 + width u1 = u1 + width end u0 = 0 v0 = v0 + height u1 = width v1 = v1 + height end return uvs
end


gMap =
{
    1,1,1,1,5,6, 7,1,   -- 1
    1,1,1,1,5,6,7,1,    -- 2
    1,1,1,1,5,6,7,1,    -- 3
    3,3,3,3,11,6,7,1,   -- 4
    9,9,9,9,9,9,10,1,   -- 5
    1,1,1,1,1,1,1,1,    -- 6
    1,1,1,1,1,1,2,3,    -- 7
}
gUVs = { -- Left Top Right Bottom -- U V U V {0, 0, 0.0625, 0.0625}, {0.0625, 0, 0.125, 0.0625}, {0.125, 0, 0.1875, 0.0625},
44
{0.1875, 0, 0.25, 0.0625}, {0.25, 0, 0.3125, 0.0625}, {0.3125, 0, 0.375, 0.0625}, {0.375, 0, 0.4375, 0.0625}, {0.4375, 0, 0.5, 0.0625}, {0.5, 0, 0.5625, 0.0625}, {0.5625, 0, 0.625, 0.0625}, {0.625, 0, 0.6875, 0.0625},
}
gMapWidth = 8
gMapHeight = 7


gTileWidth = gTextures[1]:GetWidth()
gTileHeight = gTextures[1]:GetHeight()

gDisplayWidth = System.ScreenWidth()
gDisplayHeight = System.ScreenHeight()

gTop = gDisplayHeight / 2 - gTileHeight / 2
gLeft = -gDisplayWidth / 2 + gTileWidth / 2


function GetTile(map, rowsize, x, y)
    x = x + 1 -- change from  1 -> rowsize
              -- to           0 -> rowsize - 1
    return map[x + y * rowsize]
end

gRenderer = Renderer.Create()

local row = 0
for col = 0, gMapWidth - 1 do
    local coords = string.format("[%d,%d]: ", col, row)
    print(coords, GetTile(gMap, gMapWidth, col, row))
end

gTileSprite = Sprite.Create()
gTileSprite:SetTexture(gTextures[1])

function update()
    for j = 0, gMapHeight - 1 do
        for i = 0, gMapWidth - 1 do
            local tile = GetTile(gMap, gMapWidth, i, j)
            local texture = gTextures[tile]
            gTileSprite:SetTexture(texture)
            gTileSprite:SetPosition(gLeft + i * gTileWidth, gTop - j * gTileHeight)
            gRenderer:DrawSprite(gTileSprite)
        end
    end
end
