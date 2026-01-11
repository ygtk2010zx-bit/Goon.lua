local lp = game.Players.LocalPlayer
local camera = workspace.CurrentCamera
local mouse = lp:GetMouse()

-- Basit UI
local sg = Instance.new("ScreenGui", game:GetService("CoreGui"))
local btn = Instance.new("TextButton", sg)
btn.Size = UDim2.new(0, 150, 0, 50)
btn.Position = UDim2.new(0.5, -75, 0, 10)
btn.Text = "AIMLOCK: KAPALI"

local active = false
btn.MouseButton1Click:Connect(function()
    active = not active
    btn.Text = active and "AIMLOCK: AÇIK" or "AIMLOCK: KAPALI"
    btn.BackgroundColor3 = active and Color3.new(0,1,0) or Color3.new(1,1,1)
end)

game:GetService("RunService").RenderStepped:Connect(function()
    if active then
        local closest = nil
        local dist = 1000
        for _, v in pairs(game.Players:GetPlayers()) do
            if v ~= lp and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                local pos, onScreen = camera:WorldToViewportPoint(v.Character.HumanoidRootPart.Position)
                if onScreen then
                    local m = (Vector2.new(pos.X, pos.Y) - Vector2.new(mouse.X, mouse.Y)).Magnitude
                    if m < dist then
                        closest = v.Character.HumanoidRootPart
                        dist = m
                    end
                end
            end
        end
        if closest then
            camera.CFrame = CFrame.new(camera.CFrame.Position, closest.Position)
        end
    end
end)
