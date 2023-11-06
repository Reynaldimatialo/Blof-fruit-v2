-- Script for new boss-killing quest in Blox Fruit

-- Import necessary libraries
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character
local Humanoid = Character:WaitForChild("Humanoid")
local Quests = Character:WaitForChild("Quests")

-- Function to add a new quest
function AddQuest(questName, questDescription)
  local quest = Quests:NewQuest(questName)
  quest.Description.Value = questDescription
  quest.Objective.Value = "Defeat 1 boss to complete this quest and earn 100 Beli."
  quest.Reward.Value = "100 Beli"
end

-- Start the script
while true do
  -- Check if the boss quest has already been added
  if Quests.BossQuest.Value == false then
    AddQuest("BossQuest", "Defeat 1 boss to complete this quest and earn 100 Beli.")
    Quests.BossQuest.Value = true
  end

  -- Get the nearest boss
  local Boss = Players:GetNearestEnemy(LocalPlayer.Character.Position, 1000)

  -- Attack the boss if one is found
  if Boss then
    Humanoid:UseAttack(Boss.Character)
  end

  -- Wait for 1 second
  wait(1)
end
