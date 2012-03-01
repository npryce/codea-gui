Widget = class()

function Widget:init(args)
    self.x = 0
    self.y = 0
    self.width = 0
    self.height = 0
    self.touched = args.touched
end

function Widget:drawInParent(containerScreenX, containerScreenY)
    local screenx = containerScreenX + self.x
    local screeny = containerScreenY + self.y
    
    pushStyle()
    pushMatrix()
    
    translate(self.x, self.y)
    
    clip(screenx, screeny, self.width, self.height)
    self:draw()
    clip()
    
    self:foreachChild(function (child)
        child:drawInParent(screenx, screeny)
    end)
    
    popMatrix()
    popStyle()
end

function Widget:draw()
    -- override in subclasses
end

function Widget:requiredSize()
    return 0, 0
end

function Widget:layout(x, y, width, height)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    
    self:layoutContent(width, height)
end

function Widget:layoutContent(width, height)
    -- nothing by default
end

function Widget:children()
    return {}
end

function Widget:foreachChild(f)
    for i, widget in ipairs(self:children()) do
        f(widget)
    end
end

function Widget:changed()
    self.container:changed()
end

function Widget.extractList(t)
    local list = {}
    for i, v in ipairs(t) do
        table.insert(list, v)
    end
    return list
end

function Widget.const(value)
    return function()
        return value
    end
end

function Widget:contains(p)
    return p.x >= 0 and p.x < self.width
       and p.y >= 0 and p.y < self.height
end

function Widget.translateTouch(t, dx, dy)
    return {
        id = t.id,
        x = t.x + dx,
        y = t.y + dy,
        prevX = t.prevX + dx,
        prevY = t.prevY + dy,
        deltaX = t.deltaX,
        deltaY = t.deltaY,
        state = t.state,
        tapCount = t.tapCount
    }
end

function Widget:pickInParent(t)
    return self:pick(self.translateTouch(t, -self.x, -self.y))
end


function Widget:pick(t)
    if self:contains(t) then
        for _, child in pairs(self:children()) do
            local pick = child:pickInParent(t)
                    
            if pick then
                return pick
            end
        end
        
        return self.touched and self
    end
    
    return nil
end

function Widget:screenPosition()
    local pos = vec2(self.x, self.y)
    
    local container = self.container
    while container do
        pos = pos + vec2(container.x, container.y)
        container = container.container
    end
    
    return pos
end

function Widget:dispatchTouch(t)
    local sp = self:screenPosition()
    self:touched(self.translateTouch(t, -sp.x, -sp.y))
end