Anchored = class(Wrapper)

Anchored.left = 0
Anchored.right = 1
Anchored.top = 1
Anchored.bottom = 0
Anchored.center = 0.5
Anchored.fill = -1

function Anchored:init(args)
    Wrapper.init(self, args)
    self.horizontal = args.horizontal or 0.5
    self.vertical = args.vertical or 0.5
end

function Anchored:layoutContent(w, h)
    function anchor(n, rcn, ratio)
        local maxcn = math.min(n, rcn)
        if ratio >= 0 then
            return (n-maxcn)*ratio, maxcn
        else
            return 0, n
        end
    end
    
    local rcw, rch = self.content:requiredSize()
    local cx, cw = anchor(w, rcw, self.horizontal)
    local cy, ch = anchor(h, rch, self.vertical)
    
    self.content:layout(cx, cy, cw, ch)
end
