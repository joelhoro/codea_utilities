
Star = class(Draggable)

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
    self:DragIcon()
end

