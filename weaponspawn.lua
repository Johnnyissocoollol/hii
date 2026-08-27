local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local LP = Players.LocalPlayer

-- ============================================================
-- WEAPON DATABASE
-- ============================================================
local WeaponDB = nil
local weaponLookup = {}

local function initWeaponDB()
    if WeaponDB then return end
    pcall(function()
        local Sync = require(ReplicatedStorage:WaitForChild("Database"):WaitForChild("Sync"))
        WeaponDB = Sync.Weapons
        if WeaponDB then
            for key, info in pairs(WeaponDB) do
                if type(info) == "table" then
                    local kl = key:lower()
                    weaponLookup[kl] = weaponLookup[kl] or key
                    local dn = info.ItemName or info.DisplayName or info.Name
                    if dn then
                        dn = tostring(dn):lower()
                        weaponLookup[dn] = weaponLookup[dn] or key
                    end
                end
            end
        end
    end)
end

local function resolveWeaponInput(text)
    if not text or text == "" then return nil end
    text = text:gsub("^%s+", ""):gsub("%s+$", "")
    if text == "" then return nil end
    if WeaponDB and WeaponDB[text] then return text end
    return weaponLookup[text:lower()]
end

-- ============================================================
-- SPAWN METHODS
-- ============================================================
local function spawnWeaponToInventory(name, amount)
    amount = amount or 1
    initWeaponDB()
    if not WeaponDB then return false end
    pcall(function()
        local ProfileData = require(ReplicatedStorage:WaitForChild("Modules"):WaitForChild("ProfileData"))
        local InvDataChanged = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Inventory"):WaitForChild("InventoryDataChanged")
        local owned = ProfileData.Weapons.Owned
        owned[name] = (owned[name] or 0) + amount
        InvDataChanged:Fire("Weapons", name, owned[name])
    end)
    return true
end

local CRATE = "KnifeBox4"
local _BC = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Shop"):WaitForChild("BoxController")

local function spawnWeaponViaBox(name)
    pcall(function()
        local payload = {{MysteryBoxId = CRATE, RewardedItemId = name}}
        _BC:Fire(payload)
    end)
    return true
end

local function spawnWeaponCombined(name, amount)
    amount = amount or 1
    spawnWeaponToInventory(name, amount)
    for i = 1, amount do
        spawnWeaponViaBox(name)
    end
    return true
end

-- ============================================================
-- GUI - PROFESSIONAL GREY
-- ============================================================
local sg = Instance.new("ScreenGui")
sg.Name = "Spawner"
sg.ResetOnSpawn = false
sg.IgnoreGuiInset = true
sg.Parent = CoreGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 340, 0, 200)
frame.Position = UDim2.new(0.5, -170, 0.5, -100)
frame.BackgroundColor3 = Color3.fromRGB(28, 28, 33)
frame.BorderSizePixel = 0
frame.Parent = sg

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 6)
corner.Parent = frame

local border = Instance.new("UIStroke")
border.Color = Color3.fromRGB(50, 50, 55)
border.Thickness = 1
border.Parent = frame

-- Title Bar
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 36)
titleBar.BackgroundColor3 = Color3.fromRGB(23, 23, 28)
titleBar.BorderSizePixel = 0
titleBar.Parent = frame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 6)
titleCorner.Parent = titleBar

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, -44, 1, 0)
titleLabel.Position = UDim2.new(0, 14, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "murder mystery 2 weapon spawner"
titleLabel.TextColor3 = Color3.fromRGB(200, 200, 210)
titleLabel.TextSize = 13
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = titleBar

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 24, 0, 24)
closeBtn.Position = UDim2.new(1, -32, 0, 6)
closeBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
closeBtn.BorderSizePixel = 0
closeBtn.Text = ""
closeBtn.Parent = titleBar

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 4)
closeCorner.Parent = closeBtn

