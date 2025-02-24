-- Blox Fruits Jungle Gorilla King Quest Script

local bossName = "Gorilla King"
local bossLevel = 1200
local questRewardBeli = 4000000
local questRewardExp = 2000000
local questActive = false
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

-- Boss Spawning (Example - Adjust to your method)
local bossSpawnLocation = Vector3(1000, 100, -500) -- Jungle spawn location (adjust)
local bossModel = game.ReplicatedStorage.GorillaKingModel:Clone() -- Jungle boss model
bossModel.Parent = workspace
bossModel:SetPrimaryPartCFrame(CFrame.new(bossSpawnLocation))
local bossHumanoid = bossModel:WaitForChild("Humanoid")
bossHumanoid.MaxHealth = 35000
bossHumanoid.Health = 35000
local bossAlive = true

-- Quest Start Function
local function startQuest()
    if questActive then
        print("Quest already active!")
        return
    end

    questActive = true
    print("Quest started: Defeat the " .. bossName .. "!")
    bossModel:SetPrimaryPartCFrame(CFrame.new(bossSpawnLocation))
    bossHumanoid.MaxHealth = 35000
    bossHumanoid.Health = 35000
    bossAlive = true
    bossModel.Parent = workspace

    bossHumanoid.Died:Connect(function()
        if questActive and bossAlive then
            bossAlive = false
            questActive = false
            print("Quest completed! You defeated the " .. bossName .. "!")
            player.leaderstats.Beli.Value = player.leaderstats.Beli.Value + questRewardBeli
            player.leaderstats.Exp.Value = player.leaderstats.Exp.Value + questRewardExp
            print("Rewards: " .. questRewardBeli .. " Beli and " .. questRewardExp .. " Exp.")
            bossModel:Destroy()
        end
    end)

    -- Example boss AI (Basic - Improve as needed)
    while questActive and bossAlive and bossHumanoid.Health > 0 do
        local distance = (character.HumanoidRootPart.Position - bossModel.PrimaryPart.Position).Magnitude
        if distance < 300 then -- Adjust range for jungle environment
            bossHumanoid:MoveTo(character.HumanoidRootPart.Position)
        end
        wait(1)
    end
end

-- Example Quest Activation (Button/NPC Interaction)
local questButton = Instance.new("TextButton")
questButton.Parent = player.PlayerGui.ScreenGui
questButton.Text = "Start Gorilla King Quest"
questButton.Size = UDim2.new(0, 200, 0, 50)
questButton.Position = UDim2.new(0.5, -100, 0.8, -25)

questButton.MouseButton1Click:Connect(startQuest)

-- Example Boss Damage Detection(Optional, for more advanced quests)
bossHumanoid.HealthChanged:Connect(function(newHealth)
  --Print(newHealth) -- uncomment to see the health change
  if newHealth <= 0 then
    --Handle death here, if not using the .Died event
  end
end)

--Example timer for how long the boss will stay alive.

local timeLimit = 600 -- 10 minutes (600 seconds)
local startTime = tick()

while true do
  wait(1)
  if questActive and bossAlive then
    if tick() - startTime >= timeLimit then
      bossAlive = false
      questActive = false
      print("Time limit reached. Gorilla King returned to his domain.")
      bossModel:Destroy()
      startTime = tick() -- Reset the timer if the quest is started again.
    end
  end
end
