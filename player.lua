--E=require "enemy"
--C=require "checks"
V=require "values"

local P={}




--scoreBullets=0
--bulletsUsed=0
----bulletSpeed=400
--maxBulletSpeed=1000
--minBulletSpeed=200
--maxEnemySpeed=700
--minEnemySpeed=100
--minBulletCooldown=5


--local poravnanjePlayerX=50
--local poravnanjePlayerY=0
--local poravnanjeBulletX=140
--local poravnanjeBulletY=30


-- indikator jaceg bullet-a
local strongerBullet=0
--P.bulletSpeed=1
local frame

local k=0


picGore=love.graphics.newImage("iron_gore.png")
picDole=love.graphics.newImage("iron_dole.png")
picPucanje1=love.graphics.newImage("iron_pucanje1.png")
picPucanje2=love.graphics.newImage("iron_pucanje222222.png")
picIzmedjuPucanja=love.graphics.newImage("iron_izmedjupucanja.png")
bulletPic=love.graphics.newImage("bullet1.png")
bulletPicStrong=love.graphics.newImage("bulletstrong.png")
picSuper=love.graphics.newImage("iron_strong.png")
--picBoom=love.graphics.newImage("boom.png")
frame=picGore
--bulletCooldown=20

P.superPowerCooldown=0
P.superPowerCooldownIspis="AVAILABLE"


local currentFrame=1

--local width=love.graphics.getWidth()
--local height=love.graphics.getHeight()

P.player={}

--P.player.cooldown=20
P.player.size=100
P.player.x=0+V.poravnanjePlayerX
P.player.y=V.height/2-P.player.size/2-V.poravnanjePlayerY
P.player.speed=400
P.player.bullets={}
--P.player.cooldownNew=20
--    player.bulletSpeed=400


P.player.fire=function()
    if V.playerCooldown<=0 then
        V.playerCooldown=V.playerCooldownNew

        -- sa frame-om pre pucanja
        -- promeniti if currentFrame==3 or currentFrame==5
        --if currentFrame==1 or currentFrame==5 then
        --    currentFrame=2
        --    frame=picPrePucanja
        --elseif currentFrame==2 then
        --    currentFrame=3
        --    frame=picPucanje1
        --elseif currentFrame==3 then
        --    currentFrame=4
        --    frame=picIzmedjuPucanja
        --elseif currentFrame==4 then
        --    currentFrame=5
        --    frame=picPucanje2
        --end

        --ova-sa frame-om izmedju pucanja samo pre pucanja1 (nakon pucanja2)
        -- promeniti if currentFrame==2 or currentFrame==4
        --if currentFrame==1 or currentFrame==4 then
        --    currentFrame=2
        --    frame=picPucanje1
        --elseif currentFrame==2 then
        --    currentFrame=3
        --    frame=picIzmedjuPucanja
        --elseif currentFrame==3 then
        --    currentFrame=4
        --    frame=picPucanje2
        --end

        ----sa frame-om pre pucanja i pre pucanja1 i pre pucanja2
        --if currentFrame==1 or currentFrame==5 then
        --    currentFrame=2
        --    frame=picIzmedjuPucanja
        --elseif currentFrame==2 then
        --    currentFrame=3
        --    frame=picPucanje1
        --elseif currentFrame==3 then
        --    currentFrame=4
        --    frame=picIzmedjuPucanja
        --elseif currentFrame==4 then
        --    currentFrame=5
        --    frame=picPucanje2
        --end


        --ova-sa frame-om pre pucanja izmedju pucanja1 i pucanja2
        -- promeniti if currentFrame==2 or currentFrame==4
        --if currentFrame==1 then
        --    currentFrame=2
        --    frame=picPucanje1
        --elseif currentFrame==2 then
        --    currentFrame=3
        --    frame=picIzmedjuPucanja
        --elseif currentFrame==3 then
        --    currentFrame=4
        --    frame=picPucanje2
        --elseif currentFrame==4 then
        --    currentFrame=1
        --    frame=picIzmedjuPucanja
        --end

        -- bez frame-a pre pucanja
        -- promeniti if currentFrame==2 or currentFrame==4 izbaciti
        if currentFrame==1 then
            currentFrame=2
            frame=picPucanje1
        elseif currentFrame==2 then
            currentFrame=1
            frame=picPucanje2
        end

        --if currentFrame==2 or currentFrame==4 then

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
        --bulletsUsed=bulletsUsed+1
        table.insert(P.player.bullets,bullet)
        --end
    end
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
        P.player:fire()
		saber2:play()
    end


    if P.superPowerCooldown<=0 then
        P.superPowerCooldownIspis="AVAILABLE"

        if love.keyboard.isDown("k") then
            --love.graphics.draw(background12,0,0)
			
			frame=picSuper
			boomef:play()
			
            --        destroyAll(enemiesAll.enemies)

            C.destroyAll(E.enemiesAll.enemies)
			k=20
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




    V.playerCooldown=V.playerCooldown-50*dt
    if(P.superPowerCooldown>0) then
        P.superPowerCooldown=P.superPowerCooldown-1*dt
    end
end

function P.player:draw()
    love.graphics.draw(frame,P.player.x,P.player.y,0,0.6)
	if k>0 then
		love.graphics.draw(picBoom,175, 130)
		k=k-1
	end
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