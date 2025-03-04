local LocalPlayer = game.Players.LocalPlayer
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/lucasr125/Bracket_Orion/main/orionlib.lua')))();
local Window = OrionLib:MakeWindow({Name = "SB Mastery", HidePremium = false, SaveConfig = false, ConfigFolder = "nil", IntroEnabled = false});
local RunTab = Window:MakeTab({Name = "Run Mastery", Icon = "rbxassetid://4483345998", PremiumOnly = false});

local equipLolbomb = RunTab:AddButton({Name = "Equip LOLBOMB (+2 kills)", Callback = function()
	LocalPlayer:WaitForChild("Reset"):FireServer()
  fireclickdetector(game.Workspace.Lobby["L.O.L.B.O.M.B"].ClickDetector)
end});
local selectPlayerRun = RunTab:AddTextbox({Name = "Select player to help", Default = "username here!", TextDisappear = false, Callback = function(Value)
	if game.Players:FindFirstChild(Value) ~= nil then
    runPlayerHelper = game.Players:FindFirstChild(Value)
  else
    OrionLib:MakeNotification({Name = "Error",Content = "Invalid user.",Image = "rbxassetid://4483345998",Time = 5});
  end
end});
local autoGetKilled = RunTab:AddToggle({Name = "Auto get killed by Run", Default = false, Callback = function(Value)
	while task.wait() and Value == true do
		if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and runPlayerHelper and runPlayerHelper.Character and runPlayerHelper.Character:FindFirstChild("HumanoidRootPart") then
			if LocalPlayer.Character:FindFirstChild("InLabyrinth") and LocalPlayer.Character.InLabyrinth.Value == true then
				LocalPlayer.Character.HumanoidRootPart.CFrame = runPlayerHelper.Character.HumanoidRootPart.CFrame
			end
		end
	end
end});
--19039.978515625, 6624.5029296875, 19538.009765625
