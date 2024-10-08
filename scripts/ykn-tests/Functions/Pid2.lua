-- Classe PID
PID = {}
PID.__index = PID

function PID:new(Kp, Ki, Kd)
    local obj = {
        Kp = Kp,  -- Ganho Proporcional
        Ki = Ki,  -- Ganho Integral
        Kd = Kd,  -- Ganho Derivativo
        previous_error = 0,
        integral = 0,
        setpoint = 0
    }
    return obj
end

function PID:setSetpoint(setpoint)
    self.setpoint = setpoint
end

function PID:compute(measurement, dt)
    local error = self.setpoint - measurement
    self.integral = self.integral + error * dt
    local derivative = (error - self.previous_error) / dt

    -- Cálculo da saída do PID
    local output = (self.Kp * error) + (self.Ki * self.integral) + (self.Kd * derivative)

    self.previous_error = error
    return output
end

return PID