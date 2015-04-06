function setup()
    log = DummyLog("Test",true)
    SetScreen(readLocalData("screen","Stars"))
    FPS = 0
end

function SetScreen(title)
    parameter.clear()
    for title, className in pairs(screens) do
        parameter.action("View "..title, function() SetScreen(title) end )
    end

    local className = screens[title]
    screen = className()
    screen.title = title
    saveLocalData("screen", title)
end

function touched(touch)
    if screen.touched ~= nil then
        screen:touched(touch)
    end
end

function keyboard(touch)
    if screen.keyboard ~= nil then
        screen:keyboard(touch)
    end
end

function draw()
    background(255, 255, 255, 255)
    pushStyle()
    screen:draw()
    popStyle()
    text(screen.title,WIDTH-50,40)
    FPS = 0.95*FPS + 0.05 / DeltaTime
    text(math.floor(FPS).." fps",WIDTH-50,20)
end

