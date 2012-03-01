Screen = class()

function Screen:init(args)
    self.content = args[1]
    self.content.container = self
    self.needsLayout = true
    self.picked = {}
end

function Screen:draw()
    if self.needsLayout then
        self:layout()
    end
    self.content:drawInParent(0, 0)
end

function Screen:layout()
    self.content:layout(0, 0, WIDTH, HEIGHT)
    self.needsLayout = false
end

function Screen:changed()
    self.needsLayout = true
end

function Screen:touched(t)
    local picked
    if t.state == BEGAN then
        picked = self.content:pick(t)
        self.picked[t.id] = picked
    else
        picked = self.picked[t.id]
    end
    
    if picked then
        picked:dispatchTouch(t)
        if t.state == ENDED or t.state == CANCELLED then
            self.picked[t.id] = nil
        end
    end
end

