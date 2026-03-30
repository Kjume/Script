--[[
	WARNING: Heads up! This script has not been verified by ScriptBlox. Use at your own risk!
]]
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()
local Window = Fluent:CreateWindow({
    Title = "Be a Lucky Block",
    SubTitle = "by Phemonaz",
    TabWidth = 160,
    Size = UDim2.fromOffset(550, 430),
    Acrylic = false,
    Theme = "Darker",
    MinimizeKey = Enum.KeyCode.LeftControl
})
local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "box" }),
    Upgrades = Window:AddTab({ Title = "Upgrades", Icon = "info" }),
    Brainrots = Window:AddTab({ Title = "Brainrots", Icon = "bot" }),
    Sell = Window:AddTab({ Title = "Sell", Icon = "dollar-sign" }),
    Stats = Window:AddTab({ Title = "Stats", Icon = "gauge" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}



local Options = Fluent.Options
do
-----
-----
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local claimGift = ReplicatedStorage
    :WaitForChild("Packages")
    :WaitForChild("_Index")
    :WaitForChild("sleitnick_knit@1.7.0")
    :WaitForChild("knit")
    :WaitForChild("Services")
    :WaitForChild("PlaytimeRewardService")
    :WaitForChild("RF")
    :WaitForChild("ClaimGift")
local autoClaiming = false
local ACPR = Tabs.Main:AddToggle("ACPR", {
    Title = "Auto Claim Playtime Rewards",
    Default = false
})
ACPR:OnChanged(function(state)
    autoClaiming = state
    if not state then return end
    task.spawn(function()
        while autoClaiming do
            for reward = 1, 12 do
                if not autoClaiming then break end
                local success, err = pcall(function()
                    claimGift:InvokeServer(reward)
                end)
                task.wait(0.25)
            end
            task.wait(1)
        end
    end)
end)
Options.ACPR:SetValue(false)
-----
-----
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local rebirth = ReplicatedStorage
    :WaitForChild("Packages")
    :WaitForChild("_Index")
    :WaitForChild("sleitnick_knit@1.7.0")
    :WaitForChild("knit")
    :WaitForChild("Services")
    :WaitForChild("RebirthService")
    :WaitForChild("RF")
    :WaitForChild("Rebirth")
local running = false
local AR = Tabs.Main:AddToggle("AR", {
    Title = "Auto Rebirth",
    Default = false
})
AR:OnChanged(function(state)
    running = state
    if not state then return end
    task.spawn(function()
        while running do
            pcall(function()
                rebirth:InvokeServer()
            end)
            task.wait(1)
        end
    end)
end)
Options.AR:SetValue(false)
-----
-----
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local claim = ReplicatedStorage
    :WaitForChild("Packages")
    :WaitForChild("_Index")
    :WaitForChild("sleitnick_knit@1.7.0")
    :WaitForChild("knit")
    :WaitForChild("Services")
    :WaitForChild("SeasonPassService")
    :WaitForChild("RF")
    :WaitForChild("ClaimPassReward")
local running = false
local ACEPR = Tabs.Main:AddToggle("ACEPR", {
    Title = "Auto Claim Event Pass Rewards",
    Default = false
})
ACEPR:OnChanged(function(state)
    running = state
    if not state then return end
    task.spawn(function()
        while running do
            local gui = player:WaitForChild("PlayerGui")
                :WaitForChild("Windows")
                :WaitForChild("Event")
                :WaitForChild("Frame")
                :WaitForChild("Frame")
                :WaitForChild("Windows")
                :WaitForChild("Pass")
                :WaitForChild("Main")
                :WaitForChild("ScrollingFrame")
            for i = 1, 10 do
                if not running then break end
                local item = gui:FindFirstChild(tostring(i))
                if item and item:FindFirstChild("Frame") and item.Frame:FindFirstChild("Free") then
                    local free = item.Frame.Free
                    local locked = free:FindFirstChild("Locked")
                    local claimed = free:FindFirstChild("Claimed")
                    while running and locked and locked.Visible do
                        task.wait(0.2)
                    end
                    if running and claimed and claimed.Visible then
                        continue
                    end
                    if running and locked and not locked.Visible then
                        pcall(function()
                            claim:InvokeServer("Free", i)
                        end)
                    end
                end
            end
            task.wait(0.5)
        end
    end)
end)
Options.ACEPR:SetValue(false)
-----
-----
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local redeem = ReplicatedStorage
    :WaitForChild("Packages")
    :WaitForChild("_Index")
    :WaitForChild("sleitnick_knit@1.7.0")
    :WaitForChild("knit")
    :WaitForChild("Services")
    :WaitForChild("CodesService")
    :WaitForChild("RF")
    :WaitForChild("RedeemCode")
local codes = {
    "release"
    -- add more codes here
}
Tabs.Main:AddButton({
    Title = "Redeem All Codes",
    Callback = function()
        for _, code in ipairs(codes) do
            pcall(function()
                redeem:InvokeServer(code)
            end)
            task.wait(1)
        end
    end
})
-----
-----
Tabs.Upgrades:AddSection("Speed Upgrades")
-----
-----
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local upgrade = ReplicatedStorage
    :WaitForChild("Packages")
    :WaitForChild("_Index")
    :WaitForChild("sleitnick_knit@1.7.0")
    :WaitForChild("knit")
    :WaitForChild("Services")
    :WaitForChild("UpgradesService")
    :WaitForChild("RF")
    :WaitForChild("Upgrade")
local amount = 1
local delayTime = 0.5
local running = false
local IMS = Tabs.Upgrades:AddInput("IMS", {
    Title = "Speed Amount",
    Default = "1",
    Placeholder = "Number",
    Numeric = true,
    Finished = false,
    Callback = function(Value)
        amount = tonumber(Value) or 1
    end
})
IMS:OnChanged(function(Value)
    amount = tonumber(Value) or 1
end)
local SMS = Tabs.Upgrades:AddSlider("SMS", {
    Title = "Upgrade Interval",
    Description = "",
    Default = 1,
    Min = 0,
    Max = 5,
    Rounding = 1,
    Callback = function(Value)
        delayTime = Value
    end
})
SMS:OnChanged(function(Value)
    delayTime = Value
end)
SMS:SetValue(1)
local AMS = Tabs.Upgrades:AddToggle("AMS", {
    Title = "Auto Upgrade Speed",
    Default = false
})
AMS:OnChanged(function(state)
    running = state
    if not state then return end
    task.spawn(function()
        while running do
            pcall(function()
                upgrade:InvokeServer("MovementSpeed", amount)
            end)
            task.wait(delayTime)
        end
    end)
end)
Options.AMS:SetValue(false)
-----
-----
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local buy = ReplicatedStorage
    :WaitForChild("Packages")
    :WaitForChild("_Index")
    :WaitForChild("sleitnick_knit@1.7.0")
    :WaitForChild("knit")
    :WaitForChild("Services")
    :WaitForChild("SkinService")
    :WaitForChild("RF")
    :WaitForChild("BuySkin")
local skins = {
    "prestige_mogging_luckyblock",
    "mogging_luckyblock",
    "colossus _luckyblock",
    "inferno_luckyblock",
    "divine_luckyblock",
    "spirit_luckyblock",
    "cyborg_luckyblock",
    "void_luckyblock",
    "gliched_luckyblock",
    "lava_luckyblock",
    "freezy_luckyblock",
    "fairy_luckyblock"
}
local suffix = {
    K = 1e3,
    M = 1e6,
    B = 1e9,
    T = 1e12,
    Qa = 1e15,
    Qi = 1e18,
    Sx = 1e21,
    Sp = 1e24,
    Oc = 1e27,
    No = 1e30,
    Dc = 1e33
}
local function parseCash(text)
    text = text:gsub("%$", ""):gsub(",", ""):gsub("%s+", "")
    local num = tonumber(text:match("[%d%.]+"))
    local suf = text:match("%a+")
    if not num then return 0 end
    if suf and suffix[suf] then
        return num * suffix[suf]
    end
    return num
end
local running = false
local ABL = Tabs.Main:AddToggle("ABL", {
    Title = "Auto Buy Best Luckyblock",
    Default = false
})
ABL:OnChanged(function(state)
    running = state
    if not state then return end
    task.spawn(function()
        while running do
            local gui = player.PlayerGui:FindFirstChild("Windows")
            if not gui then 
                task.wait(1)
                continue 
            end
            local pickaxeShop = gui:FindFirstChild("PickaxeShop")
            if not pickaxeShop then 
                task.wait(1)
                continue 
            end
            local shopContainer = pickaxeShop:FindFirstChild("ShopContainer")
            if not shopContainer then 
                task.wait(1)
                continue 
            end
            local scrollingFrame = shopContainer:FindFirstChild("ScrollingFrame")
            if not scrollingFrame then 
                task.wait(1)
                continue 
            end
            local cash = player.leaderstats.Cash.Value
            local bestSkin = nil
            local bestPrice = 0
            for i = 1, #skins do
                local name = skins[i]
                local item = scrollingFrame:FindFirstChild(name)
                if item then
                    local main = item:FindFirstChild("Main")
                    if main then
                        local buyFolder = main:FindFirstChild("Buy")
                        if buyFolder then
                            local buyButton = buyFolder:FindFirstChild("BuyButton")
                            if buyButton and buyButton.Visible then
                                local cashLabel = buyButton:FindFirstChild("Cash")
                                if cashLabel then
                                    local price = parseCash(cashLabel.Text)
                                    if cash >= price and price > bestPrice then
                                        bestSkin = name
                                        bestPrice = price
                                    end
                                end
                            end
                        end
                    end
                end
            end
            if bestSkin then
                pcall(function()
                    buy:InvokeServer(bestSkin)
                end)
            end
            task.wait(0.5)
        end
    end)
end)
Options.ABL:SetValue(false)
-----
-----
Tabs.Main:AddButton({
    Title = "Sell Held Brainrot",
    Callback = function()
        Window:Dialog({
            Title = "Confirm Sale",
            Content = "Are you sure you want to sell this held Brainrot?",
            Buttons = {
                {
                    Title = "Confirm",
                    Callback = function()
                        local player = game:GetService("Players").LocalPlayer
                        local character = player.Character or player.CharacterAdded:Wait()
                        local tool = character:FindFirstChildOfClass("Tool")
                        if not tool then
                            Fluent:Notify({
                                Title = "ERROR!",
                                Content = "Equip the Brainrot you want to Sell",
                                Duration = 5
                            })
                            return
                        end
                        local entityId = tool:GetAttribute("EntityId")
                        if not entityId then return end
                        local args = {
                            entityId
                        }
                        game:GetService("ReplicatedStorage")
                            :WaitForChild("Packages")
                            :WaitForChild("_Index")
                            :WaitForChild("sleitnick_knit@1.7.0")
                            :WaitForChild("knit")
                            :WaitForChild("Services")
                            :WaitForChild("InventoryService")
                            :WaitForChild("RF")
                            :WaitForChild("SellBrainrot")
                            :InvokeServer(unpack(args))
                        Fluent:Notify({
                            Title = "SOLD!",
                            Content = "Sold: " .. tool.Name,
                            Duration = 5
                        })

                    end
                },
                {
                    Title = "Cancel",
                    Callback = function()
                    end
                }
            }
        })
    end
})
-----
-----
Tabs.Main:AddButton({
    Title = "Pickup All Your Brainrots",
    Callback = function()
        Window:Dialog({
            Title = "Confirm Pickup!",
            Content = "Pick up all Brainrots?",
            Buttons = {
                {
                    Title = "Confirm",
                    Callback = function()
                        local player = game:GetService("Players").LocalPlayer
                        local username = player.Name
                        local plotsFolder = workspace:WaitForChild("Plots")
                        local myPlot
                        for i = 1, 5 do
                            local plot = plotsFolder:FindFirstChild(tostring(i))
                            if plot and plot:FindFirstChild(tostring(i)) then
                                local inner = plot[tostring(i)]
                                for _, v in pairs(inner:GetDescendants()) do
                                    if v:IsA("BillboardGui") and string.find(v.Name, username) then
                                        myPlot = inner
                                        break
                                    end
                                end
                            end
                            if myPlot then break end
                        end
                        if not myPlot then return end
                        local containers = myPlot:FindFirstChild("Containers")
                        if not containers then return end
                        for i = 1, 30 do
                            local containerFolder = containers:FindFirstChild(tostring(i))
                            if containerFolder and containerFolder:FindFirstChild(tostring(i)) then
                                local container = containerFolder[tostring(i)]
                                local innerModel = container:FindFirstChild("InnerModel")
                                if innerModel and #innerModel:GetChildren() > 0 then
                                    local args = {
                                        tostring(i)
                                    }
                                    game:GetService("ReplicatedStorage")
                                        :WaitForChild("Packages")
                                        :WaitForChild("_Index")
                                        :WaitForChild("sleitnick_knit@1.7.0")
                                        :WaitForChild("knit")
                                        :WaitForChild("Services")
                                        :WaitForChild("ContainerService")
                                        :WaitForChild("RF")
                                        :WaitForChild("PickupBrainrot")
                                        :InvokeServer(unpack(args))
                                    task.wait(0.1)
                                end
                            end
                        end
                        Fluent:Notify({
                            Title = "Done!",
                            Content = "Picked up all Brainrots",
                            Duration = 5
                        })
                    end
                },
                {
                    Title = "Cancel",
                    Callback = function()
                    end
                }
            }
        })
    end
})
-----
-----
local storedParts = {}
local folder = workspace:WaitForChild("BossTouchDetectors")
local RBTD = Tabs.Brainrots:AddToggle("RBTD", {
    Title = "Remove Bad Boss Touch Detectors",
    Description = "will make it so only the last boss can capture you",
    Default = false
})
RBTD:OnChanged(function(state)
    if state then
        storedParts = {}
        for _, obj in ipairs(folder:GetChildren()) do
            if obj.Name ~= "base14" then
                table.insert(storedParts, obj)
                obj.Parent = nil
            end
        end
    else
        for _, obj in ipairs(storedParts) do
            if obj then
                obj.Parent = folder
            end
        end
        storedParts = {}
    end
end)
Options.RBTD:SetValue(false)
-----
-----
Tabs.Brainrots:AddButton({
    Title = "Teleport to End",
    Callback = function()
        local modelsFolder = workspace:WaitForChild("RunningModels")
        local target = workspace:WaitForChild("CollectZones"):WaitForChild("base14")
        for _, obj in ipairs(modelsFolder:GetChildren()) do
            if obj:IsA("Model") then
                if obj.PrimaryPart then
                    obj:SetPrimaryPartCFrame(target.CFrame)
                else
                    local part = obj:FindFirstChildWhichIsA("BasePart")
                    if part then
                        part.CFrame = target.CFrame
                    end
                end
            elseif obj:IsA("BasePart") then
                obj.CFrame = target.CFrame
            end
        end
    end
})
-----
-----
Tabs.Brainrots:AddSection("Farming")
local running = false
local AutoFarmToggle = Tabs.Brainrots:AddToggle("AutoFarmToggle", {
    Title = "Auto Farm Best Brainrots",
    Default = false
})
AutoFarmToggle:OnChanged(function(state)
    running = state
    if state then
        task.spawn(function()
            while running do
                local player = game.Players.LocalPlayer
                local character = player.Character or player.CharacterAdded:Wait()
                local root = character:WaitForChild("HumanoidRootPart")
                local humanoid = character:WaitForChild("Humanoid")
                local userId = player.UserId
                local modelsFolder = workspace:WaitForChild("RunningModels")
                local target = workspace:WaitForChild("CollectZones"):WaitForChild("base14")
                root.CFrame = CFrame.new(715, 39, -2122)
                task.wait(0.3)
                humanoid:MoveTo(Vector3.new(710, 39, -2122))
                local ownedModel = nil
                repeat
                    task.wait(0.3)
                    for _, obj in ipairs(modelsFolder:GetChildren()) do
                        if obj:IsA("Model") and obj:GetAttribute("OwnerId") == userId then
                            ownedModel = obj
                            break
                        end
                    end
                until ownedModel ~= nil or not running
                if not running then break end
                if ownedModel.PrimaryPart then
                    ownedModel:SetPrimaryPartCFrame(target.CFrame)
                else
                    local part = ownedModel:FindFirstChildWhichIsA("BasePart")
                    if part then
                        part.CFrame = target.CFrame
                    end
                end
                task.wait(0.7)
                if ownedModel and ownedModel.Parent == modelsFolder then
                    if ownedModel.PrimaryPart then
                        ownedModel:SetPrimaryPartCFrame(target.CFrame * CFrame.new(0, -5, 0))
                    else
                        local part = ownedModel:FindFirstChildWhichIsA("BasePart")
                        if part then
                            part.CFrame = target.CFrame * CFrame.new(0, -5, 0)
                        end
                    end
                end
                repeat
                    task.wait(0.3)
                until not running or (ownedModel == nil or ownedModel.Parent ~= modelsFolder)
                if not running then break end
                local oldCharacter = player.Character
                repeat
                    task.wait(0.2)
                until not running or (player.Character ~= oldCharacter and player.Character ~= nil)
                if not running then break end
                task.wait(0.4)
                local newChar = player.Character
                local newRoot = newChar:WaitForChild("HumanoidRootPart")
                newRoot.CFrame = CFrame.new(737, 39, -2118)
                task.wait(2.1)
            end
        end)
    end
end)
Options.AutoFarmToggle:SetValue(false)
-----
-----
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local running = false
local sliderValue = 1000
local originalSpeed = nil
local currentModel = nil
local function getMyModel()
    local folder = workspace:FindFirstChild("RunningModels")
    if not folder then return nil end
    for _, model in ipairs(folder:GetChildren()) do
        if model:GetAttribute("OwnerId") == player.UserId then
            return model
        end
    end
    return nil
end
local function applySpeed()
    local model = getMyModel()
    if not model then
        currentModel = nil
        return
    end
    if model ~= currentModel then
        currentModel = model
        originalSpeed = model:GetAttribute("MovementSpeed")
    end
    if running then
        if originalSpeed == nil then
            originalSpeed = model:GetAttribute("MovementSpeed")
        end
        model:SetAttribute("MovementSpeed", sliderValue)
    end
end
task.spawn(function()
    while true do
        if running then
            applySpeed()
        end
        task.wait(0.2)
    end
end)
local Toggle = Tabs.Stats:AddToggle("MovementToggle", {
    Title = "Enable Custom Lucky Block Speed",
    Default = false
})
Toggle:OnChanged(function()
    running = Options.MovementToggle.Value
    if not running then
        local model = getMyModel()
        if model and originalSpeed ~= nil then
            model:SetAttribute("MovementSpeed", originalSpeed)
        end
        originalSpeed = nil
        currentModel = nil
    end
end)
local Slider = Tabs.Stats:AddSlider("MovementSlider", {
    Title = "Lucky Block Speed",
    Default = 1000,
    Min = 50,
    Max = 3000,
    Rounding = 0
})
Slider:OnChanged(function(Value)
    sliderValue = Value
end)
-----
-----
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Player = Players.LocalPlayer
local Backpack = Player:WaitForChild("Backpack")
local SellBrainrot = ReplicatedStorage
    :WaitForChild("Packages")
    :WaitForChild("_Index")
    :WaitForChild("sleitnick_knit@1.7.0")
    :WaitForChild("knit")
    :WaitForChild("Services")
    :WaitForChild("InventoryService")
    :WaitForChild("RF")
    :WaitForChild("SellBrainrot")
local Suffixes = {
    K  = 1e3,  M  = 1e6,  B  = 1e9,
    T  = 1e12, QA = 1e15, QI = 1e18,
    SX = 1e21, SP = 1e24, OC = 1e27, NO = 1e30,
}
local function ParseCashPerSec(str)
    if not str then return 0 end
    str = tostring(str)
    local numPart, suffix = str:match("%+?([%d%.]+)(%a*)%$")
    local num = tonumber(numPart) or 0
    if suffix and suffix ~= "" then
        local mult = Suffixes[suffix:upper()]
        if mult then num = num * mult end
    end
    return num
end
local AllNames = {
    "67",
    "agarrini_lapalini",
    "angel_bisonte_giuppitere",
    "angel_job_job_sahur",
    "angela_larila",
    "angelinni_octossini",
    "angelzini_bananini",
    "ballerina_cappuccina",
    "ballerino_lololo",
    "bisonte_giuppitere_giuppitercito",
    "blueberrinni_octossini",
    "bobrito_bandito",
    "bombardino_crocodilo",
    "boneca_ambalabu",
    "brr_brr_patapim",
    "burbaloni_luliloli",
    "cacto_hipopotamo",
    "capuccino_assassino",
    "cathinni_sushinni",
    "cavallo_virtuoso",
    "chachechi",
    "chicleteira_bicicleteira",
    "chimpanzini_bananini",
    "cocofanto_elefanto",
    "devilcino_assassino",
    "devilivion",
    "devupat_kepat_prekupat",
    "diavolero_tralala",
    "ding_sahur",
    "dojonini_assassini",
    "dragoni_cannelloni",
    "ferro_sahur",
    "frigo_camello",
    "frulli_frula",
    "ganganzelli_trulala",
    "gangster_foottera",
    "glorbo_frutodrillo",
    "gorgonzilla",
    "gorillo_watermellondrillo",
    "graipus_medus",
    "i2perfectini_foxinini",
    "job_job_job_sahur",
    "karkirkur",
    "ketupat_kepat_prekupat",
    "la_vacca_saturno_saturnita",
    "las_vaquitas_saturnitas",
    "lerulerulerule",
    "lirili_larila",
    "los_crocodillitos",
    "los_tralaleritos",
    "luminous_yoni",
    "magiani_tankiani",
    "malame",
    "malamevil",
    "mateo",
    "meowl",
    "orangutini_ananassini",
    "orcalero_orcala",
    "pipi_potato",
    "pot_hotspot",
    "raccooni_watermelunni",
    "rang_ring_reng",
    "rhino_toasterino",
    "salamino_penguino",
    "spaghetti_tualetti",
    "spioniro_golubiro",
    "strawberrini_octosini",
    "strawberry_elephant",
    "svinina_bombobardino",
    "ta_ta_ta_ta_sahur",
    "te_te_te_te_sahur",
    "ti_ti_ti_sahur",
    "tigrrullini_watermellini",
    "to_to_to_sahur",
    "toc_toc_sahur",
    "torrtuginni_dragonfrutinni",
    "tracoducotulu_delapeladustuz",
    "tralalero_tralala",
    "trippi_troppi_troppa_trippa",
    "trulimero_trulicina",
    "udin_din_din_dun",
    "yoni",
}
local function GetAllTools()
    local tools = {}
    for _, item in ipairs(Backpack:GetChildren()) do
        if item:IsA("Tool") then table.insert(tools, item) end
    end
    if Player.Character then
        for _, item in ipairs(Player.Character:GetChildren()) do
            if item:IsA("Tool") then table.insert(tools, item) end
        end
    end
    return tools
end
local Toggle = Tabs.Sell:AddToggle("SellToggle", {
    Title   = "Auto Sell Brainrots",
    Default = false,
})
local Slider = Tabs.Sell:AddSlider("SellSlider", {
    Title       = "Sell Interval (s)",
    Description = "How often the auto-sell fires",
    Default     = 2,
    Min         = 0,
    Max         = 10,
    Rounding    = 0,
})
local FilterDropdown = Tabs.Sell:AddDropdown("FilterDropdown", {
    Title   = "Filter What to Sell By",
    Values  = {"Mutation", "Cash/s", "Name"},
    Multi   = false,
    Default = "Mutation",
})
local MutationDropdown = Tabs.Sell:AddDropdown("MutationDropdown", {
    Title   = "Mutations to Sell",
    Values  = {"NORMAL", "CANDY", "GOLD", "DIAMOND", "VOID"},
    Multi   = true,
    Default = {},
})
local NameDropdown = Tabs.Sell:AddDropdown("NameDropdown", {
    Title   = "Names to Sell",
    Values  = AllNames,
    Multi   = true,
    Default = {},
})
local CashInput = Tabs.Sell:AddInput("CashInput", {
    Title       = "Sell Below Cash/s",
    Default     = "0",
    Placeholder = "e.g. 1000000",
    Numeric     = true,
    Finished    = false,
})
local function ShouldSell(tool)
    local filter = Options.FilterDropdown.Value
    if filter == "Mutation" then
        local mutation = tool:GetAttribute("Mutation")
        if not mutation then return false end
        return Options.MutationDropdown.Value[mutation] == true

    elseif filter == "Name" then
        local brainrotType = tool:GetAttribute("BrainrotType")
        if not brainrotType then return false end
        return Options.NameDropdown.Value[brainrotType] == true

    elseif filter == "Cash/s" then
        local cashAttr = tool:GetAttribute("CashPerSec")
        if not cashAttr then return false end
        local toolValue = ParseCashPerSec(tostring(cashAttr))
        local threshold = tonumber(Options.CashInput.Value) or 0
        return toolValue < threshold
    end
    return false
end
local function TrySell(tool)
    local entityId = tool:GetAttribute("EntityId")
    if entityId then
        SellBrainrot:InvokeServer(entityId)
    end
end
task.spawn(function()
    while true do
        local interval = Options.SellSlider.Value
        task.wait(math.max(interval, 0.1))

        if Options.SellToggle.Value then
            for _, tool in ipairs(GetAllTools()) do
                if ShouldSell(tool) then
                    TrySell(tool)
                    task.wait(0.05)
                end
            end
        end
    end
end)
-----
-----
SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({})
InterfaceManager:SetFolder("FluentScriptHub")
SaveManager:SetFolder("FluentScriptHub/specific-game")
InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)
Window:SelectTab(1)
SaveManager:LoadAutoloadConfig()
end
