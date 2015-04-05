
Star = class()

function Star:Move(touch)
    self.x = touch.x
--    self.y = touch.y
    self.r =- touch.x
end

function Star:init(x,y,w,r)
    self.x = x
    self.y = y
    self.w = w
    self.r = 0
    self.ready=false
end

function Star:AttachDraggable()
    Draggable:Attach(self)
         --   Move = function(touch) self.x=touch.x end,
         --   IsInside = function(touch) [check distance] end     --} ) 
    self:SetDraggable(true)
   -- Draggable:Detach(self)
end

function Star:DetachDraggable()
    Draggable:Detach(self)
end

function Star:Activate()
    local w = self.w
    self.w=self.w/5
    self.ready = false
    tween(0.5,self,{w=w, r=self.r-360},tween.easing.cubicOut,function() self.ready=true end)
end

function Star:Spiral(x,y,w)
    self.r=360
    tween(3,self,{x=x,y=y,w=w,r=0},tween.easing.cubicInOut)
end


function Star:draw()
    pushMatrix()
    pushStyle()
    local x,y=0,0 -- needed some tweaking
    translate(self.x+x,self.y+y)
    rotate(self.r)
    translate(-self.x-x,-self.y-y)
    -- spriteMode(RADIUS)
    sprite("Cargo Bot:Star Filled",self.x,self.y,self.w)
    popMatrix()
    popStyle()
  --  self:DragIcon()
end

----- STARSCREEN ------

StarScreen = class()

function StarScreen:init()    
    parameter.action("regroup",function() self:MakeSpiral() end)
    parameter.action("disperse",function() self:disperse() end)
    parameter.action("detach",function() self:detach() end)
    self:disperse()    
end


function StarScreen:MakeSpiral()
    pos = {200,300,400,500,600,700}
    for i,v in ipairs(self.stars) do
        v:AttachDraggable(true)
        v:Activate()
    end
end

function StarScreen:detach()
    for i,v in ipairs(self.stars) do
        v:DetachDraggable()
    end
end

function StarScreen:disperse()
    self.stars = {
        Star(100,600,100,0),
        Star(600,200,100,0),
        Star(200,250,100,0),
        Star(250,550,100,0),
        Star(100,150,100,0),
        Star(700,650,100,0),    
    }
 --   log:printTable(self.stars)
    self:MakeSpiral()

end

function StarScreen:touched(touch)
    if touch.tapCount >1 then
   --     spiral()
    end
    for i,star in ipairs(self.stars) do
        star:touched(touch)
    end
end



function StarScreen:draw()
    background(255, 255, 255, 255)

    for i,v in ipairs(self.stars) do
        v:draw()
    end    
end


