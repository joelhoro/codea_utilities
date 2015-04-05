Smoke = class()

function Smoke:init(x,y)
    self.x = x
    self.y = y
    ---- initialization
    self.numberofclouds = 4
    self.clouds = {}
    local cycle = 2.5
    local permutation = {1,4,2,3}

    for i=1,self.numberofclouds do
        local shift = -1+2/self.numberofclouds*permutation[i]
        local cloud = { x=shift,y=0,s=1,r=0 }
        t = tween(cycle,cloud,{y=40,s=2,r=shift*5},{loop=tween.loop.forever,easing=tween.easing.cubicIn})
        tween.sequence(tween.delay(cycle/self.numberofclouds*(i-1)+0.0001),t)
        self.clouds[i] = cloud
    end
end

function Smoke:draw()
    local smoke = "Cargo Bot:Smoke Particle"
    local w = spriteSize(smoke)
    for i,c in ipairs(self.clouds) do
        if c.s>1 then
            local x,y = self.x+c.x*40+0.02*c.x*c.y^2,self.y+c.y
            pushMatrix()
            translate(x,y)
            rotate(math.sin(c.r)*40)
            sprite(smoke,0,0,w*c.s)
            popMatrix()
        end
    end
    
end 

function Smoke:touched(touch)
-- Codea does not automatically call this method
end

-------- ========= SMOKESCREEN ============
SmokeScreen = class()

function SmokeScreen:init()
    self.smoke = Smoke(400,400)   
    parameter.action("start") 
end

function SmokeScreen:draw()
    background(255, 255, 255, 255)
    self.smoke:draw()
end



