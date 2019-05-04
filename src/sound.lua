local S={}

-- sound managing
S.saber2 = love.audio.newSource("saber2.mp3","static")
S.saber2:setVolume(0.3)

S.bkgmusic = love.audio.newSource("bkgmusic.mp3","static")
S.bkgmusic:setVolume(0.6)
S.bkgmusic:setLooping(true)
S.bkgmusic:play()

S.boomef = love.audio.newSource("boom.mp3","static")
S.boomef:setVolume(0.6)

S.mute=false
S.muteCooldown=20
S.muteCooldownNew=20

function S:update(dt)
    if S.muteCooldown>0 then
        S.muteCooldown=S.muteCooldown-50*dt
    end

    if love.keyboard.isDown("m") then
        if S.muteCooldown<0 then
            if S.mute==false then
                S.mute = true
            else -- if V.mute==true then
                S.mute = false
            end
            S.muteCooldown=S.muteCooldownNew
        end
    end

    if S.mute==true then
        S.bkgmusic:setVolume(0)
        S.saber2:setVolume(0)
        S.boomef:setVolume(0)
    else
        S.bkgmusic:setVolume(0.6)
        S.saber2:setVolume(0.3)
        S.boomef:setVolume(0.6)
    end
end

function S:draw()
    if S.mute==true then
        love.graphics.printf("MUTED",700,20,100,"center")
    end
end

return S