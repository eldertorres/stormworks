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
    setmetatable(obj, self)
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

-- Exemplo de uso
local pid = PID:new(1.0, 0.1, 0.05)  -- Kp, Ki, Kd

pid:setSetpoint(100)  -- Definindo o setpoint desejado

local dt = 1  -- Intervalo de tempo em segundos
local measurement = 0  -- Medida inicial

for i = 1, 100 do
    local output = pid:compute(measurement, dt)
    measurement = measurement + output * 0.1  -- Simulando a resposta do sistema
    print(string.format("Iteração: %d, Medida: %.2f, Saída PID: %.2f", i, measurement, output))
end
