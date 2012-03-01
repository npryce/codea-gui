Icon = class(Widget)

function Icon:init(args)
    Widget.init(self, args)
    if args.image then
        self.image = args.image
        self.imageWidth = args.image.width
        self.imageHeight = args.image.height
    else
        self.image = args.sprite
        self.imageWidth, self.imageHeight = spriteSize(args.sprite)
    end
    if args.width then
        self.imageWidth = args.width
    end
    if args.height then
        self.imageHeight = args.height
    end
    self.tint = args.tint or color(255, 255, 255, 255)
end

function Icon:requiredSize()
    return self.imageWidth, self.imageHeight
end

function Icon:draw()
    spriteMode(CORNER)
    tint(self.tint)
    sprite(self.image, 0, 0, self.width, self.height)
end
