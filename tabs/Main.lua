-- test2

A = class()

function A:init()
    self.x = 999
end

-- Use this function to perform your initial setup
function setup()
    log = DummyLog("Test",true)
    smoke =Smoke(400,400)
    -- hello - p()
    parameter.action("regroup",spiral)
    parameter.action("disperse",disperse)
    parameter.action("detach",detach)
  --  star1:activate()
    cb = function(z) star.z=z;star:Activate();print("xxx") end
  --  cb = function() end
 --   parameter.number("x",-0.3,0.3,0,cb)
    obj = {r=0}  
    tween(5,obj,{r=360*20},tween.easing.quadInOut)

    disperse()
    parameter.number("x",1,250)
        
end



function makespiral()
    pos = {200,300,400,500,600,700}
    for i,v in ipairs(stars) do
        v:AttachDraggable(true)
        v:Activate()
    end
end

function detach()
    for i,v in ipairs(stars) do
        v:DetachDraggable()
    end
end

function disperse()
    stars = {
        Star(100,600,100,0),
        Star(600,200,100,0),
        Star(200,250,100,0),
        Star(250,550,100,0),
        Star(100,150,100,0),
        Star(700,650,100,0),    
    }
    log:printTable(stars)
    makespiral()

end

function drawstars()
    for i,v in ipairs(stars) do
        v:draw()
    end
end


function permute(t)
    local t2 = {}
    for i,v in ipairs(t) do
        t2[i]={v,math.random()}
    end
    table.sort(t2,function(x,y) return x[2]<y[2] end )
    local t3 = {}
    for i,v in ipairs(t2) do
        t3[i]=v[1]
    end
    print(t3[1].x)
    return t3
end

function spiral()
    stars = permute(stars)
    for i,v in ipairs(stars) do
        v:Spiral(pos[i],400)
    end
end

function unit(rho)
    rho = rho / 180 * math.pi
    return vec2(math.cos(rho),math.sin(rho))
end
function drawarc(x,y,r,a1,a2)
    c = vec2(x,y)
    drho = 10
    n = (a2-a1)/drho
    local rho = a1
    p = c + unit(a1)*r
    for i = 1,n do
        rho = rho + drho 
        p2 = c + unit(rho)*r
        line(p.x,p.y,p2.x,p2.y)
        p=p2
    end
end

function touched(touch)
    --print(touch)
    if touch.tapCount >1 then
   --     spiral()
    end
    for i,star in ipairs(stars) do
        star:touched(touch)
    end
end


-- This function gets called once every frame
function draw()
     background(189, 151, 151, 255)
--   ellipse(400,400,100)
    strokeWidth(5)
    stroke(33, 28, 28, 255)
    --smoke:draw()
    local r1,r2=obj.r,obj.r-100
    if r1>r2 then
        r1,r2=r2,r1
    end
  --  drawarc(300,300,50,r1,r2)
    drawstars()
    font("Baskerville-SemiBold")
 --   fontMetrics()
    fill(246, 8, 8, 255)
    fontSize(50)
    fontSize(x)
   -- text3D("Hello world",300,600,100,100)
    -- This sets a dark background color 
    -- Do your drawing here
end

