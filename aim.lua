-- MM2 Harvester Visual Changer
local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()

-- Harvester'ın orijinal Mesh ve Texture ID'leri
local harvesterMeshId = "rbxassetid://11545107111"  -- Harvester Mesh ID
local harvesterTextureId = "rbxassetid://11545110191" -- Harvester Texture ID

local function applySkin()
    -- Karakterinde veya çantanda bıçağı ara
    local knife = char:FindFirstChild("Knife") or player.Backpack:FindFirstChild("Knife")
    
    if knife and knife:FindFirstChild("Handle") then
        local mesh = knife.Handle:FindFirstChildOfClass("SpecialMesh")
        
        if mesh then
            -- Görünümü değiştir
            mesh.MeshId = harvesterMeshId
            mesh.TextureId = harvesterTextureId
            
            -- Eğer bıçak parlıyorsa veya efekti varsa onları da buradan ayarlayabilirsin
            print("Görsel Harvester başarıyla uygulandı!")
        end
    else
        print("Bıçak bulunamadı! Lütfen elinde bir bıçak olduğundan emin ol.")
    end
end

-- Scripti çalıştır
applySkin()

-- Karakterin her yenilendiğinde (öldüğünde) tekrar çalışması için:
player.CharacterAdded:Connect(function(newChar)
    char = newChar
    wait(1) -- Bıçağın yüklenmesi için kısa bir bekleme
    applySkin()
end)
