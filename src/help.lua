local H={}





function H:draw()

    font = love.graphics.newFont("AVENGEANCE HEROIC AVENGER.ttf", 15)
    font1 = love.graphics.newFont("AVENGEANCE HEROIC AVENGER.ttf", 32)
    local upgradePics={}
    upgradePics[1]=love.graphics.newImage("gift1.png")
    upgradePics[2]=love.graphics.newImage("gift21.png")
    upgradePics[3]=love.graphics.newImage("gift31.png")
    upgradePics[4]=love.graphics.newImage("gift41.png")
    upgradePics[5]=love.graphics.newImage("gift51.png")


    background=love.graphics.newImage("space.png")
    love.graphics.setBackgroundColor(0,0,0)
    love.graphics.draw(background,0,0)
    love.graphics.setColor(255,255,255)
    love.graphics.setFont(font1)
    love.graphics.printf("Controls\n\n\n",0,40,400,"center")
    love.graphics.setFont(font)
    love.graphics.printf("arrow up - Move up\n\narrow down - Move down\n\nSPACE - Shoot\n\nK - Super power\n\nM - Mute\n\nP - Pause\n\nQ - Quit\n\nESC - While paused, finish current instance of game",0,120,400,"center")

    love.graphics.setFont(font1)
    love.graphics.printf("Upgrades & Downgrades\n\n\n",400,40,400,"center")
    love.graphics.setFont(font)
    love.graphics.draw(upgradePics[1],500,120)
    love.graphics.printf("shooting speed upgrade",400,130,400,"center")
    love.graphics.draw(upgradePics[4],500,160)
    love.graphics.printf("enemy speed downgrade",400,170,400,"center")
    love.graphics.draw(upgradePics[5],500,200)
    love.graphics.printf("bullet cooldown upgrade",400,210,400,"center")
    love.graphics.draw(upgradePics[2],500,240)
    love.graphics.printf("shooting speed downgrade",400,250,400,"center")
    love.graphics.draw(upgradePics[3],500,280)
    love.graphics.printf("enemy speed upgrade",400,290,400,"center")

    love.graphics.setFont(font1)
    love.graphics.printf("Goal\n\n\n",0,400,800,"center")
    love.graphics.setFont(font)
    love.graphics.printf("Destroy as many as possible incoming targets before they get to you.\n\nEvery fifth bullet destroy up to four targets.\n\nSuper power has approximately 20 seconds cooldown.",40,450,720,"center")

    love.graphics.printf("Press H to exit",0,580,800,"center")
end

return H