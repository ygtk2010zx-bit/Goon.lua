local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local AntiBtn = Instance.new("TextButton")
local AimBtn = Instance.new("TextButton")

-- UI Ayarları
ScreenGui.Parent = game:GetService("CoreGui")
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.Size = UDim2.new(0, 220, 0, 180)
MainFrame.Position = UDim2.new(0.5, -110, 0.5, -90)
MainFrame.Active = true
MainFrame.Draggable = true

Title.Parent = MainFrame
Title.Text = "GOON HUB v3"
Title.Size = UDim2.new(1, 0, 0, 35)
Title.BackgroundColor3 = Color3.fromRGB(220, 0, 0)
Title.TextColor3 = Color3.fromRGB(255, 255, 255)

-- Değişkenler
local antiAimActive = false
local aimlockActive = false
local lp = game.Players.LocalPlayer

-- Anti-Aimlock Butonu (Koruma)
AntiBtn.Parent = MainFrame
AntiBtn.Position = UDim2.new(0.1, 0, 0.3, 0)
AntiBtn.Size = UDim2.new(0.8, 0, 0, 35)
AntiBtn.Text = "Anti-Aimlock: KAPALI"
AntiBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
AntiBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

AntiBtn.MouseButton1Click:Connect(function()
    antiAimActive = not antiAimActive
    AntiBtn.Text = antiAimActive and "Anti-Aimlock: AÇIK" or "Anti-Aimlock: KAPALI"
    AntiBtn.BackgroundColor3 = antiAimActive and Color3.fromRGB(0, 180, 0) or Color3.fromRGB(40, 40, 40)
end)

-- Katil Aimlock Butonu (Saldırı)
AimBtn.Parent = MainFrame
AimBtn.Position = UDim2.new(0.1, 0, 0.6, 0)
AimBtn.Size = UDim2.new(0.8, 0, 0, 35)
AimBtn.Text = "Katil Aimlock: KAPALI"
AimBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
AimBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

AimBtn.MouseButton1Click:Connect(function()
    aimlockActive = not aimlockActive
    AimBtn.Text = aimlockActive and "Katil Aimlock: AÇIK" or "Katil Aimlock: KAPALI"
    AimBtn.BackgroundColor3 = aimlockActive and Color3.fromRGB(0, 180, 0) or Color3.fromRGB(40, 40, 40)
end)

-- Katili Bulma Fonksiyonu
local function getMurderer()
    for _, v in pairs(game.Players:GetPlayers()) do
        if v.Character and (v.Backpack:FindFirstChild("Knife") or v.Character:FindFirstChild("Knife")) then
            return v.Character
        end
    end
end

-- Ana Çalışma Döngüsü
game:GetService("RunService").Heartbeat:Connect(function()
    local char = lp.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    
    if not root then return end

    -- Anti-Aimlock: Videodaki sarsılma/vurulmama etkisi
    if antiAimActive then
        local oldV = root.Velocity
        root.Velocity = Vector3.new(0, -6000, 0) -- Aim'i tamamen boşa çıkarır
        game:GetService("RunService").RenderStepped:Wait()
        root.Velocity = oldV
    end

    -- Aimlock: Silahı aldığında katile kitlenme
    if aimlockActive and char:FindFirstChild("Gun") then
        local target = getMurderer()
        if target and target:FindFirstChild("HumanoidRootPart") then
            workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, target.HumanoidRootPart.Position)
        end
    end
end)
