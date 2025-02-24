-- Blox Fruits Quest Reward Customization Script (First Sea NPCs)

local questRewards = {}

-- NPC Quest Names (First Sea)
local firstSeaNPCQuests = {
    "Bobby's Quest",
    "Gorilla King's Quest",
    "Prison Warden's Quest",
    "Vice Admiral's Quest",
    "Chief Petty Officer's Quest",
    "Desert Bandit's Quest",
    "Snow Bandit's Quest",
    "Marine Lieutenant's Quest",
    "Rich Man's Quest",
    "Military Detective's Quest",
    "Bartilo's Quest"
}

--- Function to customize quest rewards.
-- @param questName string The name of the quest.
-- @param rewards table A table containing reward types and amounts.
-- Example: { XP = 1000, Item = "Cutlass", Currency = 500 }
local function customizeQuestReward(questName, rewards)
    if type(questName) ~= "string" then
        error("Quest name must be a string.")
        return
    end

    if type(rewards) ~= "table" then
        error("Rewards must be a table.")
        return
    end

    local validQuest = false
    for _, npcQuest in ipairs(firstSeaNPCQuests) do
        if questName == npcQuest then
            validQuest = true
            break
        end
    end

    if not validQuest then
        error("Invalid quest name for First Sea NPCs.")
        return
    end

    questRewards[questName] = rewards
    print("Quest rewards for '" .. questName .. "' customized.")
end

--- Function to get customized quest rewards.
-- @param questName string The name of the quest.
-- @return table|nil The customized rewards table, or nil if not found.
local function getCustomQuestRewards(questName)
    if type(questName) ~= "string" then
        error("Quest name must be a string.")
        return nil
    end

    return questRewards[questName]
end

--- Function to apply the customized rewards.
-- This function would typically be integrated with the game's quest completion logic.
-- For demonstration purposes, it simply prints the rewards.
local function applyCustomRewards(questName, player)
    local rewards = getCustomQuestRewards(questName)

    if rewards then
        print("Applying custom rewards for '" .. questName .. "':")
        for rewardType, rewardAmount in pairs(rewards) do
            print("- " .. rewardType .. ": " .. tostring(rewardAmount))
            -- Here, you would implement the actual reward application logic
            -- Example:
            -- if rewardType == "XP" then
            --     player.XP = player.XP + rewardAmount
            -- elseif rewardType == "Item" then
            --     player:AddItem(rewardAmount)
            -- elseif rewardType == "Currency" then
            --     player.Currency = player.Currency + rewardAmount
            -- end
        end
    else
        print("No custom rewards found for '" .. questName .. "'.")
    end
end

--- Example Usage:
-- Customize rewards for "Bobby's Quest"
customizeQuestReward("Bobby's Quest", { XP = 1500, Currency = 750, Item = "Cutlass"})

-- Customize rewards for "Gorilla King's Quest"
customizeQuestReward("Gorilla King's Quest", { XP = 2000, Currency = 1000 })

-- Customize rewards for "Prison Warden's Quest"
customizeQuestReward("Prison Warden's Quest", {XP = 4500, Currency = 2250, Item = "Iron Mace"})

-- Apply rewards (simulated)
applyCustomRewards("Bobby's Quest", { XP = 1000, Currency = 500, AddItem = function() end })
applyCustomRewards("Gorilla King's Quest", { XP = 10000000, Currency = 500000000, AddItem = function() end })
applyCustomRewards("Prison Warden's Quest", { XP = 1000, Currency = 500, AddItem = function() end })
applyCustomRewards("Unknown Quest", { XP = 0, Currency = 0, AddItem = function() end })

--- User Instructions:
-- 1. Use the customizeQuestReward function to set custom rewards.
-- 2. Pass the quest name (from the First Sea NPCs list) as a string and a table of rewards.
-- 3. Rewards table format: { RewardType = Amount, ... }
-- 4. RewardType can be "XP", "Item", "Currency", etc.
-- 5. The applyCustomRewards function (or your game's reward logic) will handle applying the rewards.
-- 6. Replace the simulated reward application logic with your game's actual reward logic.
-- 7. Valid Quest names are:
--    "Bobby's Quest",
--    "Gorilla King's Quest",
--    "Prison Warden's Quest",
--    "Vice Admiral's Quest",
--    "Chief Petty Officer's Quest",
--    "Desert Bandit's Quest",
--    "Snow Bandit's Quest",
--    "Marine Lieutenant's Quest",
--    "Rich Man's Quest",
--    "Military Detective's Quest",
--    "Bartilo's Quest"
-- 8. To change the reward amounts, modify the numerical values within the rewards table inside the customizeQuestReward function calls.
