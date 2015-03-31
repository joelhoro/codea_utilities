-- Class that does nothing, useful to be used before
-- the real object is set without breaking anything

Dummy = class()

function Dummy:init()
end

function Dummy:draw()
end

function Dummy:touched(touch)
end

