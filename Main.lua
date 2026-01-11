local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "MM2 Katil Avcısı",
   LoadingTitle = "Goon.lua Özel",
   LoadingSubtitle = "by Gemini",
   ConfigurationSaving = { Enabled = false }
})

local MainTab = Window:CreateTab("Ana Menü", 4483362458) -- İkon ID

local AimEnabled = false
local EspEnabled = false

-- Aimlock Mantığı
MainTab:CreateToggle({
   Name = "Katil Aimlock (Sağ Tık)",
   CurrentValue = false,
   Callback = function(Value)
      AimEnabled = Value
   end,
})

-- ESP Mantığı
MainTab:CreateToggle({
   Name = "Katili Göster (ESP)",
   CurrentValue = false,
   Callback = function(Value)
      EspEnabled = Value
   end,
})

-- Arka Plan Döngüsü
game:GetService("RunService").RenderStepped:Connect(function()
    for _, v in pairs(game.Players:GetPlayers()) do
        if v ~= game.Players.LocalPlayer and v.Character then
            local isMurderer = v.Backpack:FindFirstChild("Knife") or v.Character:FindFirstChild("Knife")
            
            -- ESP Kısmı
            if EspEnabled and isMurderer then
                if not v.Character:FindFirstChild("Highlight") then
                    local hl = Instance.new("Highlight", v.Character)
                    hl.FillColor = Color3.fromRGB(255, 0, 0) -- Kırmızı
                end
            elseif not EspEnabled or not isMurderer then
                if v.Character:FindFirstChild("Highlight") then
                    v.Character.Highlight:Destroy()
                end
            end

            -- Aimlock Kısmı
            if AimEnabled and isMurderer and game:GetService("UserInputService"):IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
                if v.Character:FindFirstChild("HumanoidRootPart") then
                    workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, v.Character.HumanoidRootPart.Position)
                end
            end
        end
    end
end)
