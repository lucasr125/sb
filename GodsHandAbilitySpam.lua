repeat task.wait()
until not game.Workspace:FindFirstChild("universaltimestop")

fireclickdetector(workspace.Lobby["God's Hand"].ClickDetector)
game:GetService("ReplicatedStorage").TimestopJump:FireServer()
game:GetService("ReplicatedStorage").Timestopchoir:FireServer()
game:GetService("ReplicatedStorage").Timestop:FireServer()

game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, game.Players.LocalPlayer)
