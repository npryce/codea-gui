Row = class(Widget)

function Row:init(args)
    Widget.init(self, args)
    self.contents = Widget.extractList(args)
    self.contentCount = #self.contents
    self.spacing = args.spacing or 0
end

function Row:children()
    return self.contents
end

function Row:requiredSize()
    local maxh = 0
    local totalw = math.max(0, self.spacing * (self.contentCount-1))
    
    for i = 1, self.contentCount do
        local cw, ch = self.contents[i]:requiredSize()
        maxh = math.max(maxh, ch)
        totalw = totalw + cw
    end
    
    return totalw, maxh
end

function Row:layoutContent(width, height)
    local x = 0
    for i = 1, self.contentCount do
        local content = self.contents[i]
        local cw, ch = content:requiredSize()
        content:layout(x, 0, cw, height)
        x = x + cw + self.spacing
    end
end
