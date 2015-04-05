Text3DScreen = class()

function Text3DScreen:init()
    parameter.number("fontsize",1,250,function(s) self.fontsize=s end)
    self.fontsize = 50    
end

function Text3DScreen:draw()
    background(255, 255, 255, 255)
    font("Baskerville-SemiBold")
    fill(148, 74, 176, 255)
    fontSize(self.fontsize)
    text3D("Hello world",300,600,100,100)
end

----- =============== ArcScreen ===============
ArcScreen = class()

function unit(rho)
    rho = rho / 180 * math.pi
    return vec2(math.cos(rho),math.sin(rho))
end

function drawarc(x,y,r,a1,a2)
    local c = vec2(x,y)
    local drho = 10
    local n = (a2-a1)/drho
    local rho = a1
    local p = c + unit(a1)*r
    for i = 1,n do
        rho = rho + drho 
        p2 = c + unit(rho)*r
        line(p.x,p.y,p2.x,p2.y)
        p=p2
    end
end

function ArcScreen:init()
    self.obj = {r=0}  
    tween(5,self.obj,{r=360*20},tween.easing.quadInOut)
end

function ArcScreen:draw()
    background(255, 255, 255, 255)
    strokeWidth(5)
    stroke(33, 28, 28, 255)
 --   print(smoke.draw())
    --smoke:draw()
    local r1,r2=self.obj.r,self.obj.r-100
    if r1>r2 then
        r1,r2=r2,r1
    end
    drawarc(300,300,50,r1,r2)
end


screens = {
    Stars = StarScreen,
    Smoke = SmokeScreen,
    Text3D = Text3DScreen,
    Arcs = ArcScreen,
    TextEffects = TextEffectsScreen
}

