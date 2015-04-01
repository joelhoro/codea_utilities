Draggable = class()

-- this is an abstract class, no init

-- standard implementation, usually not overridden
-- except maybe this way
--
--  function SomeClass:touched(touch)
--      if somecondition then
--          Draggable.touched(self,touch)
--          return
--      end
--      
--      -- continue other handling of touch
--

function Draggable:touched(touch)
    if not self:IsDraggable() then return end
    if touch.state == BEGAN then
        if self:IsInside(touch) then
            self.touch = touch    
            self:StartDragging(touch)
        end
    elseif self:TouchIsValid(touch) then
        if touch.state == ENDED then
            self:StopDragging()
        elseif touch.state == MOVING then
            self:Move(touch)
        end
    end
end

function Draggable:StopDragging()
    if self.dragtween ~= nil then
        tween.reset(self.dragtween)
        self.touch = nil
    end
end

function Draggable:TouchIsValid(touch)
    return self.touch ~= nil and self.touch.id == touch.id
end

-- This one may be overridden if for instance
-- the coordinates are named differently
function Draggable:Move(touch)
    self.x = touch.x
    self.y = touch.y
end

-- This one will often be overridden depending on the
-- shape of the object
function Draggable:IsInside(touch)
    local distance = (touch.x-self.x)^2+(touch.y-self.y)^2
    local inside = distance < (self.w/3)^2
    return inside
end

-- Allows to dynamicallly toggle dragging behaviour
-- if overridden
function Draggable:IsDraggable()
    if self.isdraggable ~= nil then
        return self.isdraggable
    else
        return false
    end
end

function Draggable:SetDraggable(value)
    self.isdraggable = value
end

function Draggable:DragIcon(x,y)
    x = x or self.x + self.w/2
    y = y or self.y + self.w/2
    if self:IsDraggable() then
        sprite("Cargo Bot:Command Right",x,y)
    end
end

-- Tween created when dragging starts
function Draggable:StartDragging(touch)
    self.dragtween = tween.path(0.3,self,{{w=self.w},{w=self.w*1.2}},{loop=tween.loop.pingpong})
end


