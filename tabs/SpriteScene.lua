SpriteMap = class()

function SpriteMap:init(img,w,h,i,j)
    self.img = img
    self.w = w
    self.h = h
    self.i = i 
    self.j = j
end

function SpriteMap:draw(x,y)
    pushStyle()
    spriteMode(CORNER)
--    translate(i*w,j*h)
    clip(x,y,self.w,self.h)
    sprite(self.img,x-self.i*self.w,y-self.j*self.h)
    popStyle()
    clip(0,0,1000,1000)
end

SpriteScene = class()

function SpriteScene:init(x)
    parameter.integer("i",0,10)
    parameter.integer("j",0,10)
    parameter.integer("w",10,100)
    parameter.integer("h",10,100)
    i,j = 1,0
    w = 86
    h = 76
    img = "Documents:Sprites"
    spriteMap = SpriteMap(img,w,h,i,j)
    spriteMap2 = SpriteMap(img,w,h,i+1,j+1)
    pos = {x=100,y=100}
    tween(5,pos,{x=600,y=600},tween.easing.quadInOut)
end



function SpriteScene:draw()
    spriteMap:draw(pos.x,pos.y)
    spriteMap2:draw(pos.x/1.4,pos.y+45)
end

function SpriteScene:touched(touch)
    -- Codea does not automatically call this method
end
