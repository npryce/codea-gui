Text = class(Widget)

function Text:init(args)
    Widget.init(self, args)
    self.query = args.query or Widget.const(args.text or "")
    self.font = args.font
    self.fontSize = args.fontSize,
    self.text
    self.fill = args.fill
end

function Text:requiredSize()
    pushStyle()
    self:applyStyle()
    textWrapWidth(math.huge) -- force newlines to apply
    local w, h = textSize(self.query())
    popStyle()
    return w, h
end

function Text:draw()
    textMode(CORNER)
    textWrapWidth(self.width)
    self:applyStyle()
    text(self.query(), 0, 0)
end

function Text:applyStyle()
    if self.font then
        font(self.font)
    end
    if self.fontSize then
        fontSize(self.fontSize)
    end
    if self.fill then
        fill(self.fill)
    end
    if self.textAlign then
        textAlign(self.textAlign)
    end
end
