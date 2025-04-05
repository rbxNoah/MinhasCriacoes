local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local backpack = player:WaitForChild("Backpack")

-- Tabela para armazenar todas as Tools
local tools = {}

-- Equipar todas as Tools do inventário
for _, tool in ipairs(backpack:GetChildren()) do
if tool:IsA("Tool") then
tool.Parent = character
table.insert(tools, tool)

-- Desativar colisão da Handle    
    if tool:FindFirstChild("Handle") then    
        tool.Handle.CanCollide = false    
    end    
end

end

-- Configurações da esfera
local radius = 5 -- Raio da esfera
local numberOfTools = #tools

-- Função para calcular posições na esfera (Fibonacci Sphere)
local function getSpherePosition(i, n, r)
local y = 1 - (i / (n - 1)) * 2  -- y vai de 1 a -1
local radiusAtY = r * math.sqrt(1 - y * y)  -- raio no plano xz
local theta = math.pi * (3 - math.sqrt(5)) * i  -- ângulo áureo
local x = math.cos(theta) * radiusAtY
local z = math.sin(theta) * radiusAtY
return Vector3.new(x, y * r, z)
end

-- Função para atualizar as posições das Tools
local function updateToolPositions()
if not character:FindFirstChild("HumanoidRootPart") then return end

for i, tool in ipairs(tools) do    
    if tool:FindFirstChild("Handle") then    
        -- Calcula a posição na esfera    
        local spherePos = getSpherePosition(i-1, numberOfTools, radius)    
            
        -- Ajusta o Grip para posicionar a ferramenta    
        -- Isso não afeta a física do personagem    
        tool.Grip = CFrame.new(spherePos) * CFrame.Angles(0, math.rad(i * 360 / numberOfTools), 0)    
    end    
end

end

-- Atualizar continuamente (usando Stepped para melhor sincronização)
game:GetService("RunService").Stepped:Connect(updateToolPositions)

-- Atualizar quando novas tools forem adicionadas
backpack.ChildAdded:Connect(function(child)
if child:IsA("Tool") then
child.Parent = character
table.insert(tools, child)
numberOfTools = #tools

if child:FindFirstChild("Handle") then    
        child.Handle.CanCollide = false    
    end    
end

end)
