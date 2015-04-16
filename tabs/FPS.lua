FPS = class()

function FPS:init()
    self.fps = 0
    self.weight = 0.05
end

function FPS:draw()
    self.fps = self.weight / DeltaTime + (1-self.weight) * self.fps
    text(math.floor(self.fps).." fps",WIDTH-30,20)
end

