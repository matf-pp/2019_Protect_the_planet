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

local mute = 0

function love.load()
    P=require "player"
    E=require "enemy"
    C=require "checks"
    V=require "values"
    U=require "upgrades"
    M=require "menu"
	
	saber2 = love.audio.newSource("saber2.mp3","static")
	saber2:setVolume(0.3)
	bkgmusic = love.audio.newSource("bkgmusic.mp3","static")
	bkgmusic:setVolume(0.6)
	boomef = love.audio.newSource("boom.mp3","static")
	boomef:setVolume(0.6)
    font = love.graphics.newFont("AVENGEANCE HEROIC AVENGER.ttf", 15)
    font1 = love.graphics.newFont("AVENGEANCE HEROIC AVENGER.ttf", 64)
    love.graphics.setFont(font)
    love.graphics.setDefaultFilter("nearest","nearest")
    background=love.graphics.newImage("ironmanb1.png")
    --background1=love.graphics.newImage("solar-system-171.png")
    background11=love.graphics.newImage("space.png")
	background12=love.graphics.newImage("spaceboom.png")
	
	--if not love.filesystem.exists("scores.lua") then
		--scores = love.filesystem.newFile("scores.lua")
		--love.filesystem.write("scores.lua", "pera")
	--end
	

	
	

end

function love.update(dt)

	if mute==1 then
		bkgmusic:setVolume(0)
		saber2:setVolume(0)
		boomef:setVolume(0)
	else
		bkgmusic:setVolume(0.6)
		saber2:setVolume(0.3)
		boomef:setVolume(0.6)
	end
    if V.gamestate=="title" then
        if love.keyboard.isDown("return") then
            V.gamestate="play"
        end
		if love.keyboard.isDown("q") then
			love.event.quit()
		end

        M:update(dt)
		
		--na esc se moze prekinuti igra tokom pauza menija
		if love.keyboard.isDown("escape") then
			if V.score > 0 then
				V.gamestate="after"
			end
		end
		
		M:update(dt)
	 
--pauza, vraca se na pocetni ekran
    else if V.gamestate=="play" then
		if love.keyboard.isDown("p") then
            V.gamestate="title"
			M:update(dt)
        end
		if love.keyboard.isDown("m") then
			if mute==0 then
				mute = 1
			else
				mute = 0
			end
		end

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
			if love.keyboard.isDown("q") then
				love.event.quit()
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
		bkgmusic:play()
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
            love.graphics.printf("press enter to play again ",0,V.height/2-font1:getHeight()/2+50,800,"center")

            --love.graphics.printf("score "..V.score,0,V.height/2-font:getHeight()/2,800,"center")
        end
        end
    end
end