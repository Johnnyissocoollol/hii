-- Put this in a LocalScript

local gui = Instance.new("ScreenGui")
gui.Name = "TradeScamGUI"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.Parent = game.CoreGui

-- LOADING SCREEN (appears first)
local loadingFrame = Instance.new("Frame")
loadingFrame.Size = UDim2.new(1, 0, 1, 0)
loadingFrame.Position = UDim2.new(0, 0, 0, 0)
loadingFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
loadingFrame.BackgroundTransparency = 0.8
loadingFrame.ZIndex = 100
loadingFrame.Parent = gui

-- Loading box
local loadingBox = Instance.new("Frame")
loadingBox.Size = UDim2.new(0, 300, 0, 150)
loadingBox.Position = UDim2.new(0.5, -150, 0.5, -75)
loadingBox.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
loadingBox.BorderSizePixel = 0
loadingBox.ZIndex = 101
loadingBox.Parent = loadingFrame

-- Loading title
local loadingTitle = Instance.new("TextLabel")
loadingTitle.Size = UDim2.new(1, 0, 0, 30)
loadingTitle.Position = UDim2.new(0, 0, 0, 10)
loadingTitle.BackgroundTransparency = 1
loadingTitle.Text = "Loading Trade Scam..."
loadingTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
loadingTitle.TextSize = 20
loadingTitle.Font = Enum.Font.SourceSansBold
loadingTitle.ZIndex = 101
loadingTitle.Parent = loadingBox

-- Loading bar background
local loadingBarBg = Instance.new("Frame")
loadingBarBg.Size = UDim2.new(0.8, 0, 0, 25)
loadingBarBg.Position = UDim2.new(0.1, 0, 0, 55)
loadingBarBg.BackgroundColor3 = Color3.fromRGB(60, 60, 65)
loadingBarBg.BorderSizePixel = 0
loadingBarBg.ZIndex = 101
loadingBarBg.Parent = loadingBox

-- Loading bar
local loadingBar = Instance.new("Frame")
loadingBar.Size = UDim2.new(0, 0, 1, 0)
loadingBar.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
loadingBar.BorderSizePixel = 0
loadingBar.ZIndex = 102
loadingBar.Parent = loadingBarBg

-- Loading percentage
local loadingPercent = Instance.new("TextLabel")
loadingPercent.Size = UDim2.new(1, 0, 0, 25)
loadingPercent.Position = UDim2.new(0, 0, 0, 90)
loadingPercent.BackgroundTransparency = 1
loadingPercent.Text = "0%"
loadingPercent.TextColor3 = Color3.fromRGB(200, 200, 200)
loadingPercent.TextSize = 16
loadingPercent.Font = Enum.Font.SourceSans
loadingPercent.ZIndex = 101
loadingPercent.Parent = loadingBox

-- Loading dots animation
local loadingDots = Instance.new("TextLabel")
loadingDots.Size = UDim2.new(1, 0, 0, 30)
loadingDots.Position = UDim2.new(0, 0, 0, 115)
loadingDots.BackgroundTransparency = 1
loadingDots.Text = ""
loadingDots.TextColor3 = Color3.fromRGB(150, 150, 150)
loadingDots.TextSize = 20
loadingDots.Font = Enum.Font.SourceSans
loadingDots.ZIndex = 101
loadingDots.Parent = loadingBox

-- MAIN GUI (hidden initially)
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 280, 0, 200)
frame.Position = UDim2.new(0, 10, 0, 50)
frame.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Visible = false  -- Hidden until loading completes
frame.Parent = gui

-- Title
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
title.Text = "Trade Scam"
title.TextColor3 = Color3.fromRGB(220, 220, 220)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 18
title.Parent = frame

-- Freeze Trade Button
local freezeBtn = Instance.new("TextButton")
freezeBtn.Size = UDim2.new(0.7, 0, 0, 40)
freezeBtn.Position = UDim2.new(0.15, 0, 0, 40)
freezeBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 85)
freezeBtn.Text = "Freeze Trade"
freezeBtn.TextColor3 = Color3.fromRGB(230, 230, 230)
freezeBtn.Font = Enum.Font.SourceSansBold
freezeBtn.TextSize = 16
freezeBtn.BorderSizePixel = 0
freezeBtn.Parent = frame

-- Success message
local successText = Instance.new("TextLabel")
successText.Size = UDim2.new(0.9, 0, 0, 20)
successText.Position = UDim2.new(0.05, 0, 0, 85)
successText.BackgroundTransparency = 1
successText.Text = "Freeze trade success you can remove ur items"
successText.TextColor3 = Color3.fromRGB(100, 255, 100)
successText.TextSize = 12
successText.Font = Enum.Font.SourceSans
successText.Visible = false
successText.Parent = frame

-- Force Accept Button
local acceptBtn = Instance.new("TextButton")
acceptBtn.Size = UDim2.new(0.7, 0, 0, 40)
acceptBtn.Position = UDim2.new(0.15, 0, 0, 140)
acceptBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 85)
acceptBtn.Text = "Force Accept"
acceptBtn.TextColor3 = Color3.fromRGB(230, 230, 230)
acceptBtn.Font = Enum.Font.SourceSansBold
acceptBtn.TextSize = 16
acceptBtn.BorderSizePixel = 0
acceptBtn.Parent = frame

