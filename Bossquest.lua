-- WARNING: Using scripts in Blox Fruits can get you banned. Use at your own risk.
-- This script auto-farms Gorilla King boss, takes the quest, and lets you tweak EXP & money gain.

local expMultiplier = 2  -- Change this to modify EXP gain multiplier
local moneyMultiplier = 2 -- Change this to modify money gain multiplier

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:FindFirstChild("Humanoid")

-- Function to take the Gorilla King quest
local function takeGorillaKingQuest()
    local questNPC = game.Workspace:FindFirstChild("QuestGiver_GorillaKing")
    if questNPC then
        LocalPlayer.Character.HumanoidRootPart.CFrame = questNPC.HumanoidRootPart.CFrame * CFrame.new(0, 2, 0)
        wait(1)
        game.ReplicatedStorage.Remotes.Quest:InvokeServer("StartQuest", "Gorilla King")
        print("Quest taken: Defeat Gorilla King")
    end
end

-- Function to find Gorilla King boss
local function findGorillaKing()
    for _, v in pairs(game.Workspace.Enemies:GetChildren()) do
        if v:IsA("Model") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
            if v.Name == "Gorilla King" then
                return v
            end
        end
    end
    return nil
end

-- Function to attack Gorilla King
local function attackGorillaKing(boss)
    while boss and boss:FindFirstChild("Humanoid") and boss.Humanoid.Health > 0 do
        LocalPlayer.Character.HumanoidRootPart.CFrame = boss.HumanoidRootPart.CFrame * CFrame.new(0, 10, 0)
        game.ReplicatedStorage.Remotes.Combat:FireServer("Attack")
        wait(0.2)
    end
end

-- Main loop to take quest and auto-farm Gorilla King
while true do
    takeGorillaKingQuest()
    wait(2)
    local boss = findGorillaKing()
    if boss then
        attackGorillaKing(boss)
        print("Gorilla King defeated! Bonus EXP & Money applied.")
        LocalPlayer.leaderstats.Beli.Value = LocalPlayer.leaderstats.Beli.Value + (10000 * moneyMultiplier)
        LocalPlayer.leaderstats.Experience.Value = LocalPlayer.leaderstats.Experience.Value + (5000 * expMultiplier)
    end
    wait(5) -- Wait before searching for Gorilla King again
end
