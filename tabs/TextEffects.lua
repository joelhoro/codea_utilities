TextEffects = class()


function TextEffects:init(t)
    parameter.text("Text",function(t) self:SetText(t) end )
    self:SetText(t)
    Text = t
    self.fontsize = 50
    parameter.integer("Fontsize",1,250,50,function(fs) self.fontsize=fs end)
end

function TextEffects:draw()
    local y = 500
    local x = 300
    pushStyle()
    fontSize(self.fontsize)
    for i,l in ipairs(self.letters) do
        if l == "l" then w=0.6 else w=1 end
        x = x + fontSize()/1.7 * w
        text(l,x,y)
    end
    popStyle()
end

function TextEffects:SetText(t)
    self.text = t
    self.letters = {}
    self.shifts = {}
    for i=1,string.len(t) do
        self.letters[i]=string.sub(t,i,i)
        self.shifts[i]=0
    end
end

function TextEffects:touched(touch)
end


---- =============== TextEffectsScreen ===================

TextEffectsScreen = class()

function TextEffectsScreen:init()
    self.texteffect = TextEffects("Hello")
end

function TextEffectsScreen:draw()
    self.texteffect:draw()
end
