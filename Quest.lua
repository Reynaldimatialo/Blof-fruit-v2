local function onBossDefeated()
  -- Put your code here to reward the player for defeating the boss
  local player = game.PlayersService:GetPlayerFromCharacter(script.Parent.Parent)
  player:AddCash(986000000)
  player:AddExperience(500000000)
end
