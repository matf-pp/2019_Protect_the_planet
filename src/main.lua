
function love.load()
    P=require "player"
    E=require "enemy"
    C=require "checks"
    V=require "values"
    U=require "upgrades"
    M=require "menu"
    S=require "sound"


    font = love.graphics.newFont("AVENGEANCE HEROIC AVENGER.ttf", 15)
    font1 = love.graphics.newFont("AVENGEANCE HEROIC AVENGER.ttf", 64)
    love.graphics.setFont(font)
    love.graphics.setDefaultFilter("nearest","nearest")
    background=love.graphics.newImage("ironmanb1.png")
    background11=love.graphics.newImage("space.png")



end

function love.update(dt)

    S:update(dt)

    if V.gamestate=="title" then
        if love.keyboard.isDown("return") then
            V.gamestate="play"
            V.started=true
        end
		if love.keyboard.isDown("q") then
			love.event.quit()
		end

        M:update(dt)

		--na esc se moze prekinuti igra tokom pauza menija
		if love.keyboard.isDown("escape") then
			if V.started==true then
				V.gamestate="after"
			end
		end


    --pauza, vraca se na pocetni ekran
    else if V.gamestate=="play" then
		    if love.keyboard.isDown("p") then
                V.gamestate="title"

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

                    love.load()
                end
                if love.keyboard.isDown("q") then
                    love.event.quit()
                end

        end

    end
end




function love.draw()

    if V.gamestate=="title" then
        love.graphics.setBackgroundColor(0,0,0)

        M:draw()


    else if V.gamestate=="play" then
        love.graphics.setBackgroundColor(0,0,0)

        love.graphics.setColor(255,255,255)

        love.graphics.draw(background11,0,0)

        P.player:draw()
        E:draw()
        U:draw()

        love.graphics.printf("score "..V.score,0,40,800,"center")

        love.graphics.setColor(255,255,255)

        love.graphics.printf(P.superPowerCooldownIspis,0,20,800,"center")


    else if V.gamestate=="after" then
            love.graphics.setBackgroundColor(0,255,0)
            love.graphics.draw(background11,0,0)
            love.graphics.setFont(font1)
            love.graphics.printf("score "..V.score,0,V.height/2-font1:getHeight()/2,800,"center")
            love.graphics.setFont(font)
            love.graphics.printf("press enter to play again ",0,V.height/2-font1:getHeight()/2+50,800,"center")
            love.graphics.printf("Developed:\n\nLazar Perisic\n\nMilos Djuric",350,500,100,"center")


        end
        end
    end

    S:draw()
end