local closeIcon = Instance.new("TextLabel")
closeIcon.Size = UDim2.new(1, 0, 1, 0)
closeIcon.BackgroundTransparency = 1
closeIcon.Text = "✕"
closeIcon.TextColor3 = Color3.fromRGB(150, 150, 160)
closeIcon.TextSize = 12
closeIcon.Font = Enum.Font.Gotham
closeIcon.Parent = closeBtn

closeBtn.MouseButton1Click:Connect(function()
    sg:Destroy()
end)

-- Divider
local divider = Instance.new("Frame")
divider.Size = UDim2.new(1, -24, 0, 1)
divider.Position = UDim2.new(0, 12, 0, 36)
divider.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
divider.BorderSizePixel = 0
divider.Parent = frame

-- Weapon Label
local weaponLabel = Instance.new("TextLabel")
weaponLabel.Size = UDim2.new(1, -24, 0, 16)
weaponLabel.Position = UDim2.new(0, 12, 0, 44)
weaponLabel.BackgroundTransparency = 1
weaponLabel.Text = "weapon"
weaponLabel.TextColor3 = Color3.fromRGB(140, 140, 150)
weaponLabel.TextSize = 10
weaponLabel.Font = Enum.Font.GothamBold
weaponLabel.TextXAlignment = Enum.TextXAlignment.Left
weaponLabel.Parent = frame

-- Input
local inputBox = Instance.new("TextBox")
inputBox.Size = UDim2.new(1, -24, 0, 34)
inputBox.Position = UDim2.new(0, 12, 0, 62)
inputBox.BackgroundColor3 = Color3.fromRGB(38, 38, 43)
inputBox.BorderSizePixel = 0
inputBox.Text = ""
inputBox.PlaceholderText = "type weapon name..."
inputBox.TextColor3 = Color3.fromRGB(210, 210, 220)
inputBox.PlaceholderColor3 = Color3.fromRGB(100, 100, 110)
inputBox.Font = Enum.Font.Gotham
inputBox.TextSize = 13
inputBox.ClearTextOnFocus = false
inputBox.Parent = frame

local inputCorner = Instance.new("UICorner")
inputCorner.CornerRadius = UDim.new(0, 4)
inputCorner.Parent = inputBox

local inputBorder = Instance.new("UIStroke")
inputBorder.Color = Color3.fromRGB(50, 50, 55)
inputBorder.Thickness = 1
inputBorder.Parent = inputBox

-- Amount Label
local amountLabel = Instance.new("TextLabel")
amountLabel.Size = UDim2.new(0.25, -12, 0, 16)
amountLabel.Position = UDim2.new(0, 12, 0, 102)
amountLabel.BackgroundTransparency = 1
amountLabel.Text = "amount"
amountLabel.TextColor3 = Color3.fromRGB(140, 140, 150)
amountLabel.TextSize = 10
amountLabel.Font = Enum.Font.GothamBold
amountLabel.TextXAlignment = Enum.TextXAlignment.Left
amountLabel.Parent = frame

-- Amount Box
local amountBox = Instance.new("TextBox")
amountBox.Size = UDim2.new(0.22, -12, 0, 34)
amountBox.Position = UDim2.new(0, 12, 0, 120)
amountBox.BackgroundColor3 = Color3.fromRGB(38, 38, 43)
amountBox.BorderSizePixel = 0
amountBox.Text = "1"
amountBox.TextColor3 = Color3.fromRGB(210, 210, 220)
amountBox.PlaceholderColor3 = Color3.fromRGB(100, 100, 110)
amountBox.Font = Enum.Font.Gotham
amountBox.TextSize = 13
amountBox.ClearTextOnFocus = false
amountBox.Parent = frame

local amountCorner = Instance.new("UICorner")
amountCorner.CornerRadius = UDim.new(0, 4)
amountCorner.Parent = amountBox

local amountBorder = Instance.new("UIStroke")
amountBorder.Color = Color3.fromRGB(50, 50, 55)
amountBorder.Thickness = 1
amountBorder.Parent = amountBox

