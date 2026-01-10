-- Katile Kilitlenme Fonksiyonu
local function getMurderer()
    for _, v in pairs(game.Players:GetPlayers()) do
        if v.Backpack:FindFirstChild("Knife") or (v.Character and v.Character:FindFirstChild("Knife")) then
            return v.Character
        end
    end
end

-- Silahı eline aldığında çalışacak kısım
lp.CharacterChildAdded:Connect(function(tool)
    if tool:IsA("Tool") and tool.Name == "Gun" then
        local target = getMurderer()
        if target and target:FindFirstChild("HumanoidRootPart") then
            -- Kamerayı katile çevirir
            workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, target.HumanoidRootPart.Position)
        end
    end
end)
