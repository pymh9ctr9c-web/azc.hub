local P, RS = game:GetService("Players"), game:GetService("RunService")
local plr = P.LocalPlayer
local pgui = plr:WaitForChild("PlayerGui")

for _, v in ipairs({"AM", "WelcomeGui"}) do
    if pgui:FindFirstChild(v) then
        pgui[v]:Destroy()
    end
end

local wg = Instance.new("ScreenGui", pgui)
wg.Name = "WelcomeGui"
wg.IgnoreGuiInset = true
wg.ResetOnSpawn = false

local wf = Instance.new("Frame", wg)
wf.Size = UDim2.new(1, 0, 1, 0)
wf.BackgroundColor3 = Color3.new(0, 0, 0)

local wt = Instance.new("TextLabel", wf)
wt.Size = UDim2.new(1, 0, 0, 120)
wt.Position = UDim2.new(0, 0, 0.5, -80)
wt.BackgroundTransparency = 1
wt.Text = "Discord: a0nlvd"
wt.TextColor3 = Color3.new(1, 1, 1)
wt.Font = Enum.Font.GothamBold
wt.TextSize = 24

local wbtn = Instance.new("TextButton", wf)
wbtn.Size = UDim2.new(0, 220, 0, 50)
wbtn.Position = UDim2.new(0.5, -110, 0.5, 50)
wbtn.BackgroundColor3 = Color3.fromRGB(0, 136, 255)
wbtn.Text = "دخول"
wbtn.TextColor3 = Color3.new(1, 1, 1)
wbtn.Font = Enum.Font.GothamBold
wbtn.TextSize = 20
Instance.new("UICorner", wbtn).CornerRadius = UDim.new(0, 16)

local mg = Instance.new("ScreenGui", pgui)
mg.Name = "AM"
mg.ResetOnSpawn = false
mg.Enabled = false

local mf = Instance.new("Frame", mg)
mf.Size = UDim2.new(0, 320, 0, 215)
mf.Position = UDim2.new(0.5, -160, 0.5, -107)
mf.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
mf.Active = true
mf.Draggable = true
Instance.new("UICorner", mf).CornerRadius = UDim.new(0, 18)
local mfStroke = Instance.new("UIStroke", mf)
mfStroke.Color = Color3.fromRGB(50, 50, 70)

local topBar = Instance.new("Frame", mf)
topBar.Size = UDim2.new(1, 0, 0, 34)
topBar.BackgroundColor3 = Color3.fromRGB(24, 24, 32)
Instance.new("UICorner", topBar).CornerRadius = UDim.new(0, 18)

local tl = Instance.new("TextLabel", topBar)
tl.Size = UDim2.new(1, -40, 1, 0)
tl.Position = UDim2.new(0, 12, 0, 0)
tl.BackgroundTransparency = 1
tl.Text = "AZC Hub"
tl.TextColor3 = Color3.new(1, 1, 1)
tl.Font = Enum.Font.GothamBold
tl.TextSize = 14
tl.TextXAlignment = Enum.TextXAlignment.Left

local cb = Instance.new("TextButton", topBar)
cb.Size = UDim2.new(0, 24, 0, 24)
cb.Position = UDim2.new(1, -28, 0.5, -12)
cb.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
cb.Text = "✕"
cb.TextColor3 = Color3.new(1, 1, 1)
cb.Font = Enum.Font.GothamBold
cb.TextSize = 12
Instance.new("UICorner", cb).CornerRadius = UDim.new(0, 8)
cb.MouseButton1Click:Connect(function()
    mf.Visible = false
end)

local tb = Instance.new("TextButton", mg)
tb.Size = UDim2.new(0, 45, 0, 40)
tb.Position = UDim2.new(0.5, -22, 0, 10)
tb.BackgroundColor3 = Color3.fromRGB(24, 24, 32)
tb.Text = "AZC"
tb.TextColor3 = Color3.new(1, 1, 1)
tb.Font = Enum.Font.GothamBold
tb.TextSize = 14
tb.Draggable = true
Instance.new("UICorner", tb).CornerRadius = UDim.new(0, 12)
local tbStroke = Instance.new("UIStroke", tb)
tbStroke.Color = Color3.fromRGB(0, 170, 255)
tb.MouseButton1Click:Connect(function()
    mf.Visible = not mf.Visible
end)

local function mkB(col, row, txt, stat)
    local b = Instance.new("TextButton", mf)
    b.Size = UDim2.new(0, 138, 0, 34)
    b.Position = UDim2.new(0, (col == 1) and 14 or 168, 0, 45 + (row * 39))
    b.BackgroundColor3 = stat and Color3.fromRGB(28, 28, 38) or Color3.fromRGB(25, 25, 25)
    b.Text = txt
    b.TextColor3 = Color3.fromRGB(210, 210, 220)
    b.Font = Enum.Font.GothamMedium
    b.TextSize = 12
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 9)
    return b
