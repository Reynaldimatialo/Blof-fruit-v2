-- Blox Fruits Simple Quest: Bobby's Bounty

local QuestName = "Bobby's Bounty"
local QuestDescription = "A notorious pirate named Bobby is causing trouble! Defeat him and claim your reward."
local TargetEnemy = "Bobby"
local RequiredLevel = 100 -- Adjust level requirement as needed

local QuestRewards = {
    Experience = 10000000, -- Adjust experience reward
    Beli = 99999999, -- Adjust Beli reward
    Item = "" -- Optional item reward. Set to nil or "" if no item.
}

local PlayerQuests = {} -- Table to track player quest progress

-- Function to start the quest
local function StartQuest(player)
    local playerID = player.UserId
    if player.Level >= RequiredLevel then
        if not PlayerQuests[playerID] then
            PlayerQuests[playerID] = {
                QuestName = QuestName,
                TargetEnemy = TargetEnemy,
                Completed = false,
                InProgress = true
            }
            player:ChatPrint("Quest started: " .. QuestName)
            player:ChatPrint(QuestDescription)
            return true
        else
            player:ChatPrint("You already have this quest!")
            return false;
        end
    else
        player:ChatPrint("You are not strong enough for this quest. Reach level " .. RequiredLevel .. "!")
        return false;
    end
end

-- Function to complete the quest
local function CompleteQuest(player)
    local playerID = player.UserId
    if PlayerQuests[playerID] and PlayerQuests[playerID].TargetEnemy == TargetEnemy and PlayerQuests[playerID].InProgress and not PlayerQuests[playerID].Completed then
        PlayerQuests[playerID].Completed = true
        PlayerQuests[playerID].InProgress = false
        player:ChatPrint("Quest completed: " .. QuestName .. "!")

        -- Give rewards
        player.Stats.Experience.Value = player.Stats.Experience.Value + QuestRewards.Experience
        player.Stats.Beli.Value = player.Stats.Beli.Value + QuestRewards.Beli

        if QuestRewards.Item and QuestRewards.Item ~= "" and QuestRewards.Item ~= nil then
            local item = game.ServerStorage[QuestRewards.Item]:Clone()
            item.Parent = player.Backpack
            player:ChatPrint("You received: " .. QuestRewards.Experience .. " XP, " .. QuestRewards.Beli .. " Beli, and " .. QuestRewards.Item .. "!")
        else
            player:ChatPrint("You received: " .. QuestRewards.Experience .. " XP, and " .. QuestRewards.Beli .. " Beli!")
        end
        PlayerQuests[playerID] = nil; -- Remove quest from player's quest log
    end
end

-- Example trigger for starting the quest (replace with your NPC interaction)
game.Workspace.QuestGiver.Touched:Connect(function(hit)
    local humanoid = hit.Parent:FindFirstChild("Humanoid")
    if humanoid then
        local player = game.Players:GetPlayerFromCharacter(hit.Parent)
        if player then
            StartQuest(player)
        end
    end
end)

-- Example trigger for completing the quest (replace with your enemy death detection)
game.Workspace.EnemyDeath.EnemyDied:Connect(function(enemy, killer)
    if enemy.Name == TargetEnemy and killer then
        local player = game.Players:GetPlayerFromCharacter(killer.Parent)
        if player and PlayerQuests[player.UserId] and PlayerQuests[player.UserId].TargetEnemy == TargetEnemy and PlayerQuests[player.UserId].InProgress then
            CompleteQuest(player)
        end
    end
end)

-- Add the QuestGiver part, EnemyDeath remote event, and the Bobby enemy to your game.
