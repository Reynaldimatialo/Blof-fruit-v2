-- Informasi Bos
local bossName = "Kapten Brute"
local bossLevel = 50
local bossHealth = 1000
local bossSpawnLocation = Vector3.new(-200, 10, 500)

-- Informasi Quest
local questName = "Kalahkan Kapten Brute"
local questDescription = "Kapten Brute telah meneror pulau. Kalahkan dia!"
local questRewardXP = 250
local questRewardMoney = 99999999

-- Fungsi untuk membuat bos
local function spawnBoss()
    local boss = Instance.new("Humanoid")
    boss.Name = bossName
    boss.MaxHealth = bossHealth
    boss.Health = bossHealth

    local humanoidPart = Instance.new("Part")
    humanoidPart.Size = Vector3.new(3, 6, 3)
    humanoidPart.Anchored = true
    humanoidPart.CFrame = CFrame.new(bossSpawnLocation)

    boss.Parent = humanoidPart
    humanoidPart.Parent = workspace

    return boss
end

-- Fungsi untuk memulai quest
local function startQuest(player)
    player.leaderstats.Quests.Value = questName
    player:ChatPrint("Quest dimulai: " .. questName)
    updateQuest("Kalahkan Kapten Brute (0/1)", questRewardMoney, questRewardXP)

    local boss = spawnBoss()

    boss.Died:Connect(function()
        player.leaderstats.Experience.Value = player.leaderstats.Experience.Value + questRewardXP
        player.leaderstats.Beli.Value = player.leaderstats.Beli.Value + questRewardMoney
        player:ChatPrint("Quest selesai! Anda mendapatkan " .. questRewardXP .. " XP dan " .. questRewardMoney .. " Beli.")
        player.leaderstats.Quests.Value = "Tidak ada"
        boss.Parent.Parent:Destroy()
        screenGui:Destroy()
    end)
end

-- Fungsi untuk memulai quest ketika pemain bergabung
local function onPlayerJoined(player)
    -- Tunggu hingga leaderstats pemain dibuat
    player.CharacterAdded:Wait()
    player.leaderstats.Quests.Changed:Wait()

    if player.leaderstats.Quests.Value == "Tidak ada" then
        startQuest(player)
    end
end

-- Hubungkan fungsi onPlayerJoined ke event PlayerAdded
game.Players.PlayerAdded:Connect(onPlayerJoined)

-- Struktur Leaderstats (pastikan sudah dibuat)
-- player.leaderstats
-- |
-- |-- Experience (IntValue)
-- |-- Beli (IntValue)
-- |-- Quests (StringValue)

-- UI Pemberitahuan Quest
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game.Players.LocalPlayer.PlayerGui

local questFrame = Instance.new("Frame")
questFrame.Size = UDim2.new(0, 200, 0, 100)
questFrame.Position = UDim2.new(0.8, 0, 0.1, 0)
questFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
questFrame.BorderSizePixel = 2
questFrame.BorderColor3 = Color3.fromRGB(100, 100, 100)
questFrame.Parent = screenGui

local questTitle = Instance.new("TextLabel")
questTitle.Size = UDim2.new(1, 0, 0.2, 0)
questTitle.Position = UDim2.new(0, 0, 0, 0)
questTitle.BackgroundTransparency = 1
questTitle.Text = "QUEST"
questTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
questTitle.TextScaled = true
questTitle.Parent = questFrame

local questDescription = Instance.new("TextLabel")
questDescription.Size = UDim2.new(1, 0, 0.4, 0)
questDescription.Position = UDim2.new(0, 0, 0.2, 0)
questDescription.BackgroundTransparency = 1
questDescription.Text = "Kalahkan Kapten Brute (0/1)"
questDescription.TextColor3 = Color3.fromRGB(255, 255, 255)
questDescription.TextScaled = true
questDescription.Parent = questFrame

local moneyReward = Instance.new("TextLabel")
moneyReward.Size = UDim2.new(1, 0, 0.2, 0)
moneyReward.Position = UDim2.new(0, 0, 0.6, 0)
moneyReward.BackgroundTransparency = 1
moneyReward.Text = "Hadiah: $99999999"
moneyReward.TextColor3 = Color3.fromRGB(255, 255, 255)
moneyReward.TextScaled = true
moneyReward.Parent = questFrame

local xpReward = Instance.new("TextLabel")
xpReward.Size = UDim2.new(1, 0, 0.2, 0)
xpReward.Position = UDim2.new(0, 0, 0.8, 0)
xpReward.BackgroundTransparency = 1
xpReward.Text = "250 Exp."
xpReward.TextColor3 = Color3.fromRGB(255, 255, 255)
xpReward.TextScaled = true
xpReward.Parent = questFrame

-- Fungsi untuk memperbarui teks quest
local function updateQuest(description, money, xp)
    questDescription.Text = description
    moneyReward.Text = "Hadiah: $" .. money
    xpReward.Text = xp .. " Exp."
end
