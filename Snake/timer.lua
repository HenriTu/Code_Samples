return function ()
    timer = {}
    timer.value = 0

    timer.update = function(self, dt)
        self.value = self.value + dt
    end

    timer.reset = function (self)
        self.value = 0
    end

    return timer
end