for _, player in pairs(game.Players) do
    local rootPart = player.Character:FindFirstChild("HumanoidRootPart")
    if rootPart then
        local tag = Instance.new("Tag")
        tag.Text = player.Name
        tag.Size = Vector2.new(200, 50)
        tag.BackgroundColor = Color3.new(1, 1, 1)
        tag.BorderColor = Color3.new(0, 0, 0)
        tag.BorderSize = 2
        tag.Position = rootPart.Position + Vector3.new(0, 2, 0)
        tag.Parent = workspace
    end
end