-- Spawn Button
local spawnBtn = Instance.new("TextButton")
spawnBtn.Size = UDim2.new(0.74, -8, 0, 34)
spawnBtn.Position = UDim2.new(0.26, 0, 0, 120)
spawnBtn.BackgroundColor3 = Color3.fromRGB(55, 55, 62)
spawnBtn.BorderSizePixel = 0
spawnBtn.Text = "spawn"
spawnBtn.TextColor3 = Color3.fromRGB(215, 215, 225)
spawnBtn.Font = Enum.Font.GothamBold
spawnBtn.TextSize = 14
spawnBtn.AutoButtonColor = false
spawnBtn.Parent = frame

local spawnCorner = Instance.new("UICorner")
spawnCorner.CornerRadius = UDim.new(0, 4)
spawnCorner.Parent = spawnBtn

local spawnBorder = Instance.new("UIStroke")
spawnBorder.Color = Color3.fromRGB(60, 60, 67)
spawnBorder.Thickness = 1
spawnBorder.Parent = spawnBtn

-- Status
local statusLbl = Instance.new("TextLabel")
statusLbl.Size = UDim2.new(1, -24, 0, 20)
statusLbl.Position = UDim2.new(0, 12, 0, 162)
statusLbl.BackgroundTransparency = 1
statusLbl.Text = "ready"
statusLbl.TextColor3 = Color3.fromRGB(120, 120, 130)
statusLbl.Font = Enum.Font.Gotham
statusLbl.TextSize = 11
statusLbl.TextXAlignment = Enum.TextXAlignment.Left
statusLbl.Parent = frame

-- ============================================================
-- DRAG
-- ============================================================
local dragging = false
local dragStart = Vector2.new()
local startPos = UDim2.new()

local function startDrag(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or 
       input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = frame.Position
    end
end

local function endDrag(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or 
       input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end

local function updateDrag(input)
    if not dragging then return end
    if input.UserInputType == Enum.UserInputType.MouseMovement or 
       input.UserInputType == Enum.UserInputType.Touch then
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y
        )
    end
end

titleBar.InputBegan:Connect(startDrag)
titleBar.InputEnded:Connect(endDrag)
UserInputService.InputChanged:Connect(updateDrag)

frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or 
       input.UserInputType == Enum.UserInputType.Touch then
        local pos = input.Position
        local absPos = frame.AbsolutePosition
        local relY = pos.Y - absPos.Y
        if relY > 62 and relY < 96 then return end
        if relY > 120 and relY < 154 then return end
        if relY < 36 then return end
        startDrag(input)
    end
end)

frame.InputEnded:Connect(endDrag)

-- ============================================================
-- SPAWN
-- ============================================================
initWeaponDB()

spawnBtn.MouseButton1Click:Connect(function()
    local weaponName = inputBox.Text
    if weaponName == "" then
        statusLbl.Text = "enter a weapon name"
        statusLbl.TextColor3 = Color3.fromRGB(200, 130, 130)
        return
    end
    
    local amount = tonumber(amountBox.Text)
    if not amount or amount < 1 then
        amount = 1
        amountBox.Text = "1"
    end
    
    local resolvedKey = resolveWeaponInput(weaponName)
    if not resolvedKey then
        statusLbl.Text = "unknown weapon"
        statusLbl.TextColor3 = Color3.fromRGB(200, 130, 130)
        return
    end
    
    spawnWeaponCombined(resolvedKey, amount)
    statusLbl.Text = "spawned " .. resolvedKey:lower() .. " x" .. amount
    statusLbl.TextColor3 = Color3.fromRGB(130, 200, 130)
    
    task.spawn(function()
        task.wait(2.5)
        statusLbl.Text = "ready"
        statusLbl.TextColor3 = Color3.fromRGB(120, 120, 130)
    end)
end)

inputBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        spawnBtn.MouseButton1Click:Fire()
    end
end)

amountBox.FocusLost:Connect(function()
    local num = tonumber(amountBox.Text)
    if not num or num < 1 then
        amountBox.Text = "1"
    end
end)
