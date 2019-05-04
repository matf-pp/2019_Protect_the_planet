V=require "values"

local U={}


U.upgradesAll={}
U.upgradesAll.upgrades={}
local upgradePics={}

upgradePics[1]=love.graphics.newImage("gift1.png")
upgradePics[2]=love.graphics.newImage("gift21.png")
upgradePics[3]=love.graphics.newImage("gift31.png")
upgradePics[4]=love.graphics.newImage("gift41.png")
upgradePics[5]=love.graphics.newImage("gift51.png")

function U.upgradesAll:spawnUpgrades()
    local upgrade={}
    upgrade.x=love.math.random(200,V.width)
    upgrade.y=-50
    upgrade.width=32
    upgrade.height=32
    upgrade.speed=100
    upgrade.type=love.math.random(1,5)
    --    upgrade.type=1="shooting speed upgrade"
    --    upgrade.type=2="shooting speed downgrade"
    --    upgrade.type=3="enemy speed upgrade"
    --    upgrade.type=4="enemy speed downgrade"
    --    upgrade.type=5="bullet cooldown upgrade"
    table.insert(self.upgrades,upgrade)
end

function U:update(dt)

    for i,u in pairs(U.upgradesAll.upgrades) do
        -- zadrzavanje ekrana ne update-uje ali nakon pustanja se update-uje za sav dt
        if dt>0.040 then
            return
        end
        if u.y >V.height+10 then
            table.remove(U.upgradesAll.upgrades,i)
        else
            u.y=u.y+V.upgradeSpeed*dt
        end
    end

    --spawn-ovanje upgrades
    if V.upgradesAllCooldown<=0 then
        V.upgradesAllCooldown=20
        U.upgradesAll:spawnUpgrades()
    end

    --smanjujemo cooldown upgrade-a da bi se spawn-ovo nakon odredjenog vremena
    V.upgradesAllCooldown=V.upgradesAllCooldown-5*dt

end

function U:draw()
    for i,u in pairs(U.upgradesAll.upgrades) do
        --        love.graphics.rectangle("fill",e.x,e.y,enemy.size,enemy.size)
        --        love.graphics.draw(activeFrame,e.x,e.y)
        --        love.graphics.draw(activeFrame,e.x-30,e.y)
        love.graphics.draw(upgradePics[u.type],u.x,u.y)
    end
end

return U