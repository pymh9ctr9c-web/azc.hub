-- AZC Hub - Complete Script with Floating Auto Teleport Button
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")

-- المتغيرات الأساسية
local savedCFrame = nil
local autoTpActive = false
local noclipEnabled = false
local speedEnabled = false
local infiniteJumpEnabled = false

-- تنظيف أي واجهة قديمة لو تم تشغيل السكريبت مرتين
if CoreGui:FindFirstChild("AZC_MasterUI") then
    CoreGui.AZC_MasterUI:Destroy()
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AZC_MasterUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = CoreGui

-- ==================== 1. زر الأوتو تيليبورت الصغير (العائم برى القائمة) ====================
local tpButton = Instance.new("TextButton")
tpButton.Name = "AutoTpToggle"
tpButton.Size = UDim2.new(0, 110, 0, 40)
tpButton.Position = UDim2.new(0, 20, 0, 150) -- مكان الزر بيسار الشاشة (تقدر تسحبه)
tpButton.BackgroundColor3 = Color3.fromRGB(30, 41, 59)
tpButton.BorderColor3 = Color3.fromRGB(56, 189, 248)
tpButton.TextColor3 = Color3.fromRGB(255, 255, 255)
tpButton.TextSize = 14
tpButton.Font = Enum.Font.GothamBold
tpButton.Text = "Auto TP: OFF"
tpButton.Active = true
tpButton.Draggable = true -- يمديك تسحبه بأي مكان بالشاشة
tpButton.Parent = screenGui

local tpCorner = Instance.new("UICorner")
tpCorner.CornerRadius = UDim.new(0, 8)
tpCorner.Parent = tpButton

-- تشغيل وإيقاف الأوتو تيليبورت بضغط الزر الصغير
tpButton.MouseButton1Click:Connect(function()
    autoTpActive = not autoTpActive
    if autoTpActive then
        tpButton.Text = "Auto TP: ON"
        tpButton.BackgroundColor3 = Color3.fromRGB(16, 185, 129) -- أخضر
    else
        tpButton.Text = "Auto TP: OFF"
        tpButton.BackgroundColor3 = Color3.fromRGB(30, 41, 59) -- رمادي داكن
    end
end)

-- ==================== 2. حلقة التحديث المستمرة (Auto TP + Noclip + Speed) ====================
RunService.Heartbeat:Connect(function()
    local char = LocalPlayer.Character
    if not char then return end
    
    -- نظام الأوتو تيليبورت المستمر
    if autoTpActive and savedCFrame and char:FindFirstChild("HumanoidRootPart") then
        char.HumanoidRootPart.CFrame = savedCFrame
    end
    
    -- نظام النوب كليب (Noclip)
    if noclipEnabled then
        for _, v in pairs(char:GetDescendants()) do
            if v:IsA("BasePart") then
                v.CanCollide = false
            end
        end
    end
    
    -- نظام السرعة (Speed)
    if speedEnabled and char:FindFirstChild("Humanoid") then
        char.Humanoid.WalkSpeed = 100 -- تعدل السرعة هنا لو بغيت
    end
end)

-- نظام النط اللانهائي (Infinite Jump)
game:GetService("UserInputService").JumpRequest:Connect(function()
    if infiniteJumpEnabled then
        local char = LocalPlayer.Character
        if char and char:FindFirstChildOfClass("Humanoid") then
            char.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)

-- ==================== 3. واجهة الهب الأساسية (AZC Hub - القائمة) ====================
-- ملاحظة: لو كنت تستخدم واجهة HTML خارجية للموقع، تقدر تربط الأزرار، أو تستخدم هذي القائمة البرمجية الداخلية:
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 320, 0, 260)
mainFrame.Position = UDim2.new(0.5, -160, 0.5, -130)
mainFrame.BackgroundColor3 = Color3.fromRGB(15, 23, 42)
mainFrame.BorderColor3 = Color3.fromRGB(56, 189, 248)
mainFrame.Visible = true -- تقدر تخليها مخفية وتظهر بأسلوبك
mainFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 12)
mainCorner.Parent = mainFrame

-- زر حفظ شيك بوينت داخل القائمة
local saveBtn = Instance.new("TextButton")
saveBtn.Size = UDim2.new(0, 135, 0, 45)
saveBtn.Position = UDim2.new(0, 15, 0, 20)
saveBtn.BackgroundColor3 = Color3.fromRGB(30, 41, 59)
saveBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
saveBtn.Text = "حفظ شيك بوينت"
saveBtn.Font = Enum.Font.GothamBold
saveBtn.TextSize = 12
saveBtn.Parent = mainFrame

saveBtn.MouseButton1Click:Connect(function()
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        savedCFrame = char.HumanoidRootPart.CFrame
        saveBtn.Text = "تم الحفظ ✓"
        task.wait(1)
        saveBtn.Text = "حفظ شيك بوينت"
    end
end)

-- زر الانتقال لشيك بوينت (مرة وحدة) داخل القائمة
local tpOnceBtn = Instance.new("TextButton")
tpOnceBtn.Size = UDim2.new(0, 135, 0, 45)
tpOnceBtn.Position = UDim2.new(0, 170, 0, 20)
tpOnceBtn.BackgroundColor3 = Color3.fromRGB(30, 41, 59)
tpOnceBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
tpOnceBtn.Text = "الانتقال لشيك بوينت"
tpOnceBtn.Font = Enum.Font.GothamBold
tpOnceBtn.TextSize = 12
tpOnceBtn.Parent = mainFrame

tpOnceBtn.MouseButton1Click:Connect(function()
    if savedCFrame and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character.HumanoidRootPart.CFrame = savedCFrame
    end
end)

print("AZC Hub Loaded Successfully with Floating Auto-TP!")
