
I=require "imgEnemy"

local M={}


M.enemiesAll={}
M.enemiesAll.enemies={}
M.enemiesAll.cooldown=50
M.spawnSpeed=200

local frames={}
local currentFrameEnemies=1







local background=love.graphics.newImage("ironmanb1.png")
local backgroundSide=love.graphics.newImage("menu111.png")


function M.enemiesAll:spawnEnemies(x)
    local enemy={}
    enemy.x=x
    --    enemy.y=y
    enemy.y=love.math.random(0,V.height-80)
    enemy.width=64
    enemy.height=64
    enemy.color=love.math.random(1,3)
    --    enemy.size=40
    --    enemy.speed=100
    table.insert(self.enemies,enemy)
end

function M:update(dt)
    for i,e in pairs(M.enemiesAll.enemies) do
        -- zadrzavanje ekrana ne update-uje ali nakon pustanja se update-uje za sav dt
        if dt>0.040 then
            return
        end
        if e.x <0-100 then
            table.remove(M.enemiesAll.enemies, i)
        else
            e.x=e.x-V.enemySpeed*dt
        end

    end


    if M.enemiesAll.cooldown<=0 then
        M.enemiesAll.cooldown=50
        M.enemiesAll:spawnEnemies(V.width+50,i)
    end

    -- pauza izmedju spawn-ovanja se smanjuje
    M.enemiesAll.cooldown=M.enemiesAll.cooldown-M.spawnSpeed*dt



    if currentFrameEnemies<16 then
        currentFrameEnemies=currentFrameEnemies+1
    else
        currentFrameEnemies=1
    end

end

function M:draw()
    love.graphics.draw(backgroundSide,-5,-5) -- -5 zbog toga sto se vidi pozadina ako je 0
    love.graphics.draw(backgroundSide,620,-5)
    for i,e in pairs(M.enemiesAll.enemies) do

        love.graphics.draw(I.frames[e.color][currentFrameEnemies],e.x-30,e.y)
    end
    love.graphics.draw(background,175,0)
end

return M