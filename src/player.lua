
V=require "values"

local P={}






-- indikator jaceg bullet-a
local strongerBullet=0

local frame

picGore=love.graphics.newImage("iron_gore.png")
picDole=love.graphics.newImage("iron_dole.png")
picPucanje1=love.graphics.newImage("iron_pucanje1.png")
picPucanje2=love.graphics.newImage("iron_pucanje222222.png")
bulletPic=love.graphics.newImage("bullet1.png")
bulletPicStrong=love.graphics.newImage("bulletstrong.png")
picSuper=love.graphics.newImage("iron_strong.png")
picBoom=love.graphics.newImage("boom.png")

frame=picGore

P.superPowerCooldown=0
P.superPowerCooldownIspis="AVAILABLE"


local currentFrame=1




P.player={}


P.player.size=100
P.player.x=0+V.poravnanjePlayerX
P.player.y=V.height/2-P.player.size/2-V.poravnanjePlayerY
P.player.speed=400
P.player.bullets={}




P.player.fire=function()
    if V.playerCooldown<=0 then
        V.playerCooldown=V.playerCooldownNew


        if currentFrame==1 then
            currentFrame=2
            frame=picPucanje1
        elseif currentFrame==2 then
            currentFrame=1
            frame=picPucanje2
        end




        local bullet={}

        bullet.targetsRemaining=4
        if strongerBullet<4 then
            strongerBullet=strongerBullet+1
            bullet.strong=false
            bullet.height=10
            bullet.width=20
            bullet.color=0
        else
            bullet.strong=true
            strongerBullet=0
            bullet.height=40
            bullet.width=30
            bullet.color=1
        end
        bullet.x=P.player.x+V.poravnanjeBulletX
        bullet.y=P.player.y+P.player.size/2-bullet.height/2-V.poravnanjeBulletY

        table.insert(P.player.bullets,bullet)

        return true
    end
    return false
end


function P:update(dt)

    if love.keyboard.isDown("down") then
        if P.player.y<450 then -- uslov ostajanja na ekranu
            --currentFrame=1
            frame=picDole
            P.player.y=P.player.y+P.player.speed*dt
        end
    end
    if love.keyboard.isDown("up") then
        if P.player.y>10 then
            --currentFrame=1
            frame=picGore
            P.player.y=P.player.y-P.player.speed*dt
        end
    end


    if love.keyboard.isDown("space") then
        if(P.player:fire()==true) then
            S.saber2:stop()
            S.saber2:play()
        end
    end




    if P.superPowerCooldown<=0 then
        P.superPowerCooldownIspis="AVAILABLE"

        if love.keyboard.isDown("k") then
            frame=picSuper
            S.boomef:play()

            V.superPowerImage=V.superPowerImageNew
            C.destroyAll(E.enemiesAll.enemies)
            P.superPowerCooldown=20
            P.superPowerCooldownIspis="NOT AVAILABLE"
        end
    end

    for i,b in pairs(P.player.bullets) do
        -- zadrzavanje ekrana ne update-uje ali nakon pustanja se update-uje za sav dt
        if dt>0.040 then
            return
        end
        -- brisemo bullet-e kada izadju sa ekrana
        if b.x >V.width+100 then
            table.remove(P.player.bullets, i)
        else
            b.x=b.x+V.bulletSpeed*dt
        end
    end



    V.superPowerImage=V.superPowerImage-10*dt
    V.playerCooldown=V.playerCooldown-50*dt
    if(P.superPowerCooldown>0) then
        P.superPowerCooldown=P.superPowerCooldown-1*dt
    end
end

function P.player:draw()
    if V.superPowerImage>0 then
        love.graphics.draw(picBoom,175, 130)
    end
    love.graphics.draw(frame,P.player.x,P.player.y,0,0.6)

    for i,b in pairs(self.bullets) do
        if b.color==1 then
            love.graphics.setColor(255,255,255)
            love.graphics.draw(bulletPicStrong,b.x-30,b.y-20)
        else love.graphics.setColor(255,255,255)
            love.graphics.draw(bulletPic,b.x-30,b.y-20)
        end
    end
end

return P