TintScene = class(Scene)

function TintScene:init(x)
    parameter.integer("x",0,256,function(v) self:ChangeTint(v) end)
    self.tint = 0
--
 --   tween(1,self,{tint=255},{loop=tween.loop.pingpong})
    -- you can accept and set parameters here
end

function TintScene:ChangeTint(v)
   self.tint = v 
end

function TintScene:draw()
--    blendMode(MULTIPLY)
--    blendMode(NORMAL)
    tint(255,255,255, self.tint)
    sprite("Small World:House White",500,500)
end

function TintScene:touched(touch)
    -- Codea does not automatically call this method
end
