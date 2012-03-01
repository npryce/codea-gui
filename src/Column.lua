Column = class(Widget)

function Column:init(args)
    Widget.init(self, args)
    self.contents = Widget.extractList(args)
    self.contentCount = #self.contents
    self.spacing = args.spacing or 0
end

function Column:children()
    return self.contents
end

function Column:requiredSize()
    local maxw = 0
    local totalh = math.max(0, self.spacing * (self.contentCount-1))
    
    for i = self.contentCount, 1, -1 do
        local cw, ch = self.contents[i]:requiredSize()
        maxw = math.max(maxw, cw)
        totalh = totalh + ch
    end
    
    return maxw, totalh
end

function Column:layoutContent(width, height)
    local y = 0
    for i = self.contentCount, 1, -1 do
        local content = self.contents[i]
        local cw, ch = content:requiredSize()
        content:layout(0, y, width, ch)
        y = y + ch + self.spacing
    end
end