end

local iBtn = mkB(1, 0, "نط لانهائي: OFF")
local ajBtn = mkB(2, 0, "Auto Jump: OFF")
local sBtn = mkB(1, 1, "Speed: OFF")
local scBtn = mkB(2, 1, "حفظ شيك بوينت", true)
local nBtn = mkB(1, 2, "Noclip: OFF")
local tpBtn = mkB(2, 2, "الانتقال لشيك بوينت", true)
local eBtn = mkB(1, 3, "كشف: OFF")
local flyBtn = mkB(2, 3, "ᵃᶻᶜfly: OFF")

local iA, ajA, sA, eA, nA, flyA, active = false, false, false, false, false, false, false
local eL, aL, savedPos = {}, {}, nil

wbtn.MouseButton1Click:Connect(function()
    active = true
    mg.Enabled = true
    wg:Destroy()
end)

RS.RenderStepped:Connect(function()
    if not active then return end
    local hum = plr.Character and plr.Character:FindFirstChildOfClass("Humanoid")
    if hum then
        if iA then
            hum.UseJumpPower = true
            if hum.Jump then
                hum:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end
        if ajA and hum.FloorMaterial ~= Enum.Material.Air then
            hum:ChangeState(Enum.HumanoidStateType.Jumping)
        end
        if sA then
            hum.WalkSpeed = 300
        end
    end
    if nA and plr.Character then
        for _, p in ipairs(plr.Character:GetDescendants()) do
            if p:IsA("BasePart") then
                p.CanCollide = false
            end
        end
    end
end)

local function tgl(btn, state, name)
    state = not state
    btn.Text = name .. (state and ": ON" or ": OFF")
    btn.BackgroundColor3 = state and Color3.fromRGB(240, 240, 240) or Color3.fromRGB(25, 25, 25)
    btn.TextColor3 = state and Color3.fromRGB(0, 0, 0) or Color3.fromRGB(210, 210, 220)
    return state
end

iBtn.MouseButton1Click:Connect(function()
    if active then iA = tgl(iBtn, iA, "نط لانهائي") end
end)

ajBtn.MouseButton1Click:Connect(function()
    if active then ajA = tgl(ajBtn, ajA, "Auto Jump") end
end)

sBtn.MouseButton1Click:Connect(function()
    if active then
        sA = tgl(sBtn, sA, "Speed")
        if not sA and plr.Character and plr.Character:FindFirstChildOfClass("Humanoid") then
            plr.Character.Humanoid.WalkSpeed = 16
        end
    end
end)

nBtn.MouseButton1Click:Connect(function()
    if active then nA = tgl(nBtn, nA, "Noclip") end
end)

eBtn.MouseButton1Click:Connect(function()
    if not active then return end
    eA = tgl(eBtn, eA, "كشف")
    if eA then
        for _, p in ipairs(P:GetPlayers()) do
            if p ~= plr and p.Character and p.Character:FindFirstChild("Head") then
                local hl = Instance.new("Highlight", p.Character)
                hl.FillColor = Color3.fromRGB(255, 0, 0)
                hl.FillTransparency = 0.6
                table.insert(eL, hl)
                
                local bg = Instance.new("BillboardGui", p.Character.Head)
                bg.Size = UDim2.new(0, 30, 0, 30)
                bg.StudsOffset = Vector3.new(0, 2, 0)
                bg.AlwaysOnTop = true
                
                local tl2 = Instance.new("TextLabel", bg)
                tl2.Size = UDim2.new(1, 0, 1, 0)
                tl2.BackgroundTransparency = 1
                tl2.Text = "🔻"
                tl2.TextSize = 20
                table.insert(aL, bg)
            end
        end
    else
        for _, v in ipairs(eL) do if v then v:Destroy() end end
        for _, v in ipairs(aL) do if v then v:Destroy() end end
        eL, aL = {}, {}
    end
end)

scBtn.MouseButton1Click:Connect(function()
    if active and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
        savedPos = plr.Character.HumanoidRootPart.CFrame
    end
end)

tpBtn.MouseButton1Click:Connect(function()
    if active and savedPos and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
        plr.Character.HumanoidRootPart.CFrame = savedPos
    end
end)

flyBtn.MouseButton1Click:Connect(function()
    if not active then return end
    flyA = tgl(flyBtn, flyA, "ᵃᶻᶜfly")
    if flyA then
        pcall(function()
            loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Future-of-Fly-V3-X-235903"))()
        end)
    end
end)
