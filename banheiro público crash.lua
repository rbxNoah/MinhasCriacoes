local player = game.Players.LocalPlayer

-- Criando a interface
local gui = Instance.new("ScreenGui")
gui.Name = "CustomGui"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 200, 0, 110)
frame.Position = UDim2.new(0.5, -100, 0.5, -120)
frame.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
frame.Active = true
frame.Draggable = true
frame.Parent = gui

-- Botão MrOof
local mrOofButton = Instance.new("TextButton")
mrOofButton.Size = UDim2.new(0, 80, 0, 40)
mrOofButton.Position = UDim2.new(0, 10, 0, 10)
mrOofButton.Text = "MrOof"
mrOofButton.BackgroundColor3 = Color3.new(1, 0, 0)
mrOofButton.Parent = frame

-- Botão Cola
local colaButton = Instance.new("TextButton")
colaButton.Size = UDim2.new(0, 80, 0, 40)
colaButton.Position = UDim2.new(0, 110, 0, 10)
colaButton.Text = "Cola"
colaButton.BackgroundColor3 = Color3.new(1, 0, 0)
colaButton.Parent = frame

-- Botão Equip
local equipButton = Instance.new("TextButton")
equipButton.Size = UDim2.new(0, 80, 0, 40)
equipButton.Position = UDim2.new(0, 10, 0, 60)
equipButton.Text = "Equip"
equipButton.BackgroundColor3 = Color3.new(0.8, 0.8, 0.8)
equipButton.Parent = frame

-- Botão Clear
local clearButton = Instance.new("TextButton")
clearButton.Size = UDim2.new(0, 80, 0, 40)
clearButton.Position = UDim2.new(0, 110, 0, 60)
clearButton.Text = "Clear"
clearButton.BackgroundColor3 = Color3.new(0.8, 0.8, 0.8)
clearButton.Parent = frame

-- Função para limpar todas as TrashColas no inventário e no mundo
local function cleanupTrashCola()
    local backpack = player:FindFirstChild("Backpack")
    if backpack then
        for _, tool in ipairs(backpack:GetChildren()) do
            if tool:IsA("Tool") and tool.Name == "TrashCola" then
                tool:Destroy()
            end
        end
    end

    local character = player.Character
    if character then
        for _, tool in ipairs(character:GetChildren()) do
            if tool:IsA("Tool") and tool.Name == "TrashCola" then
                tool:Destroy()
            end
        end
    end

    for _, obj in ipairs(workspace:GetChildren()) do
        if obj:IsA("Tool") and obj.Name == "TrashCola" then
            obj:Destroy()
        end
    end
end

-- Variável de controle do loop para o botão Clear
local clearEnabled = false

-- Lógica do botão Clear
clearButton.MouseButton1Click:Connect(function()
    clearEnabled = not clearEnabled -- Alterna entre ligado e desligado

    if clearEnabled then
        clearButton.BackgroundColor3 = Color3.new(0, 1, 0) -- Verde (ligado)
        spawn(function()
            while clearEnabled do
                cleanupTrashCola()
                task.wait(0.1) -- Aguarda 0.5 segundos entre cada limpeza
            end
        end)
    else
        clearButton.BackgroundColor3 = Color3.new(0.8, 0.8, 0.8) -- Cinza (desligado)
    end
end)

-- Variável de controle do loop para o botão Equip
local equipEnabled = false

-- Função para equipar todas as ferramentas
local function equipAllTools()
    local backpack = player:FindFirstChild("Backpack")
    if backpack then
        for _, tool in ipairs(backpack:GetChildren()) do
            if tool:IsA("Tool") and tool.Name == "TrashCola" then
                tool.Parent = player.Character
            end
        end
    end
end

-- Lógica do botão Equip
equipButton.MouseButton1Click:Connect(function()
    equipEnabled = not equipEnabled -- Alterna entre ligado e desligado

    if equipEnabled then
        equipButton.BackgroundColor3 = Color3.new(0, 1, 0) -- Verde (ligado)
        spawn(function()
            while equipEnabled do
                equipAllTools()
                task.wait(0) -- Aguarda 0.5 segundos entre cada equipar
            end
        end)
    else
        equipButton.BackgroundColor3 = Color3.new(0.8, 0.8, 0.8) -- Cinza (desligado)
    end
end)

-- Função para simular cliques
local function simulateClick(part)
    if part and part:FindFirstChild("ClickDetector") then
        fireclickdetector(part.ClickDetector)
    end
end

-- Variáveis para controlar os botões MrOof e Cola
local mrOofEnabled = false
local colaEnabled = false

local mrOofPath = workspace:FindFirstChild("MrOof"):FindFirstChild("Bighead")
local colaPath = workspace:FindFirstChild("Trash can"):FindFirstChild("Trash"):FindFirstChild("Can")

-- Lógica para o botão MrOof
mrOofButton.MouseButton1Click:Connect(function()
    mrOofEnabled = not mrOofEnabled
    if mrOofEnabled then
        mrOofButton.BackgroundColor3 = Color3.new(0, 1, 0)
        spawn(function()
            while mrOofEnabled do
                simulateClick(mrOofPath)
                task.wait(0)
            end
        end)
    else
        mrOofButton.BackgroundColor3 = Color3.new(1, 0, 0)
    end
end)

-- Lógica para o botão Cola
colaButton.MouseButton1Click:Connect(function()
    colaEnabled = not colaEnabled
    if colaEnabled then
        colaButton.BackgroundColor3 = Color3.new(0, 1, 0)
        spawn(function()
            while colaEnabled do
                simulateClick(colaPath)
                task.wait(0)
            end
        end)
    else
        colaButton.BackgroundColor3 = Color3.new(1, 0, 0)
    end
end)
