--V=require "values"
I=require "img"
local M={}


M.enemiesAll={}
M.enemiesAll.enemies={}
M.enemiesAll.cooldown=50
M.spawnSpeed=200

local frames={}
local currentFrameEnemies=1
-- pocetna brzina enemies
--E.enemySpeed=50

-- vreme nakon kojeg se povecava brzina enemies
--local enemySpeedCooldown=500

--frames[1]=love.graphics.newImage("small/a10015.png")
--frames[2]=love.graphics.newImage("small/a10014.png")
--frames[3]=love.graphics.newImage("small/a10013.png")
--frames[4]=love.graphics.newImage("small/a10012.png")
--frames[5]=love.graphics.newImage("small/a10011.png")
--frames[6]=love.graphics.newImage("small/a10010.png")
--frames[7]=love.graphics.newImage("small/a10009.png")
--frames[8]=love.graphics.newImage("small/a10008.png")
--frames[9]=love.graphics.newImage("small/a10007.png")
--frames[10]=love.graphics.newImage("small/a10006.png")
--frames[11]=love.graphics.newImage("small/a10005.png")
--frames[12]=love.graphics.newImage("small/a10004.png")
--frames[13]=love.graphics.newImage("small/a10003.png")
--frames[14]=love.graphics.newImage("small/a10002.png")
--frames[15]=love.graphics.newImage("small/a10001.png")
--frames[16]=love.graphics.newImage("small/a10000.png")

-------------------------------------------------
-- ponavljanje istog load-a (u menu i enemy) premesteno u svoj module

--frames[1]={}
--frames[2]={}
--frames[3]={}
--
--frames[1][1]=love.graphics.newImage("small/a10015.png")
--frames[1][2]=love.graphics.newImage("small/a10014.png")
--frames[1][3]=love.graphics.newImage("small/a10013.png")
--frames[1][4]=love.graphics.newImage("small/a10012.png")
--frames[1][5]=love.graphics.newImage("small/a10011.png")
--frames[1][6]=love.graphics.newImage("small/a10010.png")
--frames[1][7]=love.graphics.newImage("small/a10009.png")
--frames[1][8]=love.graphics.newImage("small/a10008.png")
--frames[1][9]=love.graphics.newImage("small/a10007.png")
--frames[1][10]=love.graphics.newImage("small/a10006.png")
--frames[1][11]=love.graphics.newImage("small/a10005.png")
--frames[1][12]=love.graphics.newImage("small/a10004.png")
--frames[1][13]=love.graphics.newImage("small/a10003.png")
--frames[1][14]=love.graphics.newImage("small/a10002.png")
--frames[1][15]=love.graphics.newImage("small/a10001.png")
--frames[1][16]=love.graphics.newImage("small/a10000.png")
--
--frames[2][1]=love.graphics.newImage("small/a30015.png")
--frames[2][2]=love.graphics.newImage("small/a30014.png")
--frames[2][3]=love.graphics.newImage("small/a30013.png")
--frames[2][4]=love.graphics.newImage("small/a30012.png")
--frames[2][5]=love.graphics.newImage("small/a30011.png")
--frames[2][6]=love.graphics.newImage("small/a30010.png")
--frames[2][7]=love.graphics.newImage("small/a30009.png")
--frames[2][8]=love.graphics.newImage("small/a30008.png")
--frames[2][9]=love.graphics.newImage("small/a30007.png")
--frames[2][10]=love.graphics.newImage("small/a30006.png")
--frames[2][11]=love.graphics.newImage("small/a30005.png")
--frames[2][12]=love.graphics.newImage("small/a30004.png")
--frames[2][13]=love.graphics.newImage("small/a30003.png")
--frames[2][14]=love.graphics.newImage("small/a30002.png")
--frames[2][15]=love.graphics.newImage("small/a30001.png")
--frames[2][16]=love.graphics.newImage("small/a30000.png")
--
--frames[3][1]=love.graphics.newImage("small/a40015.png")
--frames[3][2]=love.graphics.newImage("small/a40014.png")
--frames[3][3]=love.graphics.newImage("small/a40013.png")
--frames[3][4]=love.graphics.newImage("small/a40012.png")
--frames[3][5]=love.graphics.newImage("small/a40011.png")
--frames[3][6]=love.graphics.newImage("small/a40010.png")
--frames[3][7]=love.graphics.newImage("small/a40009.png")
--frames[3][8]=love.graphics.newImage("small/a40008.png")
--frames[3][9]=love.graphics.newImage("small/a40007.png")
--frames[3][10]=love.graphics.newImage("small/a40006.png")
--frames[3][11]=love.graphics.newImage("small/a40005.png")
--frames[3][12]=love.graphics.newImage("small/a40004.png")
--frames[3][13]=love.graphics.newImage("small/a40003.png")
--frames[3][14]=love.graphics.newImage("small/a40002.png")
--frames[3][15]=love.graphics.newImage("small/a40001.png")
--frames[3][16]=love.graphics.newImage("small/a40000.png")

------------------------------------------------------------------


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
        --        love.graphics.rectangle("fill",e.x,e.y,enemy.size,enemy.size)
        --        love.graphics.draw(activeFrame,e.x,e.y)
        --        love.graphics.draw(activeFrame,e.x-30,e.y)
        --love.graphics.draw(frames[currentFrameEnemies],e.x-30,e.y)
        love.graphics.draw(I.frames[e.color][currentFrameEnemies],e.x-30,e.y)
    end
    love.graphics.draw(background,175,0)
end

return M