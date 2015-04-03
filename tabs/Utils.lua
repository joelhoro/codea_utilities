function text3D(t,x,y)
    text(t,x,y)
    local r,g,b,a = fill()
    fill(r,g,b,a/2)
    local s = fontSize()
    print(s)
    local shift = s / 30
    text(t,x+shift,y-shift/2)
end

function p()
    print("hi")
end

function NoOp() end