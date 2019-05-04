--V=require "values"

local C={}


-- proveravamo pogotke i mete koje su pogodjene brisemo iz tabele
-- svaki cetvrti bullet moze da unisti 4 mete
function C.checkHit(enemies,bullets)
    for i,enemy in pairs(enemies) do
        for j,bullet in pairs(bullets) do
            if (enemy.y<bullet.y) and (enemy.y+enemy.height>bullet.y ) and (enemy.x<=bullet.x+bullet.width) then
                if(bullet.strong==true) and (bullet.targetsRemaining>1) then
                    table.remove(enemies,i)
                    V.score=V.score+1
                    V.scoreBullets=V.scoreBullets+1
                    bullet.targetsRemaining=bullet.targetsRemaining-1
                else
                    table.remove(enemies,i)
                    V.score=V.score+1
                    V.scoreBullets=V.scoreBullets+1
                    table.remove(bullets,j)
                end
            end
        end
    end
end

function C.destroyAll(enemies)
    for i,enemy in pairs(enemies) do
        if enemy.x>0 then
            enemies[i]=nil
            V.score=V.score+1
        end
    end
end


function C.checkHitUpgrades(upgrades,bullets)
    for i,upgrade in pairs(upgrades) do
        for j,bullet in pairs(bullets) do
            if (upgrade.y<bullet.y) and (upgrade.y+upgrade.height>bullet.y ) and (upgrade.x+upgrade.width>=bullet.x+bullet.width) and (upgrade.x<bullet.x+bullet.width) then
                if (bullet.strong==true) and (bullet.targetsRemaining>1) then
                    if upgrade.type==1 then
                        if (V.bulletSpeed<V.maxBulletSpeed) then
                            V.bulletSpeed=V.bulletSpeed+50
                        end
                    elseif upgrade.type==2 then
                        if (V.bulletSpeed>V.minBulletSpeed) then
                            V.bulletSpeed=V.bulletSpeed-50
                        end
                    elseif upgrade.type==3 then
                        if (V.enemySpeed<V.maxEnemySpeed) then
                            V.enemySpeed=V.enemySpeed+10
                        end
                    elseif upgrade.type==4 then
                        if (V.enemySpeed>V.minEnemySpeed) then
                            V.enemySpeed=V.enemySpeed-20
                        end
                    elseif upgrade.type==5 then
                        if (V.playerCooldownNew>V.minBulletCooldown) then
                            V.playeroColdownNew=V.playerCooldownNew-1
                        end
                    end

                    table.remove(upgrades,i)
                    bullet.targetsRemaining=bullet.targetsRemaining-1
                else
                    if upgrade.type==1 then
                        if (V.bulletSpeed<V.maxBulletSpeed) then
                            V.bulletSpeed=V.bulletSpeed+50
                        end
                    elseif upgrade.type==2 then
                        if (V.bulletSpeed>V.minBulletSpeed) then
                            V.bulletSpeed=V.bulletSpeed-50
                        end
                    elseif upgrade.type==3 then
                        if (V.enemySpeed<V.maxEnemySpeed) then
                            V.enemySpeed=V.enemySpeed+10
                        end
                    elseif upgrade.type==4 then
                        if (V.enemySpeed>V.minEnemySpeed) then
                            V.enemySpeed=V.enemySpeed-20
                        end
                    elseif upgrade.type==5 then
                        if (V.playerCooldownNew>V.minBulletCooldown) then
                            V.playeroColdownNew=V.playerCooldownNew-1
                        end
                    end
                    table.remove(upgrades,i)
                    table.remove(bullets,j)
                end
            end
        end
    end
end


return C