local QuestModule = require(game:GetService("ReplicatedStorage").Quests)
local GuideModule = require(game:GetService("ReplicatedStorage").GuideModule)

function GetQuest()
    local PlayerLvl = game:GetService("Players").LocalPlayer.Data.Level.Value
    local Levels = {}
    local QuestHold = { lvl = nil }

    local HolderNpc = {}

    local levelreq = 0 -- Tambahkan inisialisasi levelreq

    for i, v in pairs(GuideModule.Data.NPCList) do
        for i1, v1 in pairs(v.Levels) do
            if PlayerLvl >= v1 then
                if v1 > levelreq then
                    levelreq = v1
                end
            end
        end
    end

    for i, v in pairs(QuestModule) do
        for _, v in pairs(v) do
            MobNameTest = v.Name
            if v.LevelReq == levelreq then
                for i1, v1 in pairs(v.Task) do
                    if i1 == MobNameTest then
                        Ms = i1
                    end
                end
            end
            Check, Ammount = next(v.Task, nil)
            if v.LevelReq <= PlayerLvl and
                v.Name ~= "Trainees" and
                v.Name ~= "Swan's Raid" and
                v.Name ~= "Town Raid" and
                Ammount ~= 1 then
                QuestHold["lvl"] = v.LevelReq
                table.insert(Levels, { _, v, i })
            end
        end
    end

    for i, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
        movl = string.match(v.Name, "%d+")
        if tonumber(movl) <= levelreq then
            Ms = v.Name
        end
    end

    table.sort(Levels, function(g, h)
        return g[2].LevelReq < h[2].LevelReq
    end)

    local Higets = Levels[#Levels]
    local Check, Ammount = next(Higets[2].Task, nil)
    local Info = {
        MobName = Ms;
        QuestCframe = Check;
        QuestText = Check;
        QuestName = Higets[3];
        QuestIndex = Higets[1];
        QuestLevelReq = levelreq or QuestHold["lvl"];
    }
    return Info
end

-- Fungsi untuk memberikan quest secara otomatis
local function giveQuestAutomatically(player)
    local questInfo = GetQuest()
    if questInfo then
        player.leaderstats.Quests.Value = questInfo.QuestName
        player:ChatPrint("Quest diterima: " .. questInfo.QuestName)
        -- Tambahkan logika untuk memberikan hadiah atau tugas quest di sini
    else
        player:ChatPrint("Tidak ada quest yang tersedia untuk level Anda.")
    end
end

-- Hubungkan fungsi giveQuestAutomatically ke event PlayerAdded
game.Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Wait()
    giveQuestAutomatically(player)
end)

print(GetQuest().MobName)
