-- AZC Hub - Complete Script with Checkpoint & Auto-TP Button
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")

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

-- ==================== الواجهة الرئيسية (AZC Hub) ====================
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 320, 0, 310)
mainFrame.Position = UDim2.new(0.5, -160, 0.5, -155)
mainFrame.BackgroundColor3 = Color3.fromRGB(15, 23, 42)
mainFrame.BorderColor3 = Color3.fromRGB(56, 189, 248)
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 12)
mainCorner.Parent = mainFrame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.fromRGB(56, 189, 248)
title.TextSize = 18
title.Font = Enum.Font.GothamBold
title.Text = "AZC Hub"
title.Parent = mainFrame

-- ==================== زر "شيك بوينت" المخصص داخل القائمة ====================
local checkpointMenuBtn = Instance.new("TextButton")
checkpointMenuBtn.Size = UDim2.new(0, 280, 0, 45)
checkpointMenuBtn.Position = UDim2.new(0, 20, 0, 50)
checkpointMenuBtn.BackgroundColor3 = Color3.fromRGB(30, 41, 59)
checkpointMenuBtn.BorderColor3 = Color3.fromRGB(56, 189, 248)
checkpointMenuBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
checkpointMenuBtn.TextSize = 14
checkpointMenuBtn.Font = Enum.Font.GothamBold
checkpointMenuBtn.Text = "📍 شيك بوينت (فتح القائمة)"
checkpointMenuBtn.Parent = mainFrame

local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 8)
btnCorner.Parent = checkpointMenuBtn

-- عند الضغط على زر "شيك بوينت" يفتح لك أزرار الحفظ والانتقال والزر العائم
checkpointMenuBtn.MouseButton1Click:Connect(function()
    checkpointMenuBtn.Text = "تم تفعيل شيك بوينت ✓"
    checkpointMenuBtn.BackgroundColor3 = Color3.fromRGB(16, 185, 129)
    
    -- إنشاء الزر الصغير العائم برى القائمة (للتشغيل والإيقاف المستمر)
    if not screenGui:FindFirstChild("AutoTpToggle") then
        local tpButton = Instance.new("TextButton")
        tpButton.Name = "AutoTpToggle"
        tpButton.Size = UDim2.new(0, 110, 0, 40)
        tpButton.Position = UDim2.new(0, 20, 0, 150)
        tpButton.BackgroundColor3 = Color3.fromRGB(30, 41, 59)
        tpButton.BorderColor3 = Color3.fromRGB(56, 189, 248)
        tpButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        tpButton.TextSize = 14
        tpButton.Font = Enum.Font.GothamBold
        tpButton.Text = "Auto TP: OFF"
        tpButton.Active = true
        tpButton.Draggable = true
        tpButton.Parent = screenGui

        local tpCorner = Instance.new("UICorner")
        tpCorner.CornerRadius = UDim.new(0, 8)
        tpCorner.Parent = tpButton

        tpButton.MouseButton1Click:Connect(function()
            autoTpActive = not autoTpActive
            if autoTpActive then
                tpButton.Text = "Auto TP: ON"
                tpButton.BackgroundColor3 = Color3.fromRGB(16, 185, 129)
            else
                tpButton.Text = "Auto TP: OFF"
                tpButton.BackgroundColor3 = Color3.fromRGB(30, 41, 59)
            end
        end)
    end

    -- إنشاء أزرار الحفظ والانتقال داخل القائمة تحت زر شيك بوينت
    if not mainFrame:FindFirstChild("SaveBtn") then
        local saveBtn = Instance.new("TextButton")
        saveBtn.Name = "SaveBtn"
        saveBtn.Size = UDim2.new(0, 132, 0, 40)
        saveBtn.Position = UDim2.new(0, 20, 0, 105)
        saveBtn.BackgroundColor3 = Color3.fromRGB(51, 65, 85)
        saveBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        saveBtn.Text = "حفظ المكان"
        saveBtn.Font = Enum.Font.GothamBold
        saveBtn.TextSize = 12
        saveBtn.Parent = mainFrame
        
        local sc = Instance.new("UICorner") sc.CornerRadius = UDim.new(0, 6) sc.Parent = saveBtn

        saveBtn.MouseButton1Click:Connect(function()
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                savedCFrame = char.HumanoidRootPart.CFrame
                saveBtn.Text = "تم الحفظ!"
                task.wait(1)
                saveBtn.Text = "حفظ المكان"
            end
        end)

        local tpOnceBtn = Instance.new("TextButton")
        tpOnceBtn.Name = "TpOnceBtn"
        tpOnceBtn.Size = UDim2.new(0, 132, 0, 40)
        tpOnceBtn.Position = UDim2.new(0, 168, 0, 105)
        tpOnceBtn.BackgroundColor3 = Color3.fromRGB(51, 65, 85)
        tpOnceBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        tpOnceBtn.Text = "انتقال مرة"
        tpOnceBtn.Font = Enum.Font.GothamBold
        tpOnceBtn.TextSize= 12
        tpOnceBtn.Parent = mainFrame
        
        local tc = Instance.new("UICorner") tc.CornerRadius = UDim.new(0, 6) tc.Parent = tpOnceBtn

        tpOnceBtn.MouseButton1Click:Connect(function()
            if savedCFrame and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                LocalPlayer.Character.HumanoidRootPart.CFrame = savedCFrame
            end
        end)
    end
end)

