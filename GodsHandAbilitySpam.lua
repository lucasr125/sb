repeat
	task.wait()
until not game.Workspace:FindFirstChild("universaltimestop")
fireclickdetector(workspace.Lobby["God's Hand"].ClickDetector)
game:GetService("ReplicatedStorage").TimestopJump:FireServer()
game:GetService("ReplicatedStorage").Timestopchoir:FireServer()
game:GetService("ReplicatedStorage").Timestop:FireServer()
wait(1)
local teleportFunc = queueonteleport or queue_on_teleport or syn and syn.queue_on_teleport
if teleportFunc then
    teleportFunc([[loadstring(game:HttpGet(("https://raw.githubusercontent.com/lucasr125/sb/main/GodsHandAbilitySpam.lua")))()]])
end
game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, game.Players.LocalPlayer)
