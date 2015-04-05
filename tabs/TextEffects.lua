TextEffects = class()

function TextEffects:init(t)
    parameter.text("Text",function(t) self:SetText(t) end )
    SetText(t)
end

function TextEffects:draw()
    
    -- Codea does not automatically call this method
end

function TextEffects:SetText(t)
    self.text = t
    print(#t)
end

function TextEffects:touched(touch)
    -- Codea does not automatically call this method
end
