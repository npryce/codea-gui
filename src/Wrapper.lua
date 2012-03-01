Wrapper = class(Widget)

function Wrapper:init(args)
    Widget.init(self, args)
    self.content = args[1]
    self.content.container = self
end

function Wrapper:children()
    return {self.content}
end

function Wrapper:requiredSize()
    return self.content:requiredSize()
end
