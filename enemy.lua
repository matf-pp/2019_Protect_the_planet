
local E={}


E.enemiesAll={}
E.enemiesAll.enemies={}
E.enemiesAll.cooldown=50

local frames={}
local currentFrameEnemies=1





function E.enemiesAll:spawnEnemies(x)
    local enemy={}
    enemy.x=x

    enemy.y=love.math.random(0,V.height-150)
    enemy.width=64
    enemy.height=64
    enemy.color=love.math.random(1,3)

    table.insert(self.enemies,enemy)
end

function E:update(dt)
    for i,e in pairs(E.enemiesAll.enemies) do
        -- zadrzavanje ekrana ne update-uje ali nakon pustanja se update-uje za sav dt
        if dt>0.040 then
            return
        end
        if e.x <0-100 then
            table.remove(E.enemiesAll.enemies, i)
        else
            e.x=e.x-V.enemySpeed*dt
        end

        -- provera da li je enemies stigao do nas
        if e.x<100 then
            V.gameOver=true
            V.gamestate="after"
        end
    end

    -- povecava se brzina enemies-a
    if V.enemySpeedCooldown<=0 then
        V.enemySpeedCooldown=500
        if V.enemySpeed<500 then
            V.enemySpeed=V.enemySpeed+10
        end
    end

    V.enemySpeedCooldown=V.enemySpeedCooldown-10*dt


    if E.enemiesAll.cooldown<=0 then
        E.enemiesAll.cooldown=50
        E.enemiesAll:spawnEnemies(V.width+50,i)
    end

    -- pauza izmedju spawn-ovanja se smanjuje
    E.enemiesAll.cooldown=E.enemiesAll.cooldown-V.spawnSpeed*dt

    -- povecava se brzina spawn-ovanja enemies-a
    if V.spawnSpeed<200 then
        V.spawnSpeed=V.spawnSpeed+1*dt
    end

    if currentFrameEnemies<16 then
        currentFrameEnemies=currentFrameEnemies+1
    else
        currentFrameEnemies=1
    end

end

function E:draw()
    for i,e in pairs(E.enemiesAll.enemies) do

        love.graphics.draw(I.frames[e.color][currentFrameEnemies],e.x-30,e.y)
    end
end

return E