-- ==================== الأزرار الأخرى (نط / سرعة / نوب كليب) ====================
local infJumpBtn = Instance.new("TextButton")
infJumpBtn.Size = UDim2.new(0, 132, 0, 40)
infJumpBtn.Position = UDim2.new(0, 20, 0, 155)
infJumpBtn.BackgroundColor3 = Color3.fromRGB(30, 41, 59)
infJumpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
infJumpBtn.Text = "نط لنهائي: OFF"
infJumpBtn.Font = Enum.Font.GothamBold
infJumpBtn.TextSize = 11
infJumpBtn.Parent = mainFrame
local ijc = Instance.new("UICorner") ijc.CornerRadius = UDim.new(0, 6) ijc.Parent = infJumpBtn

infJumpBtn.MouseButton1Click:Connect(function()
    infiniteJumpEnabled = not infiniteJumpEnabled
    infJumpBtn.Text = infiniteJumpEnabled and "نط لنهائي: ON" or "نط لنهائي: OFF"
    infJumpBtn.BackgroundColor3 = infiniteJumpEnabled and Color3.fromRGB(16, 185, 129) or Color3.fromRGB(30, 41, 59)
end)

local speedBtn = Instance.new("TextButton")
speedBtn.Size = UDim2.new(0, 132, 0, 40)
speedBtn.Position = UDim2.new(0, 168, 0, 155)
speedBtn.BackgroundColor3 = Color3.fromRGB(30, 41, 59)
speedBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
speedBtn.Text = "Speed: OFF"
speedBtn.Font = Enum.Font.GothamBold
speedBtn.TextSize = 11
speedBtn.Parent = mainFrame
local sbc = Instance.new("UICorner") sbc.CornerRadius = UDim.new(0, 6) sbc.Parent = speedBtn

speedBtn.MouseButton1Click:Connect(function()
    speedEnabled = not speedEnabled
    speedBtn.Text = speedEnabled and "Speed: ON" or "Speed: OFF"
    speedBtn.BackgroundColor3 = speedEnabled and Color3.fromRGB(16, 185, 129) or Color3.fromRGB(30, 41, 59)
end)

local noclipBtn = Instance.new("TextButton")
noclipBtn.Size = UDim2.new(0, 280, 0, 40)
noclipBtn.Position = UDim2.new(0, 20, 0, 205)
noclipBtn.BackgroundColor3 = Color3.fromRGB(30, 41, 59)
noclipBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
noclipBtn.Text = "Noclip: OFF"
noclipBtn.Font = Enum.Font.GothamBold
noclipBtn.TextSize = 12
noclipBtn.Parent = mainFrame
local ncc = Instance.new("UICorner") ncc.CornerRadius = UDim.new(0, 6) ncc.Parent = noclipBtn

noclipBtn.MouseButton1Click:Connect(function)
    noclipEnabled = not noclipEnabled
    noclipBtn.Text = noclipEnabled and "Noclip: ON" or "Noclip: OFF"
    noclipBtn.BackgroundColor3 = noclipEnabled and Color3.fromRGB(16, 185, 129) or Color3.fromRGB(30, 41, 59)
end)

-- ==================== الحلقات والوظائف المستمرة ====================
RunService.Heartbeat:Connect(function()
    local char = LocalPlayer.Character
    if not char then return end
    
    -- الأوتو تيليبورت المستمر
    if autoTpActive and savedCFrame and char:FindFirstChild("HumanoidRootPart") then
        char.HumanoidRootPart.CFrame = savedCFrame
    end
    
    -- النوب كليب
    if noclipEnabled then
        for _, v in pairs(char:GetDescendants()) do
            if v:IsA("BasePart") then
                v.CanCollide = false
            end
        end
    end
    
    -- السرعة
    if speedEnabled and char:FindFirstChild("Humanoid") then
        char.Humanoid.WalkSpeed = 100
    end
end)

UserInputService.JumpRequest:Connect(function()
    if infiniteJumpEnabled then
        local char = LocalPlayer.Character
        if char and char:FindFirstChildOfClass("Humanoid") then
            char.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)

print("AZC Hub Updated with Checkpoint!")
