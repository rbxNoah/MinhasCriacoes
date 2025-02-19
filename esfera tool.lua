local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local backpack = player:WaitForChild("Backpack")

-- Tabela para armazenar todas as Tools
local tools = {}

-- Equipar todas as Tools do inventário e movê-las para o personagem
for _, tool in ipairs(backpack:GetChildren()) do
    if tool:IsA("Tool") then
        tool.Parent = character
        table.insert(tools, tool)
    end
end

-- Configurações da esfera
local radius = 5 -- Raio da esfera ao redor do jogador
local numberOfTools = #tools -- Quantidade de Tools equipadas

-- Função para calcular as posições e ajustar o CFrame e Grip das Tools
local function updateToolPositions()
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if not rootPart then return end

    local characterPosition = rootPart.Position

    for i, tool in ipairs(tools) do
        if tool:FindFirstChild("Handle") then
            -- Cálculos para distribuir as Tools em uma esfera 3D
            local phi = math.acos(1 - 2 * (i - 0.5) / numberOfTools) -- Ângulo vertical
            local theta = math.pi * (1 + math.sqrt(5)) * (i - 0.5) -- Ângulo horizontal

            local x = radius * math.sin(phi) * math.cos(theta)
            local y = radius * math.sin(phi) * math.sin(theta)
            local z = radius * math.cos(phi)

            -- Usar o CFrame para mover fisicamente a ferramenta no mundo
            tool.Handle.CFrame = CFrame.new(characterPosition + Vector3.new(x, y, z))

            -- Ajustar o GripPos (opcional para ajustamento visual)
            tool.GripPos = Vector3.new(x, y, z)
            -- Também pode ajustar a orientação com o Grip se necessário
            tool.Grip = CFrame.new(x, y, z) -- Ajusta a orientação (se necessário)
        end
    end
end

-- Atualizar a posição continuamente
game:GetService("RunService").RenderStepped:Connect(updateToolPositions)
