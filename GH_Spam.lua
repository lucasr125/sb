repeat task.wait() until game:IsLoaded() == true
repeat task.wait() until game.Workspace:FindFirstChild("universaltimestop") == nil 

fireclickdetector(workspace.Lobby["God's Hand"].ClickDetector);
game:GetService("ReplicatedStorage").TimestopJump:FireServer();
game:GetService("ReplicatedStorage").Timestopchoir:FireServer();
game:GetService("ReplicatedStorage").Timestop:FireServer();

game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, game.Players.LocalPlayer);
