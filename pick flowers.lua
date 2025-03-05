local player = game.Players.LocalPlayer

local function getCharacter()
    repeat wait() until player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    return player.Character
end

local function collectFlower(character, flower)
    local stem = flower:FindFirstChild("Stem")
    local prompt = stem and stem:FindFirstChild("Attachment") and stem.Attachment:FindFirstChild("ProximityPrompt")

    if prompt then
        character.HumanoidRootPart.CFrame = CFrame.new(stem.Position + Vector3.new(0, 3, 0))
        wait(0.2)
        fireproximityprompt(prompt)
    end
end

task.spawn(function()
    while true do
        local character = getCharacter()
        local flowers = workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("Flowers") and workspace.Map.Flowers:FindFirstChild("Models")

        if flowers then
            for _, flower in pairs(flowers:GetChildren()) do
                collectFlower(character, flower)
            end
        end

        wait(2)
    end
end)
