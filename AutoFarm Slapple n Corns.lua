-- loadstring(game:HttpGet(("https://raw.githubusercontent.com/lucasr125/sb/main/AutoFarm%20Slapple%20n%20Corns.lua")))();
if not game:IsLoaded() then
	game.Loaded:Wait();
end
repeat
	task.wait();
until game:GetService("Players") 
repeat
	task.wait();
until game.Players.LocalPlayer 
repeat
	task.wait();
until game.Players.LocalPlayer.Character ~= nil 
repeat
	task.wait();
until game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

getgenv().settings = {
	GetCandyCorns = true,
	GetSlapples = true
}

if (game.Players.LocalPlayer.Character:FindFirstChild("entered") == nil) then
	repeat
		task.wait();
		firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, workspace.Lobby.Teleport1, 0);
		firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, workspace.Lobby.Teleport1, 1);
	until game.Players.LocalPlayer.Character:FindFirstChild("entered") 
end

if (getgenv().settings.GetCandyCorns == true) then
	for _, v in pairs(game.Workspace.CandyCorns:GetDescendants()) do
		if (v.ClassName == "TouchTransmitter") then
			v.Parent.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame;
			firetouchinterest(v.Parent, game.Players.LocalPlayer.Character.HumanoidRootPart, 1);
			firetouchinterest(v.Parent, game.Players.LocalPlayer.Character.HumanoidRootPart, 0);
		end
	end
end

if (getgenv().settings.GetSlapples == true) then
	for _, v in ipairs(game.Workspace.Arena.island5.Slapples:GetDescendants()) do
		if ((v.Name == "Glove") and v:FindFirstChildWhichIsA("TouchTransmitter")) then
			firetouchinterest(v, game.Players.LocalPlayer.Character.HumanoidRootPart, 1);
			firetouchinterest(v, game.Players.LocalPlayer.Character.HumanoidRootPart, 0);
		end
	end
end

local servers = {}
local req = httprequest({Url = string.format("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Desc&limit=100", game.PlaceId)})
local body = HttpService:JSONDecode(req.Body)
if body and body.data then
	for i, v in next, body.data do
		if type(v) == "table" and tonumber(v.playing) and tonumber(v.maxPlayers) and v.playing < v.maxPlayers and v.id ~= game.JobId then
			table.insert(servers, 1, v.id)
		end
	end
end
if #servers > 0 then
	TeleportService:TeleportToPlaceInstance(PlaceId, servers[math.random(1, #servers)], game.Players.LocalPlayer)
else
	print("error")
end
