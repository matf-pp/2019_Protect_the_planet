V={}


V.width=love.graphics.getWidth()
V.height=love.graphics.getHeight()

V.scoreBullets=0
V.score=0


V.bulletsUsed=0
V.bulletSpeed=400
V.maxBulletSpeed=1000
V.minBulletSpeed=200
V.minBulletCooldown=5


V.playerCooldown=20
V.playerCooldownNew=20



-- pocetna brzina spawn-ovanja enemies
V.spawnSpeed=5
-- pocetna brzina enemies
V.enemySpeed=50
V.maxEnemySpeed=700
V.minEnemySpeed=100
-- vreme nakon kojeg se povecava brzina enemies
V.enemySpeedCooldown=500

V.upgradesAllCooldown=20
V.upgradeSpeed=100


V.gamestate="title"
--V.gameOver=false

V.poravnanjePlayerX=50
V.poravnanjePlayerY=0
V.poravnanjeBulletX=140
V.poravnanjeBulletY=30

V.started=false

return V