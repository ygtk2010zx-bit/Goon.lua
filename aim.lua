-- Evrensel Aimlock (Her Oyunda Çalışır)
local lp = game.Players.LocalPlayer
local mouse = lp:GetMouse()
local camera = workspace.CurrentCamera
local rs = game:GetService("RunService")

-- Eski panelleri sil (Çakışmasın)
if game:GetService("CoreGui"):FindFirstChild("GlobalAimlock") then
    game:GetService("CoreGui").GlobalAimlock:Destroy()
end

-- Panel Oluşturma
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "GlobalAimlock"
ScreenGui.Parent = game:GetService("CoreGui")

local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 150, 0, 50)
Main.Position = UDim2.new(0.5, -75, 0, 50) -- Ekranın üst ortası
Main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Main.Draggable = true
Main.Active = true
Main.Parent = ScreenGui

local Button = Instance.new("TextButton")
Button.Size = UDim2.new(1, 0, 1, 0)
Button.Text = "AIMLOCK: KAPALI"
Button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Button.TextColor3 = Color3.fromRGB(255, 255, 255)
Button.Parent = Main

local active = false
Button.MouseButton1Click:Connect(function()
    active = not active
    Button.Text = active and "AIMLOCK: AÇIK" or "AIMLOCK: KAPALI"
    Button.BackgroundColor3 = active and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(40, 40, 40)
end)

-- En Yakın Oyuncuyu Algılama
function getTarget()
    local target = nil
    local dist = math.huge
    for _, v in pairs(game.Players:GetPlayers()) do
        if v ~= lp and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
            local pos, vis = camera:WorldToViewportPoint(v.Character.HumanoidRootPart.Position)
            if vis then
                local mag = (Vector2.new(pos.X, pos.Y) - Vector2.new(mouse.X, mouse.Y)).Magnitude
                if mag < dist then
                    target = v.Character.HumanoidRootPart
                    dist = mag
                end
            end
        end
    end
    return target
end

-- Takip Döngüsü
rs.RenderStepped:Connect(function()
    if active then
        local t = getTarget()
        if t then
            camera.CFrame = CFrame.new(camera.CFrame.Position, t.Position)
        end
    end
end)
