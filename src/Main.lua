
function setup()
    local who = "world"
    
    function greet(name)
        return function()
            who = name
            gui:changed()
        end
    end
    
    gui = Screen {
        Margin {
            margin = 16,
            touched = greet("world"),
            Anchored {
                vertical = 2/3,
                Column {
                    spacing = 64,
                    Text {
                        query = os.date,
                        font = "GillSans",
                        fontSize = 40,
                        fill = color(255, 255, 255, 255)
                    },
                    Anchored{
                        Row {
                            Icon {
                                sprite = "Planet Cute:Character Boy",
                                touched = greet("boy")
                            },
                            Icon {
                                sprite = "Planet Cute:Character Cat Girl",
                                touched = greet("girl")
                            }
                        }
                    },
                    Anchored {
                        Text {
                            query = function()
                                return "hello, "..who
                            end,
                            font = "GillSans",
                            fontSize = 60,
                            fill = color(255, 255, 255, 255)
                        }
                    }
                }
            }
        }
    }
end

function draw()
    background(25, 76, 156, 255)
    gui:draw()
end

function orientationChanged()
    gui:changed()
end

function touched(t)
    gui:touched(t)
end
