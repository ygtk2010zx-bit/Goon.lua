local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local AntiBtn = Instance.new("TextButton")
local AimBtn = Instance.new("TextButton")

-- UI Ayarları
ScreenGui.Parent = game:GetService("CoreGui")
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.Size = UDim2.new(0, 220, 0, 180)
MainFrame.Position = UDim2.new(0.5, -110, 0.5, -90)
MainFrame.Active = true
MainFrame.Draggable = true

Title.Parent = MainFrame
Title.Text = "GOON HUB - MM2"
Title.Size = UDim2.new(1, 0, 0, 35)
Title.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
Title.TextColor3 = Color3.fromRGB(255, 255, 255)

-- Değişkenler
local antiAimActive = false
local aimlockActive = false
local lp = game.Players.LocalPlayer

-- Anti-Aim Butonu (Videodaki sarsılma)
AntiBtn.Parent = MainFrame
AntiBtn.Position = UDim2.new(0.1, 0, 0.3, 0)
AntiBtn.Size = UDim2.new(0.8, 0, 0, 35)
AntiBtn.Text = "Anti-Aim: OFF"
AntiBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
AntiBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

AntiBtn.MouseButton1Click:Connect(function()
    antiAimActive = not antiAimActive
    AntiBtn.Text = antiAimActive and "Anti-Aim: ON" or "Anti-Aim: OFF"
    AntiBtn.BackgroundColor3 = antiAimActive and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(45, 45, 45)
end)

-- Aimlock Butonu (Katile kilitlenme)
AimBtn.Parent = MainFrame
AimBtn.Position = UDim2.new(0.1, 0, 0.6, 0)
AimBtn.Size = UDim2.new(0.8, 0, 0, 35)
AimBtn.Text = "Auto-Aim Katil: OFF"
AimBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
AimBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

AimBtn.MouseButton1Click:Connect(function()
    aimlockActive = not aimlockActive
    AimBtn.Text = aimlockActive and "Auto-Aim Katil: ON" or "Auto-Aim Katil: OFF"
    AimBtn.BackgroundColor3 = aimlockActive and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(45, 45, 45)
end)

-- Fonksiyon: Katili Bul
local function getMurderer()
    for _, v in pairs(game.Players:GetPlayers()) do
        if v.Character and (v.Backpack:FindFirstChild("Knife") or v.Character:FindFirstChild("Knife")) then
            return v.Character
        end
    end
end

-- ANA DÖNGÜ
game:GetService("RunService").Heartbeat:Connect(function()
    local char = lp.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    
    if not root then return end

    -- Anti-Aim Logic (Sarsılma)
    if antiAimActive then
        local oldV = root.Velocity
        root.Velocity = Vector3.new(0, -5000, 0) -- Aim'i boşa çıkarır
        game:GetService("RunService").RenderStepped:Wait()
        root.Velocity = oldV
    end

    -- Aimlock Logic (Silah elindeyse kilitlen)
    if aimlockActive and char:FindFirstChild("Gun") then
        local target = getMurderer()
        if target and target:FindFirstChild("HumanoidRootPart") then
            local cam = workspace.CurrentCamera
            cam.CFrame = CFrame.new(cam.CFrame.Position, target.HumanoidRootPart.Position)
        end
    end
end)
