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

touchCache = {}

function Draggable:init()
    self.classname = "Draggable"
end

-- static fn
function Draggable:Attach(parent,cbs)
    --print("cbs",cbs)
    if cbs == nil then cbs = {} end
    local draggable = Draggable()
    draggable.parent = parent
    draggable.MoveFn = cbs.Move or 
        function(touch) parent.x=touch.x; parent.y=touch.y end
    --print("ubs ",cbs.IsInside)
    draggable.IsInsideFn = cbs.IsInside or 
        function(touch) return draggable:IsInsideFnDefault(touch) end
    draggable.StartDraggingFn = cbs.StartDragging or
        function() return draggable:StartDraggingFnDefault(touch) end
    parent.SetDraggable = function(s,v) print(s); draggable:SetDraggable(v) end
    parent.IsDraggable = function(s,v) return draggable:IsDraggable() end
    --print("pstd",parent.SetDraggable)
    parent.GetDraggableObj = function() return draggable end
    local parentTouched = parent.touched or NoOp
    parent.ResetTouched = function() parent.touched = parentTouched end
    parent.touched = function(s,touch) 
        parentTouched(s,touch)
        draggable:touched(touch)
    end
end

-- static fn
function Draggable:Detach(parent)
    parent.ResetTouched()
    parent.SetDraggable = NoOp
    parent.GetDraggableObj = NoOp
    parent.ResetTouched = NoOp
end

function Draggable:touched(touch)
--    for i,v in ipairs( self) do
       -- print (i)
--    end
    if not self:IsDraggable() then return end
    if touch.state == BEGAN and touchCache[touch.id] == nil then
        if self.IsInsideFn(touch) then
            touchCache[touch.id] = 1
            self.touch = touch    
            self.StartDraggingFn(touch)
        end
    elseif self:TouchIsValid(touch) then
        if touch.state == ENDED then
            touchCache[touch.id] = nil
            self:StopDragging()
        elseif touch.state == MOVING then
            self:Move(touch)
        end
    end
end

function Draggable:StopDragging()
    if self.parent.dragtween ~= nil then
        tween.reset(self.parent.dragtween)
        self.touch = nil
    end
end

function Draggable:TouchIsValid(touch)
    return self.touch ~= nil and self.touch.id == touch.id
end

-- This one may be overridden if for instance
-- the coordinates are named differently
function Draggable:Move(touch)
    self.MoveFn(touch)
end

-- This one will often be overridden depending on the
-- shape of the object
function Draggable:IsInsideFnDefault(touch)
--  print(parent)
    local distance = (touch.x-self.parent.x)^2+(touch.y-self.parent.y)^2
    local inside = distance < (self.parent.w/3)^2
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
--    print("Fn ",self.parent.classname,value )
    self.isdraggable = value
end

function Draggable:DragIcon(x,y)
    x = x or self.parent.x + self.parent.w/2
    y = y or self.parent.y + self.parent.w/2
    if self:IsDraggable() then
        sprite("Cargo Bot:Command Right",x,y)
    end
end

-- Tween created when dragging starts
function Draggable:StartDraggingFnDefault(touch)
    self.parent.dragtween = tween.path(0.3,self.parent,{{w=self.parent.w},{w=self.parent.w*1.2}},{loop=tween.loop.pingpong})
end




