if not game:IsLoaded() then
	game.Loaded:Wait();
end
if ((game.PlaceId == 6403373529) or (game.PlaceId == 9015014224) or (game.PlaceId == 11520107397)) then
	local teleportFunc = queueonteleport or queue_on_teleport;
	if teleportFunc then
		teleportFunc([[
repeat task.wait() until game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
for i, v in pairs(game:GetService("Workspace"):WaitForChild("CandyCorns"):GetChildren()) do  
	if v:FindFirstChildWhichIsA("TouchTransmitter") then  
		firetouchinterest(game.Players.LocalPlayer.Character.Head, v, 0)  
		firetouchinterest(game.Players.LocalPlayer.Character.Head, v, 1)  
	end  
end  
task.wait(0.1)
if game.Players.LocalPlayer.Character:FindFirstChild("entered") == nil then
	firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, workspace.Lobby.Teleport2, 0) 
	firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, workspace.Lobby.Teleport2, 1) 
end
task.wait(0.1)  
for i, v in ipairs(workspace.Arena.island5.Slapples:GetDescendants()) do  
	if game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and game.Players.LocalPlayer.Character:FindFirstChild("entered") and v.Name == "Glove" and v:FindFirstChildWhichIsA("TouchTransmitter") then  
		firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v, 0)  
		firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v, 1)  
	end  
end  
task.wait(0.6)
loadstring(game:HttpGet("https://raw.githubusercontent.com/lucasr125/sb/refs/heads/main/AutoFarm%20Slapple%20n%20Corns.lua"))()
            ]]);
	end
	local serverList = {};
	for _, v in ipairs(game:GetService("HttpService"):JSONDecode(game:HttpGetAsync("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100")).data) do
		if (v.playing and (type(v) == "table") and (v.maxPlayers > v.playing) and (v.id ~= game.JobId)) then
			serverList[#serverList + 1] = v.id;
		end
	end
	if (#serverList > 0) then
		task.wait(3.5);
		game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, serverList[math.random(1, #serverList)]);
	end
end
