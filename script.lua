--[[
	WARNING: Heads up! This script has not been verified by ScriptBlox. Use at your own risk!
]]
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- GUI (dərhal yaradılır, gözləmədən əvvəl)
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AutoFarmGui"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = playerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 220, 0, 80)
frame.Position = UDim2.new(0.5, -110, 0, 16)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui

Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 10)

local stroke = Instance.new("UIStroke", frame)
stroke.Color = Color3.fromRGB(80, 80, 80)
stroke.Thickness = 1

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0.45, 0)
title.BackgroundTransparency = 1
title.Text = "Auto Farm  |  [M] Toggle"
title.TextColor3 = Color3.fromRGB(220, 220, 220)
title.Font = Enum.Font.GothamBold
title.TextScaled = true
title.Parent = frame

local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, 0, 0.55, 0)
statusLabel.Position = UDim2.new(0, 0, 0.45, 0)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "OFF"
statusLabel.TextColor3 = Color3.fromRGB(255, 70, 70)

-- Upgrade listesi
local UPGRADES = {
    { currencyName = "Rebirth", max = 6,      upgradeValue = "GrassValue2"  },
    { currencyName = "Rebirth", max = 5,      upgradeValue = "BladeRadius"  },
    { currencyName = "Rebirth", max = 8,      upgradeValue = "SpawnRate2"   },
    { currencyName = "Grass",   max = 7,      upgradeValue = "SpawnRate1"   },
    { currencyName = "Grass",   max = 99,     upgradeValue = "GrassValue"   },
    { currencyName = "Grass",   max = 49,     upgradeValue = "GrassAmount"  },
    { currencyName = "Pop",     max = 15,     upgradeValue = "GrassValue4"  },
    { currencyName = "Pop",     max = 15,     upgradeValue = "RebirthValue2"},
    { currencyName = "Pop",     max = 15,     upgradeValue = "AutoClick"    },
    { currencyName = "Pop",     max = 1e+42,  upgradeValue = "Programmers", amount = 9999 },
    { currencyName = "Bronze",  max = 9999999999999, upgradeValue = "BronzeValue", amount = 9999 },
    { currencyName = "StatPoint", max = 50, upgradeValue = "Stat1" },
    { currencyName = "StatPoint", max = 50, upgradeValue = "Stat2" },
    { currencyName = "StatPoint", max = 50, upgradeValue = "Stat3" },
    { currencyName = "StatPoint", max = 50, upgradeValue = "Stat4" },
    { currencyName = "StatPoint", max = 50, upgradeValue = "Stat5" },
    { currencyName = "Wood",    max = 999, upgradeValue = "SilverValue"     },
    { currencyName = "Wood",    max = 999, upgradeValue = "WoodValue"       },
    { currencyName = "Wood",    max = 15,  upgradeValue = "GrassValue5"     },
    { currencyName = "Wood",    max = 10,  upgradeValue = "Isle1Automation" },
    { currencyName = "Wood",    max = 10,  upgradeValue = "Isle2Automation" },
}

-- UpgradeTree listesi (1-25)
local TREES = (function()
    local t = {}
    for i = 1, 25 do t[i] = i end
    return t
end)()

local Remotes = ReplicatedStorage:WaitForChild("Remotes")

local function fireUpgrade(u)
    local args = {
        [1] = {
            {
                amount       = u.amount or 999,
                autoBuy      = false,
                cost         = 0,
                currencyName = u.currencyName,
                max          = u.max,
                upgradeValue = u.upgradeValue,
            }
        },
        n = 1,
    }
    pcall(function()
        Remotes.Upgrade:FireServer(unpack(args, 1, args.n))
    end)
end

local function fireUpgradeTree(treeNumber)
    local args = { [1] = { treeNumber = treeNumber, treeType = 1 }, n = 1 }
    pcall(function()
        Remotes.UpgradeTree:FireServer(unpack(args, 1, args.n))
    end)
end

local function fireSeedCollect()
    local args = { [1] = { amount = 9999999999 }, n = 1 }
    pcall(function()
        Remotes.SeedCollect:FireServer(unpack(args, 1, args.n))
    end)
end

local function fireIncreaseTree()
    pcall(function()
        Remotes.IncreaseTree:FireServer()
    end)
end

local function fireIncreaseMuscle()
    pcall(function()
        Remotes.IncreaseMuscle:FireServer()
    end)
end

local function fireIncreaseSilver()
    local args = { [1] = 99999, n = 1 }
    pcall(function()
        Remotes.IncreaseSilver:FireServer(unpack(args, 1, args.n))
    end)
end

local function fireGrassCollect()
    local args = {
        [1] = { diamond = 0, golden = 0, normal = 0, ruby = 999, silver = 0 },
        n = 1,
    }
    pcall(function()
        Remotes.GrassCollect:FireServer(unpack(args, 1, args.n))
    end)
end

local running = false

local function runCycle()
    for _, u in ipairs(UPGRADES) do
        if not running then return end
        fireUpgrade(u)
        task.wait(0.01)
    end
    for _, treeNum in ipairs(TREES) do
        if not running then return end
        fireUpgradeTree(treeNum)
        task.wait(0.01)
    end
    if not running then return end
    fireIncreaseTree()
    task.wait(0.01)
    if not running then return end
    fireIncreaseMuscle()
    task.wait(0.01)
    if not running then return end
    fireSeedCollect()
    task.wait(0.01)
    if not running then return end
    fireIncreaseSilver()
    task.wait(0.01)
    if not running then return end
    fireGrassCollect()
    task.wait(0.01)
end

local function toggle()
    running = not running
    if running then
        statusLabel.Text = "ON"
        statusLabel.TextColor3 = Color3.fromRGB(80, 255, 80)
        task.spawn(function()
            while running do
                runCycle()
            end
        end)
    else
        statusLabel.Text = "OFF"
        statusLabel.TextColor3 = Color3.fromRGB(255, 70, 70)
    end
end

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.M then
        toggle()
    end
end)