-- FAKE LOADING SCREEN (when freeze button is pressed)
local fakeLoadingFrame = Instance.new("Frame")
fakeLoadingFrame.Size = UDim2.new(1, 0, 1, 0)
fakeLoadingFrame.Position = UDim2.new(0, 0, 0, 0)
fakeLoadingFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
fakeLoadingFrame.BackgroundTransparency = 0.7
fakeLoadingFrame.Visible = false
fakeLoadingFrame.ZIndex = 50
fakeLoadingFrame.Parent = frame

-- Fake loading box
local fakeLoadingBox = Instance.new("Frame")
fakeLoadingBox.Size = UDim2.new(0, 250, 0, 120)
fakeLoadingBox.Position = UDim2.new(0.5, -125, 0.5, -60)
fakeLoadingBox.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
fakeLoadingBox.BorderSizePixel = 0
fakeLoadingBox.ZIndex = 51
fakeLoadingBox.Parent = fakeLoadingFrame

-- Fake loading text
local fakeLoadingText = Instance.new("TextLabel")
fakeLoadingText.Size = UDim2.new(1, 0, 0, 30)
fakeLoadingText.Position = UDim2.new(0, 0, 0, 10)
fakeLoadingText.BackgroundTransparency = 1
fakeLoadingText.Text = "freeze trading hold on..."
fakeLoadingText.TextColor3 = Color3.fromRGB(255, 255, 255)
fakeLoadingText.TextSize = 18
fakeLoadingText.Font = Enum.Font.SourceSansBold
fakeLoadingText.ZIndex = 51
fakeLoadingText.Parent = fakeLoadingBox

-- Fake loading bar background
local fakeLoadingBarBg = Instance.new("Frame")
fakeLoadingBarBg.Size = UDim2.new(0.8, 0, 0, 20)
fakeLoadingBarBg.Position = UDim2.new(0.1, 0, 0, 50)
fakeLoadingBarBg.BackgroundColor3 = Color3.fromRGB(60, 60, 65)
fakeLoadingBarBg.BorderSizePixel = 0
fakeLoadingBarBg.ZIndex = 51
fakeLoadingBarBg.Parent = fakeLoadingBox

-- Fake loading bar
local fakeLoadingBar = Instance.new("Frame")
fakeLoadingBar.Size = UDim2.new(0, 0, 1, 0)
fakeLoadingBar.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
fakeLoadingBar.BorderSizePixel = 0
fakeLoadingBar.ZIndex = 52
fakeLoadingBar.Parent = fakeLoadingBarBg

-- Fake loading percentage
local fakeLoadingPercent = Instance.new("TextLabel")
fakeLoadingPercent.Size = UDim2.new(1, 0, 0, 20)
fakeLoadingPercent.Position = UDim2.new(0, 0, 0, 80)
fakeLoadingPercent.BackgroundTransparency = 1
fakeLoadingPercent.Text = "0%"
fakeLoadingPercent.TextColor3 = Color3.fromRGB(200, 200, 200)
fakeLoadingPercent.TextSize = 14
fakeLoadingPercent.Font = Enum.Font.SourceSans
fakeLoadingPercent.ZIndex = 51
fakeLoadingPercent.Parent = fakeLoadingBox

-- ANIMATE INITIAL LOADING SCREEN (2.5 seconds)
local startTime = tick()
local duration = 2.5

while tick() - startTime < duration do
    local progress = (tick() - startTime) / duration
    loadingBar.Size = UDim2.new(progress, 0, 1, 0)
    loadingPercent.Text = math.floor(progress * 100) .. "%"
    
    -- Animate dots
    local dotCount = math.floor((tick() * 3) % 4)
    loadingDots.Text = string.rep(".", dotCount)
    
    task.wait()
end

-- Complete the loading
loadingBar.Size = UDim2.new(1, 0, 1, 0)
loadingPercent.Text = "100%"
loadingDots.Text = ""

-- Hide loading screen, show main GUI
task.wait(0.5)  -- Brief pause at 100%
loadingFrame.Visible = false
frame.Visible = true

-- Freeze button: show fake loading screen for 2.5 seconds, then success
freezeBtn.MouseButton1Click:Connect(function()
    -- Show fake loading screen
    fakeLoadingFrame.Visible = true
    fakeLoadingBar.Size = UDim2.new(0, 0, 1, 0)
    
    -- Animate fake loading bar for 2.5 seconds
    local fakeStartTime = tick()
    local fakeDuration = 2.5
    
    while tick() - fakeStartTime < fakeDuration do
        local progress = (tick() - fakeStartTime) / fakeDuration
        fakeLoadingBar.Size = UDim2.new(progress, 0, 1, 0)
        fakeLoadingPercent.Text = math.floor(progress * 100) .. "%"
        task.wait()
    end
    
    -- Complete the bar
    fakeLoadingBar.Size = UDim2.new(1, 0, 1, 0)
    fakeLoadingPercent.Text = "100%"
    
    -- Hide fake loading screen
    fakeLoadingFrame.Visible = false
    
    -- Show success message
    successText.Visible = true
    task.wait(5)
    successText.Visible = false
end)

-- Force accept button does nothing
