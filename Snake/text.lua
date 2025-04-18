return function (args)
    local text = {}
    text.string = args.string
    text.x = args.x
    text.y = args.y
    text.font = love.graphics.newFont(args.size)
    text.color = args.color

    text.draw = function (self)
        love.graphics.setFont(self.font)
        love.graphics.setColor(self.color)
        love.graphics.print(self.string, self.x, self.y)
    end

    return text

end