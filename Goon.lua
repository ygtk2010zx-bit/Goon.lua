local lp = game.Players.LocalPlayer
local camera = workspace.CurrentCamera
local rs = game:GetService("RunService")

-- UI Oluşturma
local ScreenGui = Instance.new("ScreenGui")
local Main = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local AimlockBtn = Instance.new("TextButton")

ScreenGui.Parent = game:GetService("CoreGui")
Main.Name = "AimlockPanel"
Main.Parent = ScreenGui
Main.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Main.Size = UDim2.new(0, 180, 0, 100)
Main.Position = UDim2.new(0.5, -90, 0.5, -50)
Main.Active = true
Main.Draggable = true

Title.Parent = Main
Title.Text = "KATIL AIMLOCK"
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
Title.TextColor3 = Color3.fromRGB(255, 255, 255)

AimlockBtn.Parent = Main
AimlockBtn.Position = UDim2.new(0.1, 0, 0.45, 0)
AimlockBtn.Size = UDim2.new(0.8, 0, 0, 35)
AimlockBtn.Text = "Aimlock: KAPALI"
AimlockBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
AimlockBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

local aimEnabled = false
AimlockBtn.MouseButton1Click:Connect(function()
    aimEnabled = not aimEnabled
    AimlockBtn.Text = aimEnabled and "Aimlock: AÇIK" or "Aimlock: KAPALI"
    AimlockBtn.BackgroundColor3 = aimEnabled and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(50, 50, 50)
end)

-- Katili Bulma Fonksiyonu
local function getMurderer()
    for _, v in pairs(game.Players:GetPlayers()) do
        if v.Character and (v.Backpack:FindFirstChild("Knife") or v.Character:FindFirstChild("Knife")) then
            return v.Character
        end
    end
    return nil
end

-- Kilitlenme Döngüsü
rs.RenderStepped:Connect(function()
    if aimEnabled then
        local char = lp.Character
        -- Sadece silah elindeyse kilitlenir
        if char and char:FindFirstChild("Gun") then
            local target = getMurderer()
            if target and target:FindFirstChild("HumanoidRootPart") then
                -- Kamerayı yumuşak bir şekilde katile çevirir
                camera.CFrame = CFrame.new(camera.CFrame.Position, target.HumanoidRootPart.Position)
            end
        end
    end
end)
