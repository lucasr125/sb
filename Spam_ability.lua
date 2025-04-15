local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local RootPart = Character:WaitForChild("HumanoidRootPart")
firetouchinterest(game.Players.LocalPlayer.Character:WaitForChild("Head"), workspace.Lobby.Teleport1.TouchInterest.Parent, 0)
firetouchinterest(game.Players.LocalPlayer.Character:WaitForChild("Head"), workspace.Lobby.Teleport1.TouchInterest.Parent, 1)
for i = 1, 5 do
    for _, player in ipairs(Players:GetPlayers()) do
	if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
		local targetCFrame = player.Character.HumanoidRootPart.CFrame
        RootPart.CFrame = targetCFrame + Vector3.new(-2, -2, -2)
           game:GetService("ReplicatedStorage"):WaitForChild("PusherWall"):FireServer() -- or busmoment
           task.wait()
    end
    end
end
game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, Players.LocalPlayer)
