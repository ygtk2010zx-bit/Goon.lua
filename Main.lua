-- Fling Script Taslağı
local targetName = "BURAYA_ISIM_YAZ" -- Fırlatmak istediğin kişinin adını yaz

local player = game.Players.LocalPlayer
local character = player.Character
local target = game.Players:FindFirstChild(targetName)

if target and target.Character then
    local root = character:FindFirstChild("HumanoidRootPart")
    local targetRoot = target.Character:FindFirstChild("HumanoidRootPart")

    if root and targetRoot then
        -- Fizik motorunu bozmak için yüksek hızda döndürme
        local velocity = Instance.new("BodyAngularVelocity")
        velocity.AngularVelocity = Vector3.new(0, 99999, 0) -- Dönüş hızı
        velocity.MaxTorque = Vector3.new(0, math.huge, 0)
        velocity.Parent = root
        
        -- Hedefe ışınlan ve çarp
        root.CFrame = targetRoot.CFrame
        print(targetName .. " fırlatılıyor!")
        
        -- 1 saniye sonra durdur (kendin de haritadan uçmamak için)
        task.wait(1)
        velocity:Destroy()
    end
else
    print("Hedef bulunamadı!")
end
