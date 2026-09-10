-- ============================================
-- DELTA HACK - Gorilla Tag Script
-- GUI: Black & White Theme
-- ============================================

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")

-- ============================================
-- متغيرات التحكم
-- ============================================
local speedMultiplier = 1
local jumpPower = 50
local noclipEnabled = false
local spamJumpEnabled = false
local speedEnabled = false

-- ============================================
-- إنشاء GUI (واجهة سوداء وبيضاء)
-- ============================================
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "DeltaHackGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

-- الخلفية الرئيسية (أسود)
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 300, 0, 400)
mainFrame.Position = UDim2.new(0.5, -150, 0.5, -200)
mainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0) -- أسود
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

-- العنوان (أبيض على أسود)
local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "Title"
titleLabel.Size = UDim2.new(1, 0, 0, 50)
titleLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255) -- أبيض
titleLabel.TextColor3 = Color3.fromRGB(0, 0, 0) -- نص أسود
titleLabel.TextSize = 24
titleLabel.Font = Enum.Font.GothamBold
titleLabel.Text = "⚡ DELTA HACK ⚡"
titleLabel.Parent = mainFrame

-- ============================================
-- زر السرعة
-- ============================================
local speedButton = Instance.new("TextButton")
speedButton.Name = "SpeedButton"
speedButton.Size = UDim2.new(0.9, 0, 0, 60)
speedButton.Position = UDim2.new(0.05, 0, 0.15, 0)
speedButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50) -- رمادي غامق
speedButton.TextColor3 = Color3.fromRGB(255, 255, 255) -- نص أبيض
speedButton.TextSize = 16
speedButton.Font = Enum.Font.GothamBold
speedButton.Text = "⚡ السرعة: OFF"
speedButton.BorderSizePixel = 2
speedButton.BorderColor3 = Color3.fromRGB(255, 255, 255)
speedButton.Parent = mainFrame

-- ============================================
-- زر النطط المتكرر
-- ============================================
local jumpButton = Instance.new("TextButton")
jumpButton.Name = "JumpButton"
jumpButton.Size = UDim2.new(0.9, 0, 0, 60)
jumpButton.Position = UDim2.new(0.05, 0, 0.42, 0)
jumpButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50) -- رمادي غامق
jumpButton.TextColor3 = Color3.fromRGB(255, 255, 255) -- نص أبيض
jumpButton.TextSize = 16
jumpButton.Font = Enum.Font.GothamBold
jumpButton.Text = "🦘 النطط: OFF"
jumpButton.BorderSizePixel = 2
jumpButton.BorderColor3 = Color3.fromRGB(255, 255, 255)
jumpButton.Parent = mainFrame

-- ============================================
-- زر الجدران
-- ============================================
local noclipButton = Instance.new("TextButton")
noclipButton.Name = "NoclipButton"
noclipButton.Size = UDim2.new(0.9, 0, 0, 60)
noclipButton.Position = UDim2.new(0.05, 0, 0.69, 0)
noclipButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50) -- رمادي غامق
noclipButton.TextColor3 = Color3.fromRGB(255, 255, 255) -- نص أبيض
noclipButton.TextSize = 16
noclipButton.Font = Enum.Font.GothamBold
noclipButton.Text = "🧱 اختراق الجدران: OFF"
noclipButton.BorderSizePixel = 2
noclipButton.BorderColor3 = Color3.fromRGB(255, 255, 255)
noclipButton.Parent = mainFrame

-- ============================================
-- وظيفة زيادة السرعة
-- ============================================
local function toggleSpeed()
    speedEnabled = not speedEnabled
    speedButton.Text = speedEnabled and "⚡ السرعة: ON" or "⚡ السرعة: OFF"
    speedButton.BackgroundColor3 = speedEnabled and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(50, 50, 50)
end

-- ============================================
-- وظيفة النطط المتكرر
-- ============================================
local function toggleSpamJump()
    spamJumpEnabled = not spamJumpEnabled
    jumpButton.Text = spamJumpEnabled and "🦘 النطط: ON" or "🦘 النطط: OFF"
    jumpButton.BackgroundColor3 = spamJumpEnabled and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(50, 50, 50)
end

-- ============================================
-- وظيفة اختراق الجدران
-- ============================================
local function toggleNoclip()
    noclipEnabled = not noclipEnabled
    noclipButton.Text = noclipEnabled and "🧱 اختراق الجدران: ON" or "🧱 اختراق الجدران: OFF"
    noclipButton.BackgroundColor3 = noclipEnabled and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(50, 50, 50)
end

-- ============================================
-- ربط الأزرار بالأحداث
-- ============================================
speedButton.MouseButton1Click:Connect(toggleSpeed)
jumpButton.MouseButton1Click:Connect(toggleSpamJump)
noclipButton.MouseButton1Click:Connect(toggleNoclip)

-- ============================================
-- تحديث السرعة
-- ============================================
RunService.RenderStepped:Connect(function()
    if speedEnabled and character and humanoid.Health > 0 then
        local moveDirection = UserInputService:IsKeyDown(Enum.KeyCode.W) and Vector3.new(0, 0, -1) or
                            UserInputService:IsKeyDown(Enum.KeyCode.S) and Vector3.new(0, 0, 1) or
                            UserInputService:IsKeyDown(Enum.KeyCode.A) and Vector3.new(-1, 0, 0) or
                            UserInputService:IsKeyDown(Enum.KeyCode.D) and Vector3.new(1, 0, 0) or
                            Vector3.new(0, 0, 0)
        
        if moveDirection ~= Vector3.new(0, 0, 0) then
            rootPart.CFrame = rootPart.CFrame + moveDirection.Unit * 2 * speedMultiplier
        end
    end
    
    -- اختراق الجدران
    if noclipEnabled and character then
        for _, part in pairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    else
        for _, part in pairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = true
            end
        end
    end
end)

-- ============================================
-- النطط المتكرر
-- ============================================
RunService.Heartbeat:Connect(function()
    if spamJumpEnabled and character and humanoid.Health > 0 then
        humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

-- ============================================
-- التعامل مع الشخصية الجديدة
-- ============================================
player.CharacterAdded:Connect(function(newCharacter)
    character = newCharacter
    humanoid = character:WaitForChild("Humanoid")
    rootPart = character:WaitForChild("HumanoidRootPart")
end)

print("✅ Delta Hack تم تفعيله!")
print("استخدم الأزرار في القائمة للتحكم")