--P=require "player"
--E=require "enemy"
--C=require "checks"
--V=require "values"
--U=require "upgrades"
--M=require "menu"
--local anim8=require "anim8.lua"

gameOver=false

--bulletCooldown=20

--superPowerCooldown=0
--superPowerCooldownIspis="AVAILABLE"

--gamestate="title"



function love.load()
    P=require "player"
    E=require "enemy"
    C=require "checks"
    V=require "values"
    U=require "upgrades"
    M=require "menu"

    font = love.graphics.newFont("AVENGEANCE HEROIC AVENGER.ttf", 15)
    font1 = love.graphics.newFont("AVENGEANCE HEROIC AVENGER.ttf", 64)
    love.graphics.setFont(font)
    love.graphics.setDefaultFilter("nearest","nearest")
    background=love.graphics.newImage("ironmanb1.png")
    background1=love.graphics.newImage("solar-system-171.png")
    background11=love.graphics.newImage("space.png")

end

function love.update(dt)
    if V.gamestate=="title" then
        if love.keyboard.isDown("return") then
            V.gamestate="play"
        end

        M:update(dt)

    else if V.gamestate=="play" then


        P:update(dt)
        E:update(dt)
        U:update(dt)

        C.checkHit(E.enemiesAll.enemies,P.player.bullets)
        C.checkHitUpgrades(U.upgradesAll.upgrades,P.player.bullets)

        else
        --else if V.gamestate=="after" then
            if love.keyboard.isDown("return") then
                package.loaded["enemy"] = nil
                package.loaded["player"] = nil
                package.loaded["upgrades"] = nil
                --package.loaded["menu"] = nil -- ne postavljam na nil da bi se nastavila animacija na menu
                package.loaded["values"] = nil
                --love.graphics.setBackgroundColor(0,0,0)
                love.load()
            end
        --end
        --if V.gameOver==true then
        --    --            love.graphics.print("SCORE: " .. score .. "\nACCURACY: " .. score/bulletsUsed,height/2,width/2)
        --    return
        --end
        --if V.gamestate=="after" then
        --    if love.keyboard.isDown("return") then
        --        V.gamestate="title"
        --        love.load()
        --        love.update()
        --    end
        -- end



        --C.checkHit(E.enemiesAll.enemies,P.player.bullets)
        --C.checkHitUpgrades(U.upgradesAll.upgrades,P.player.bullets)
    end

    end
end


--function love.keypressed(key)
--    if V.gamestate=="after" and key == "return" then
--        V.gamestate="title"
--        package.loaded["enemy"] = nil
--        package.loaded["player"] = nil
--        package.loaded["upgrades"] = nil
--        package.loaded["menu"] = nil
--        package.loaded["values"] = nil
--        love.load()
--        love.draw()
--        --love.event.quit("restart")
--    end
--end


function love.draw()

    if V.gamestate=="title" then
        love.graphics.setBackgroundColor(0,0,0)
        --M:draw()
        --love.graphics.draw(background,175,0)
        --love.graphics.draw(background1,0,0)
        M:draw()
        ----love.graphics.scale(5,1)
        --love.graphics.setFont(font1)
        --love.graphics.printf("score "..V.score,0,V.height/2-font1:getHeight()/2,800,"center")
        --love.graphics.setFont(font)
        --love.graphics.printf("press enter to return to menu ",0,V.height/2-font1:getHeight()/2+50,800,"center")

    else if V.gamestate=="play" then
        love.graphics.setBackgroundColor(0,0,0)

        love.graphics.setColor(255,255,255)
        --love.graphics.scale(2,2)
        love.graphics.draw(background11,0,0)

        P.player:draw()
        E:draw()
        U:draw()
        --love.graphics.print("score "..V.score,V.width/2-40,40)
        love.graphics.printf("score "..V.score,0,40,800,"center")
        --love.graphics.printf(P.superPowerCooldown,0,100,800,"center")
        love.graphics.setColor(255,255,255)
        --love.graphics.print(P.superPowerCooldownIspis,V.width/2-40,20)
        love.graphics.printf(P.superPowerCooldownIspis,0,20,800,"center")
        --love.graphics.print(P.bulletSpeed,600,0)
        --        love.graphics.print(bulletCooldownRemain,600,100)
        --love.graphics.print(player.cooldownNew,600,100)
        --accuracy=score/bulletsUsed
        --        love.graphics.print("SCORE: " .. score .. "\nACCURACY: " .. accuracy.."\n".. height..width,love.graphics.getWidth/2-font:getWidth("SCORE: " .. score .. "\nACCURACY: " .. accuracy.."\n".. height..width)/2,height/2)
        --love.graphics.printf("SCORE: " .. score .. "\nACCURACY: " .. accuracy.."\n".. height..width.."\nSCORE: " .. score .. "\nACCURACY: " .. accuracy.."\n".. height..width,0,300-1.5*font:getHeight(),800,"center")

    else if V.gamestate=="after" then
            love.graphics.setBackgroundColor(0,255,0)
            love.graphics.draw(background11,0,0)
            love.graphics.setFont(font1)
            love.graphics.printf("score "..V.score,0,V.height/2-font1:getHeight()/2,800,"center")
            love.graphics.setFont(font)
            love.graphics.printf("press enter to return to menu ",0,V.height/2-font1:getHeight()/2+50,800,"center")

            --love.graphics.printf("score "..V.score,0,V.height/2-font:getHeight()/2,800,"center")
        end
        end
    end
end