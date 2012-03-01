Margin = class(Wrapper)

function Margin:init(args)
    Wrapper.init(self, args)
    self.marginx = args.marginx or args.margin or 0
    self.marginy = args.marginy or args.margin or 0
end

function Margin:requiredSize()
    local cw, ch = self.content:requiredSize()
    return cw + 2*self.marginx, ch + 2*self.marginy
end

function Margin:layoutContent(w, h)
    self.content:layout(self.marginx,
                        self.marginy,
                        w - 2*self.marginx,
                        h - 2*self.marginy)
end
