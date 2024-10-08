-- pid.lua
PID = {
    new = function (cls, Kp, Ki, Kd)
        local obj = {
            Kp = Kp,  -- Ganho Proporcional
            Ki = Ki,  -- Ganho Integral
            Kd = Kd,  -- Ganho Derivativo
            previous_error = 0,
            integral = 0,
            setpoint = 0,
            setSetpoint = cls.setSetpoint,
            compute = cls.compute           
        }

        function obj:setSetpoint(setpoint)
            self.setpoint = setpoint
        end

        function obj:compute(measurement, dt)
            local error = self.setpoint - measurement
            self.integral = self.integral + error * dt
            local derivative = (error - self.previous_error) / dt

            -- Cálculo da saída do PID
            local output = (self.Kp * error) + (self.Ki * self.integral) + (self.Kd * derivative)

            self.previous_error = error
            return output
        end

        return obj
    end
}

-- Point = {
--     new = function(cls, x,y)
--        return {
--           x=x;
--           y=y;
--           add = cls.add; -- note, cls will be a reference to the global table "Point" aka the "class table", so we're taking the below function and sticking it in what you could call this "instance" table.
--      }
--      end;
 
--     add = function(self, otherPoint)
--        self.x = self.x + otherPoint.x
--        self.y = self.y + otherPoint.y
--     end;    
--  }