if not game:IsLoaded() then
	game.Loaded:Wait()
end

game:GetService("GuiService"):ClearError()

local game_name = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name or "Slap Battles Script"

if game.PlaceId == 6403373529 or game.PlaceId == 9015014224 then

	getgenv().settings = {
		-- Main:
		AutoFarmSlapple = false,
		AutoFarmCandy = false,
		-- Antis:
		AntiAdmin = false,
		AntiKick = false,
		AntiRagdoll = false,
		AntiDB = false,
		AntiBrazil = false,
		AntiTimestop = false,
		AntiSquid = false,
		AntiBrick = false,
		AntiZaHando = false,
		AntiReaper = false,
		AntiPusher = false,
		AntiBooster = false,
		AntiMail = false,
		AntiRock = false,
		AntiBarrier = false, 
		AntiBubble = false,
		AntiBus = false,
		AntiIce = false,
		AntiNightmare = false,
		AntiObby = false,
		--Combat
		SlapAura = false,
		SlapAuraReach = 25,
		SlapFarm = false,
		SlapFarmCooldown = 0.25,
		GloveExtend = false,
		ExtendOption = "Meat Stick",
		AutoClick = false,
		AbilitySpam = false,
		HomeRunMax = false,
		PopBalloony = false,
		RhythmExplosion = false,
		NullMinions = false,
		SlapMinions = false,
		RojoSpam = false,
		RojoPlayer = nil,
		GuardianSpam = false,
		GuardianPlayer = nil,
		PunishPlayer = nil,
		RetroSpam = false,
		RetroOption = "Ban Hammer",
		--Misc
		SlicerSpam = false,
		ChargeSpam = false,
		ErrorSpam = false,
		ErrorDeathSpam = false,
		HitmanSpam = false,
		ThanosSpam = false,
		SpaceSpam = false,
		GhostSpam = false,
		GoldenSpam = false,
		FartSpam = false,
		ZombieSpam = false,
		AutoTycoon = false,
		DestroyTycoon = false,
		AutoEnter = false,
		ArenaSelected = "Teleport1", -- teleport 1 ( normal ) / teleport 2 / ( only default )
		RainbowGolden = false,
		InfiniteReverse = false,
		SelfKnockback = false,
		-- Local
		Walkspeed = 20,
		JumpPower = 50,
		HipHeight = 0,
		Gravity = 196.2,
		AutoWalkspeed = false,
		AutoJumpPower = false,
		AutoHipHeight = false,
		AutoGravity = false,
		-- Badges
		GetJetOrb = false,
		GetPhaseOrb = false,
	}
	--ESP
	local Players = game:GetService("Players")
	local RunService = game:GetService("RunService")
	local UserInputService = game:GetService("UserInputService")
	local LocalPlayer = Players.LocalPlayer
	local ESPObjects = {}
	local ESPEnabled = false
	local ESPColor = Color3.new(1, 0, 1)
	local ESPTextColor = Color3.new(1, 0, 0)
	local ShowName = false
	local ShowHealth = false
	local ShowDistance = false
	local ShowGlove = false

	local function CreateBodyESP(player)
		if not ESPEnabled then return end
		local character = player.Character
		if character then
			for _, bodyPart in pairs(character:GetChildren()) do
				if bodyPart:IsA("BasePart") then
					local espBox = Instance.new("BoxHandleAdornment")
					espBox.Adornee = bodyPart
					espBox.Size = bodyPart.Size + Vector3.new(0.1, 0.1, 0.1)
					espBox.Color3 = ESPColor
					espBox.Transparency = 0.6
					espBox.Parent = bodyPart
					espBox.AlwaysOnTop = true
					table.insert(ESPObjects, espBox)
				end
			end
		end
	end

	local function CreateHeadESP(player)
		if not ESPEnabled then return end
		local character = player.Character
		if character and character:FindFirstChild("Head") then
			local head = character.Head
			local espBillboard = Instance.new("BillboardGui")
			espBillboard.Adornee = head
			espBillboard.Size = UDim2.new(2, 0, 1, 0)
			espBillboard.StudsOffset = Vector3.new(0, 3, 0)
			espBillboard.Parent = head

			local espText = Instance.new("TextLabel")
			espText.BackgroundTransparency = 1.0
			espText.Size = UDim2.new(1, 0, 1, 0)
			espText.Font = Enum.Font.SourceSansBold
			espText.TextSize = 14
			espText.TextStrokeTransparency = 0
			espText.TextColor3 = ESPTextColor
			espText.TextStrokeColor3 = Color3.new(0, 0, 0)
			espText.TextYAlignment = Enum.TextYAlignment.Bottom
			espText.Parent = espBillboard

			local function UpdateESP()
				if player.Character and player.Character:FindFirstChild("Humanoid") then
					local distance = (player.Character.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
					local espTextValue = ""
					if ShowName then
						espTextValue = espTextValue .. "Name: " .. player.Name .. "\n"
					end
					if ShowHealth then
						espTextValue = espTextValue .. "Health: " .. player.Character.Humanoid.Health .. "\n"
					end
					if ShowDistance then
						espTextValue = espTextValue .. "Distance: " .. string.format("%.1f", distance) .. "\n"
					end
					if ShowGlove then
						if player.Character:FindFirstChild("entered") and player.Character.IsInDefaultArena.Value == false then
							local gloveValue = player.leaderstats.Glove.Value 
							espTextValue = espTextValue .. "Glove: " .. gloveValue .. "\n"
						end
					end
					espText.Text = espTextValue
				else
					espText.Text = ""
				end
			end

			espBillboard:GetPropertyChangedSignal("Adornee"):Connect(function()
				UpdateESP()
			end)

			UpdateESP()

			espBillboard.AlwaysOnTop = true
			table.insert(ESPObjects, espBillboard)
		end
	end

	local function ClearESP()
		for _, espObject in pairs(ESPObjects) do
			espObject:Destroy()
		end
		ESPObjects = {}
	end

	local function UpdateESP()
		ClearESP()
		for _, player in pairs(Players:GetPlayers()) do
			if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Head") then
				CreateBodyESP(player)
				CreateHeadESP(player)
			end
		end
	end

	RunService.RenderStepped:Connect(UpdateESP)

	-- Bypass
	local bypass;
	bypass = hookmetamethod(game, "__namecall", function(method, ...) 
		if getnamecallmethod() == "FireServer" and method == game.ReplicatedStorage.Ban then
			return
		elseif getnamecallmethod() == "FireServer" and method == game.ReplicatedStorage.AdminGUI then
			return
		elseif getnamecallmethod() == "FireServer" and method == game.ReplicatedStorage.WalkSpeedChanged then
			return
		end
		return bypass(method, ...)
	end)

	-- Variables
	local Player = LocalPlayer.Character.Name
	local Gloves = loadstring(game:HttpGet("https://raw.githubusercontent.com/lucasr125/sb/main/GlovesSB"))()

	local function getGlove()
		return LocalPlayer.leaderstats.Glove.Value
	end
	local function getTool()
		local tool = game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Tool") or game:GetService("Players").LocalPlayer:WaitForChild("Backpack"):FindFirstChildOfClass("Tool")
		if tool ~= nil and tool:FindFirstChild("Glove") ~= nil then
			return tool
		end
	end

	-- Anti Voids
	local SafeSpot = Instance.new("Part", workspace)
	SafeSpot.Position = Vector3.new(-1500,100,-1500)
	SafeSpot.Name = "Spot"
	SafeSpot.Size = Vector3.new(100,1,100)
	SafeSpot.Anchored = true
	SafeSpot.Transparency = .7

	local TournamentAntiVoid = Instance.new("Part", workspace)
	TournamentAntiVoid.Name = "TAntiVoid"
	TournamentAntiVoid.Size = Vector3.new(798, 1, 1290)
	TournamentAntiVoid.Position = Vector3.new(3450, 59.009, 68)
	TournamentAntiVoid.CanCollide = false
	TournamentAntiVoid.Anchored = true
	TournamentAntiVoid.Material = "ForceField"
	TournamentAntiVoid.Transparency = 1

	local arenaVoid = Instance.new("Part", workspace)
	arenaVoid.Name = "arenaVoid"
	arenaVoid.Size = Vector3.new(798, 1, 1290)
	arenaVoid.Position = Vector3.new(3450, 59.009, 68)
	arenaVoid.CanCollide = false
	arenaVoid.Anchored = true
	arenaVoid.Transparency = 1

	local Bracket = loadstring(game:HttpGet("https://raw.githubusercontent.com/lucasr125/bracket-lib-v3.3/main/bracketv3.3.lua"))()
	Bracket:Notification({Title = "Loading",Description = game_name,Duration = 10})
	local Window = Bracket:Window({Name = game_name,Enabled = true,Color = Color3.new(1, 0.4, 0.4),Size = UDim2.new(0,296,0,296),Position = UDim2.new(0.5,-248,0.5,-248)}) do
		local HomeTab = Window:Tab({Name = "Home"}) do
			local HomeSection = HomeTab:Section({Name = "Automatics",Side = "Left"}) do

				local AutoFarmSlapple = HomeSection:Toggle({Name = "AutoFarm Slapples",Flag = "AutoFarmSlapple",Side = "Left",Value = false,Callback = function(Toggle_Bool) 
					getgenv().settings.AutoFarmSlapple = Toggle_Bool
					while getgenv().settings.AutoFarmSlapple do
						spawn(function()
							for i, v in pairs(game:GetService("Workspace").Arena.island5.Slapples:GetDescendants()) do
								if v:IsA("TouchTransmitter") then
									firetouchinterest(LocalPlayer.Character.Head, v.Parent, 0)
									firetouchinterest(LocalPlayer.Character.Head, v.Parent, 1)
								end
							end
						end)
						task.wait()
					end
				end})
				AutoFarmSlapple:ToolTip("Pickups slapples for you, this only works if you enter on arena.")

				local AutoFarmCandy = HomeSection:Toggle({Name = "AutoFarm Candy",Flag = "AutoFarmCandy",Side = "Left",Value = false,Callback = function(Toggle_Bool) 
					getgenv().settings.AutoFarmCandy = Toggle_Bool
					while getgenv().settings.AutoFarmCandy do
						spawn(function()
							for i, v in pairs(game:GetService("Workspace").CandyCorns:GetDescendants()) do
								if v.Name == ("TouchInterest") and v.Parent then
									firetouchinterest(LocalPlayer.Character.Head, v.Parent, 0)
									firetouchinterest(LocalPlayer.Character.Head, v.Parent, 1)
								end
							end
						end)
						task.wait()
					end
				end})
				AutoFarmCandy:ToolTip("Pickup candy corns for you, you don't need enter on arena to get candy corns")

				local NotifGravestone = HomeSection:Button({Name = "Notificate Gravestone",Side = "Left",Callback = function() 
					repeat task.wait() until game.Workspace:FindFirstChild("Gravestone")
					Bracket:Notification({Title = "Halloween!",Description = "Gravestone spawned, use Get HallowJack if you want Hallow glove! ( Needs killstreak and atleast 10 kills )",Duration = 10})
				end})
				NotifGravestone:ToolTip("This will see if gravestone has appeared, you will get a notification when appear")

				local GetHallowJack = HomeSection:Button({Name = "Get Hallow Jack",Side = "Left",Callback = function() 

					if not game.Workspace:FindFirstChild("Gravestone") then
						Bracket:Notification({Title = "Halloween!",Description = "The gravestone did not spawn",Duration = 10})
					end

					if getGlove() ~= "Killstreak" then
						Bracket:Notification({Title = "Halloween!",Description = "You don't have killstreak glove equipped",Duration = 10})
					end
					if not LocalPlayer.PlayerGui:FindFirstChild("Kills") then
						Bracket:Notification({Title = "Halloween!",Description = "Your kills are broken, reset your character",Duration = 10})
					end
					if LocalPlayer.PlayerGui.Kills.Frame.TextLabel.Text >= "10" then
						for i,v in pairs(workspace.Gravestone:GetDescendants()) do
							if v:IsA("ClickDetector") then
								fireclickdetector(v)
							end
						end
					else 
						Bracket:Notification({Title = "Halloween!",Description = "You don't have atleast 10 kills!",Duration = 10})
					end
				end})
				GetHallowJack:ToolTip("If you click on the button you will get hallow jack, you need killstreak glove and atleast 10 kills")

			end
			local OthersSection = HomeTab:Section({Name = "Others",Side = "Right"}) do
				local Animations = OthersSection:Button({Name = "Free Emotes (Type /e emotename) ( credits: guy that exists )",Side = "Left",Callback = function() 
					Floss = LocalPlayer.Character.Humanoid:LoadAnimation(game.ReplicatedStorage.AnimationPack.Floss, LocalPlayer.Character.Humanoid)
					Groove = LocalPlayer.Character.Humanoid:LoadAnimation(game.ReplicatedStorage.AnimationPack.Groove, LocalPlayer.Character.Humanoid)
					Headless = LocalPlayer.Character.Humanoid:LoadAnimation(game.ReplicatedStorage.AnimationPack.Headless, LocalPlayer.Character.Humanoid)
					Helicopter = LocalPlayer.Character.Humanoid:LoadAnimation(game.ReplicatedStorage.AnimationPack.Helicopter, LocalPlayer.Character.Humanoid)
					Kick = LocalPlayer.Character.Humanoid:LoadAnimation(game.ReplicatedStorage.AnimationPack.Kick, LocalPlayer.Character.Humanoid)
					L = LocalPlayer.Character.Humanoid:LoadAnimation(game.ReplicatedStorage.AnimationPack.L, LocalPlayer.Character.Humanoid)
					Laugh = LocalPlayer.Character.Humanoid:LoadAnimation(game.ReplicatedStorage.AnimationPack.Laugh, LocalPlayer.Character.Humanoid)
					Parker = LocalPlayer.Character.Humanoid:LoadAnimation(game.ReplicatedStorage.AnimationPack.Parker, LocalPlayer.Character.Humanoid)
					Spasm = LocalPlayer.Character.Humanoid:LoadAnimation(game.ReplicatedStorage.AnimationPack.Spasm, LocalPlayer.Character.Humanoid)
					Thriller = LocalPlayer.Character.Humanoid:LoadAnimation(game.ReplicatedStorage.AnimationPack.Thriller, LocalPlayer.Character.Humanoid)
					LocalPlayer.Chatted:connect(function(msg)
						if LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
							Floss = LocalPlayer.Character.Humanoid:LoadAnimation(game.ReplicatedStorage.AnimationPack.Floss, LocalPlayer.Character.Humanoid)
							Groove = LocalPlayer.Character.Humanoid:LoadAnimation(game.ReplicatedStorage.AnimationPack.Groove, LocalPlayer.Character.Humanoid)
							Headless = LocalPlayer.Character.Humanoid:LoadAnimation(game.ReplicatedStorage.AnimationPack.Headless, LocalPlayer.Character.Humanoid)
							Helicopter = LocalPlayer.Character.Humanoid:LoadAnimation(game.ReplicatedStorage.AnimationPack.Helicopter, LocalPlayer.Character.Humanoid)
							Kick = LocalPlayer.Character.Humanoid:LoadAnimation(game.ReplicatedStorage.AnimationPack.Kick, LocalPlayer.Character.Humanoid)
							L = LocalPlayer.Character.Humanoid:LoadAnimation(game.ReplicatedStorage.AnimationPack.L, LocalPlayer.Character.Humanoid)
							Laugh = LocalPlayer.Character.Humanoid:LoadAnimation(game.ReplicatedStorage.AnimationPack.Laugh, LocalPlayer.Character.Humanoid)
							Parker = LocalPlayer.Character.Humanoid:LoadAnimation(game.ReplicatedStorage.AnimationPack.Parker, LocalPlayer.Character.Humanoid)
							Spasm = LocalPlayer.Character.Humanoid:LoadAnimation(game.ReplicatedStorage.AnimationPack.Spasm, LocalPlayer.Character.Humanoid)
							Thriller = LocalPlayer.Character.Humanoid:LoadAnimation(game.ReplicatedStorage.AnimationPack.Thriller, LocalPlayer.Character.Humanoid)
							if string.lower(msg) == "/e floss" then
								Floss:Play()
							elseif string.lower(msg) == "/e groove" then
								Groove:Play()
							elseif string.lower(msg) == "/e headless" then
								Headless:Play()
							elseif string.lower(msg) == "/e helicopter" then
								Helicopter:Play()
							elseif string.lower(msg) == "/e kick" then
								Kick:Play()
							elseif string.lower(msg) == "/e l" then
								L:Play()
							elseif string.lower(msg) == "/e laugh" then
								Laugh:Play()
							elseif string.lower(msg) == "/e parker" then
								Parker:Play()
							elseif string.lower(msg) == "/e spasm" then
								Spasm:Play()
							elseif string.lower(msg) == "/e thriller" then
								Thriller:Play()
							end
							EP = LocalPlayer.Character.HumanoidRootPart.Position
						end
					end)
					game:GetService("RunService").Heartbeat:Connect(function()
						if EP ~= nil and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and Floss.IsPlaying or Groove.IsPlaying or Headless.IsPlaying or Helicopter.IsPlaying or Kick.IsPlaying or L.IsPlaying or Laugh.IsPlaying or Parker.IsPlaying or Spasm.IsPlaying or Thriller.IsPlaying then
							Magnitude = (LocalPlayer.Character.HumanoidRootPart.Position - EP).Magnitude
							if Magnitude > 1 then
								Floss:Stop(); Groove:Stop(); Headless:Stop(); Helicopter:Stop(); Kick:Stop(); L:Stop(); Laugh:Stop(); Parker:Stop(); Spasm:Stop(); Thriller:Stop()
							end
						end
					end)
				end})
				Animations:ToolTip("Gives you free animations, just say in chat '/e emotename'")

				local Rejoin = OthersSection:Button({Name = "Rejoin",Side = "Left",Callback = function() 
					game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
				end})
				Rejoin:ToolTip("Rejoin on the same server, useful if your character is broken")

				local InfYield = OthersSection:Button({Name = "Infinite Yield",Side = "Left",Callback = function() 
					loadstring(game:HttpGet(('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'),true))()
				end})
				InfYield:ToolTip("Execute Infinite Yield script")

				local SimpleSpy = OthersSection:Button({Name = "Simple Spy",Side = "Left",Callback = function() 
					loadstring(game:HttpGet("https://raw.githubusercontent.com/exxtremestuffs/SimpleSpySource/master/SimpleSpy.lua", true))()
				end})
				SimpleSpy:ToolTip("Execute Simple Spy script")

			end
		end
		local AntiTab = Window:Tab({Name = "Antis"}) do
			local Anti1 = AntiTab:Section({Name = "Anti 1",Side = "Left"}) do
				local AntiAdmin = Anti1:Toggle({Name = "Anti Admin",Flag = "AntiAdmin",Side = "Left",Value = false,Callback = function(Toggle_Bool) 
					getgenv().settings.AntiAdmin = Toggle_Bool
					while getgenv().settings.AntiAdmin do
						for i,v in pairs(game.Players:GetChildren()) do
							if v:GetRankInGroup(9950771) >= 2 then
								LocalPlayer:Kick("High Rank Player Detected.".." ("..v.Name..")")
								break
							end
						end
						task.wait()
					end
				end})
				AntiAdmin:ToolTip("Checks if an administrator has joined the game")
				--:ToolTip("")

				local AntiKick = Anti1:Toggle({Name = "Anti Kick",Flag = "AntiKick",Side = "Left",Value = false,Callback = function(Toggle_Bool) 
					getgenv().settings.AntiKick = Toggle_Bool
					while getgenv().settings.AntiKick do
						for i,v in pairs(game.CoreGui.RobloxPromptGui.promptOverlay:GetDescendants()) do
							if v.Name == "ErrorPrompt" then
								game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
							end
						end
						task.wait()
					end
				end})
				AntiKick:ToolTip("If you get kicked you will return to the same server, useful if you use Slap Aura function")

				local AntiRagdoll = Anti1:Toggle({Name = "Anti Ragdoll",Flag = "AntiRagdoll",Side = "Left",Value = false,Callback = function(Toggle_Bool) 
					getgenv().settings.AntiRagdoll = Toggle_Bool
					if getgenv().settings.AntiRagdoll then
						LocalPlayer.Character.Humanoid.Health = 0
						LocalPlayer.CharacterAdded:Connect(function()
							LocalPlayer.Character:WaitForChild("Ragdolled").Changed:Connect(function()
								if LocalPlayer.Character:WaitForChild("Ragdolled").Value == true and getgenv().settings.AntiRagdoll then
									repeat task.wait() LocalPlayer.Character.Torso.Anchored = true
									until LocalPlayer.Character:WaitForChild("Ragdolled").Value == false
									LocalPlayer.Character.Torso.Anchored = false
								end
							end)
						end)
					end
				end})
				AntiRagdoll:ToolTip("Prevents your character from taking knockback, useful if there is God's Hand")

				local AntiTS = Anti1:Toggle({Name = "Anti Timestop",Flag = "AntiTS",Side = "Left",Value = false,Callback = function(Toggle_Bool) 
					getgenv().settings.AntiTimestop = Toggle_Bool
					while getgenv().settings.AntiTimestop do
						for i,v in pairs(LocalPlayer.Character:GetChildren()) do
							if v.ClassName == "Part" then
								v.Anchored = false
							end
						end
						task.wait()
					end
				end})
				AntiTS:ToolTip("Makes your avatar not get stuck in cutscenes and others, like those in Counter or Timestop")

				local AntiSquid = Anti1:Toggle({Name = "Anti Squid",Flag = "AntiSquid",Side = "Left",Value = false,Callback = function(Toggle_Bool) 
					getgenv().settings.AntiSquid = Toggle_Bool

					if getgenv().settings.AntiSquid == false then
						LocalPlayer.PlayerGui.SquidInk.Enabled = true
					end

					while getgenv().settings.AntiSquid do
						if LocalPlayer.PlayerGui:FindFirstChild("SquidInk") then
							LocalPlayer.PlayerGui.SquidInk.Enabled = false
						end
						task.wait()
					end
				end})
				AntiSquid:ToolTip("Disables any trace of ink on your screen")

				local AntiHallowJack = Anti1:Toggle({Name = "Anti Hallow Jack",Flag = "AntiHallowJack",Side = "Left",Value = false,Callback = function(Toggle_Bool) 
					LocalPlayer.PlayerScripts.HallowJackAbilities.Disabled = Toggle_Bool
				end})
				AntiHallowJack:ToolTip("Disables the effects of the Jack-O-Lantern ability")

				local AntiConveyor = Anti1:Toggle({Name = "Anti Conveyor",Flag = "AntiConveyor",Side = "Left",Value = false,Callback = function(Toggle_Bool) 
					LocalPlayer.PlayerScripts.ConveyorVictimized.Disabled = Toggle_Bool
				end})
				AntiConveyor:ToolTip("Disables the effect of the Conveyor ability")

				local AntiREDACTED = Anti1:Toggle({Name = "Anti [ REDACTED ]",Flag = "AntiREDACTED",Side = "Left",Value = false,Callback = function(Toggle_Bool) 
					LocalPlayer.PlayerScripts.Well.Disabled = Toggle_Bool
				end})
				AntiREDACTED:ToolTip("Disables the chance of you being sucked in by the REDACTED glove ability")

				local AntiZaHando = Anti1:Toggle({Name = "Anti Za Hando",Flag = "AntiZaHando",Side = "Left",Value = false,Callback = function(Toggle_Bool) 
					getgenv().settings.AntiZaHando = Toggle_Bool
					while getgenv().settings.AntiZaHando do
						for i,v in pairs(game.Workspace:GetChildren()) do
							if v.ClassName == "Part" and v.Name == "Part" then
								v:Destroy()
							end
						end
						task.wait()
					end
				end})
				AntiZaHando:ToolTip("Removes the part of the glove that causes it to be pulled towards the person")

				local AntiReaper = Anti1:Toggle({Name = "Anti Reaper",Flag = "AntiReaper",Side = "Left",Value = false,Callback = function(Toggle_Bool) 
					getgenv().settings.AntiReaper = Toggle_Bool
					while getgenv().settings.AntiReaper do
						for i,v in pairs(LocalPlayer.Character:GetDescendants()) do
							if v.Name == "DeathMark" then
								game:GetService("ReplicatedStorage").ReaperGone:FireServer(LocalPlayer.Character.DeathMark)
								game:GetService("Lighting"):WaitForChild("DeathMarkColorCorrection"):Destroy() 
							end
						end
						task.wait()
					end
				end})
				AntiReaper:ToolTip("Removes the Reaper's mark and its associated effects")

				local AntiMail = Anti1:Toggle({Name = "Anti Mail",Flag = "AntiMail",Side = "Left",Value = false,Callback = function(Toggle_Bool) 
					getgenv().settings.AntiMail = Toggle_Bool
					LocalPlayer.Character.YouHaveGotMail.Disabled = Toggle_Bool
					while getgenv().settings.AntiMail do
						if LocalPlayer.Character:FindFirstChild("YouHaveGotMail") then
							LocalPlayer.Character.YouHaveGotMail.Disabled = true
						end
						task.wait()
					end
				end})
				AntiMail:ToolTip("It prevents the deadly card from appearing on your screen")

				local AntiStun = Anti1:Toggle({Name = "Anti Stun",Flag = "AntiStun",Side = "Left",Value = false,Callback = function(Toggle_Bool) 
					getgenv().settings.AntiStun = Toggle_Bool
					while getgenv().settings.AntiStun do
						if LocalPlayer.Character:FindFirstChild("Humanoid") ~= nil and game.Workspace:FindFirstChild("Shockwave") then
							LocalPlayer.Character.Humanoid.PlatformStand = false
						end
						task.wait()
					end
				end})
				AntiStun:ToolTip("Removes the shockwave caused by the stun ability")

				local AntiNightmare = Anti1:Toggle({Name = "Anti Nightmare",Flag = "AntiNightmare",Side = "Left",Value = false,Callback = function(Toggle_Bool) 
					getgenv().settings.AntiNightmare = Toggle_Bool
					if getgenv().settings.AntiNightmare == true then
						game.Players.LocalPlayer.PlayerScripts.VFXListener.NightmareEffect.Parent = game.Lighting
					else
						game.Players.LocalPlayer.PlayerScripts.VFXListener.NightmareEffect.Parent = game.Players.LocalPlayer.PlayerScripts.VFXListener
					end
				end})
				AntiNightmare:ToolTip("Deactivates the effects caused by the Nightmare glove")
			end

			local Anti2 = AntiTab:Section({Name = "Anti 2",Side = "Right"}) do
				local AntiVoid = Anti2:Toggle({Name = "Anti Void",Flag = "AntiVoid",Side = "Left",Value = false,Callback = function(Toggle_Bool) 
					game.Workspace.dedBarrier.CanCollide = Toggle_Bool
					game.Workspace.arenaVoid.CanCollide = Toggle_Bool
					TournamentAntiVoid.CanCollide = Toggle_Bool
				end})
				AntiVoid:ToolTip("Activates the anti-void to prevent falling directly into the void")

				local AntiDB = Anti2:Toggle({Name = "Anti Death Barrier",Flag = "AntiDB",Side = "Left",Value = false,Callback = function(Toggle_Bool) 
					getgenv().settings.AntiDB = Toggle_Bool
					if getgenv().settings.AntiDB == true then
						for i,v in pairs(game.Workspace.DEATHBARRIER:GetChildren()) do
							if v.ClassName == "Part" and v.Name == "BLOCK" then
								v.CanTouch = false
							end
						end
						workspace.DEATHBARRIER.CanTouch = false
						workspace.DEATHBARRIER2.CanTouch = false
						workspace.dedBarrier.CanTouch = false
						workspace.ArenaBarrier.CanTouch = false
						workspace.AntiDefaultArena.CanTouch = false
					else
						for i,v in pairs(game.Workspace.DEATHBARRIER:GetChildren()) do
							if v.ClassName == "Part" and v.Name == "BLOCK" then
								v.CanTouch = true
							end
						end
						workspace.DEATHBARRIER.CanTouch = true
						workspace.DEATHBARRIER2.CanTouch = true
						workspace.dedBarrier.CanTouch = true
						workspace.ArenaBarrier.CanTouch = true
						workspace.AntiDefaultArena.CanTouch = true
					end
				end})
				AntiDB:ToolTip("Disables the death barriers that would otherwise result in death")

				local AntiBrick = Anti2:Toggle({Name = "Anti Brick",Flag = "AntiBrick",Side = "Left",Value = false,Callback = function(Toggle_Bool) 
					getgenv().settings.AntiBrick = Toggle_Bool
					while getgenv().settings.AntiBrick do
						for i,v in pairs(game.Workspace:GetChildren()) do
							if v.Name == "Union" then
								v.CanTouch = false
							end
						end
						task.wait()
					end
				end})
				AntiBrick:ToolTip("Prevents the bricks from being touched to prevent the player from being ragdolled")

				local AntiBrazil = Anti2:Toggle({Name = "Anti Brazil",Flag = "AntiBrazil",Side = "Left",Value = false,Callback = function(Toggle_Bool) 
					getgenv().settings.AntiBrazil = Toggle_Bool
					if getgenv().settings.AntiBrazil == true then
						for i,v in pairs(game.Workspace.Lobby.brazil:GetChildren()) do
							if v.ClassName == "Part" then
								v.CanTouch = false
							end
						end
					else
						for i,v in pairs(game.Workspace.Lobby.brazil:GetChildren()) do
							if v.ClassName == "Part" then
								v.CanTouch = true
							end
						end
					end
				end})

				local AntiCOD = Anti2:Toggle({Name = "Anti Cube Of Death",Flag = "AntiCOD",Side = "Left",Value = false,Callback = function(Toggle_Bool) 
					workspace.Arena.CubeOfDeathArea["the cube of death(i heard it kills)"].CanTouch = Toggle_Bool
				end})

				local AntiPusher = Anti2:Toggle({Name = "Anti Pusher",Flag = "AntiPusher",Side = "Left",Value = false,Callback = function(Toggle_Bool) 
					getgenv().settings.AntiPusher = Toggle_Bool
					while getgenv().settings.AntiPusher do
						for i,v in pairs(game.Workspace:GetChildren()) do
							if v.Name == "wall" then
								v.CanCollide = false
							end
						end
						task.wait()
					end
				end})

				local AntiBooster = Anti2:Toggle({Name = "Anti Booster",Flag = "AntiBooster",Side = "Left",Value = false,Callback = function(Toggle_Bool) 
					getgenv().settings.AntiBooster = Toggle_Bool
					while getgenv().settings.AntiBooster do
						for i,v in pairs(LocalPlayer.Character:GetDescendants()) do
							if v.Name == "BoosterObject" then
								v:Destroy()
							end
						end
						task.wait()
					end
				end})

				local AntiRock = Anti2:Toggle({Name = "Anti Rock",Flag = "AntiRock",Side = "Left",Value = false,Callback = function(Toggle_Bool) 
					getgenv().settings.AntiRock = Toggle_Bool
					while getgenv().settings.AntiRock do
						for i,v in pairs(game.Workspace:GetDescendants()) do
							if v.Name == "rock" then
								v.CanTouch = false
								v.CanQuery = false
							end
						end
						task.wait()
					end
				end})

				local AntiIce = Anti2:Toggle({Name = "Anti Ice",Flag = "AntiIce",Side = "Left",Value = false,Callback = function(Toggle_Bool) 
					getgenv().settings.AntiIce = Toggle_Bool

					while getgenv().settings.AntiIce do
						for _, v in pairs(LocalPlayer.Character:GetDescendants()) do
							if v.Name == "Icecube" then
								v:Destroy()
							end
						end
						task.wait()
					end
				end})

				local AntiBarrier = Anti2:Toggle({Name = "Anti Barrier",Flag = "AntiBarrier",Side = "Left",Value = false,Callback = function(Toggle_Bool) 
					getgenv().settings.AntiBarrier = Toggle_Bool
					if getgenv().settings.AntiBarrier == false then
						for i,v in pairs(game.Workspace:GetChildren()) do
							if string.find(v.Name, "ÅBarrier") then
								v.CanCollide = true
							end
						end
					end

					while getgenv().settings.AntiBarrier do
						for i,v in pairs(game.Workspace:GetChildren()) do
							if string.find(v.Name, "ÅBarrier") then
								v.CanCollide = false
							end
						end
						task.wait()
					end
				end})

				local AntiBubble = Anti2:Toggle({Name = "Anti Bubble",Flag = "AntiBubble",Side = "Left",Value = false,Callback = function(Toggle_Bool) 
					getgenv().settings.AntiBubble = Toggle_Bool
					if getgenv().settings.AntiBubble == true then
						while getgenv().settings.AntiBubble do
							task.wait()
							for i,v in pairs(workspace:GetChildren()) do
								if v.Name == "BubbleObject" then
									if v:FindFirstChild("Weld") then
										v:FindFirstChild("Weld"):Destroy()
									end
								end
							end
						end
					end
				end})

				local AntiBus = Anti2:Toggle({Name = "Anti Bus",Flag = "AntiBus",Side = "Left",Value = false,Callback = function(Toggle_Bool) 
					getgenv().settings.AntiBus = Toggle_Bool
					while getgenv().settings.AntiBus do
						for _, v in pairs(game.Workspace:GetDescendants()) do
							if v.Name == "BusModel" then
								v:Destroy()
							end
						end
						task.wait()
					end
				end})

				local AntiObby = Anti2:Toggle({Name = "Anti Obby",Flag = "AntiObby",Side = "Left",Value = false,Callback = function(Toggle_Bool) 
					getgenv().settings.AntiObby = Toggle_Bool
					obby_value = getgenv().settings.AntiObby
					for _, child in pairs(game.Workspace:GetChildren()) do
						local name = child.Name
						if (string.find(name, "LavaSpinner") or string.find(name, "LavaBlock")) and getgenv().settings.AntiObby then
							child.CanTouch = obby_value
						end
					end

				end})
			end
		end
		local CombatTab = Window:Tab({Name = "Combat"}) do
			local GloveSection = CombatTab:Section({Name = "Glove",Side = "Left"}) do
				local SlapAura = GloveSection:Toggle({Name = "Slap Aura",Flag = "SlapAura",Side = "Left",Value = false,Callback = function(Toggle_Bool) 
					getgenv().settings.SlapAura = Toggle_Bool
					while getgenv().settings.SlapAura do
						for i, v in pairs(game.Players:GetChildren()) do
							if v ~= LocalPlayer and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and v.Character then
								if v.Character:FindFirstChild("entered") and v.Character:FindFirstChild("HumanoidRootPart") and v.Character:FindFirstChild("rock") == nil and v.Character.HumanoidRootPart.BrickColor ~= BrickColor.new("New Yeller") and v.Character:FindFirstChild("Mirage") == nil or v.Character:FindFirstChild("Mirage") == false then
									if v.Character.Head:FindFirstChild("UnoReverseCard") == nil or getGlove() == "Error" then
										Magnitude = (LocalPlayer.Character.HumanoidRootPart.Position - v.Character.HumanoidRootPart.Position).Magnitude
										if getgenv().settings.SlapAuraReach >= Magnitude then
											shared.gloveHits[getGlove()]:FireServer(v.Character:WaitForChild("HumanoidRootPart"),true)
										end
									end
								end
							end
						end
						task.wait()
					end
				end})

				local SlapAuraReach = GloveSection:Slider({Name = "Slap Aura Reach",Flag = "SlapAuraReach",Side = "Left",Min = 0,Max = 25,Value = 25,Precise = 1,Unit = "",Callback = function(Value_Number) 
					getgenv().settings.SlapAuraReach = Value_Number
				end})

				local GodMode = GloveSection:Dropdown({Name = "God Mode ( resets character )",Flag = "GodMode",Side = "Left",List = {
					{
						Name = "God Mode",
						Mode = "Button",
						Value = false,
						Callback = function(Selected)
							if LocalPlayer.Character:FindFirstChild("entered") == nil then
								firetouchinterest(LocalPlayer.Character:WaitForChild("Head"), workspace.Lobby.Teleport1, 0)
								firetouchinterest(LocalPlayer.Character:WaitForChild("Head"), workspace.Lobby.Teleport1, 1)
							end
							repeat task.wait() until LocalPlayer.Character:FindFirstChildWhichIsA("Tool") or LocalPlayer.Backpack:FindFirstChildWhichIsA("Tool")
							for i,v in pairs(LocalPlayer.Character:GetChildren()) do
								if v.ClassName == "Tool" then
									v.Parent = game.LogService
								end
							end
							for i,v in pairs(LocalPlayer.Backpack:GetChildren()) do
								v.Parent = game.LogService
							end
							game:GetService("ReplicatedStorage"):WaitForChild("HumanoidDied"):FireServer(LocalPlayer.Character,false)
							wait(3.75)
							for i,v in pairs(game.LogService:GetChildren()) do
								v.Parent = LocalPlayer.Backpack
							end
							for i,v in pairs(LocalPlayer.Backpack:GetChildren()) do
								LocalPlayer.Character.Humanoid:EquipTool(v)
							end 
							LocalPlayer.Character.HumanoidRootPart.CFrame = game.workspace.Origo.CFrame * CFrame.new(0,-5,0)
							Bracket:Notification({Title = "Warn",Description = "God Mode breaks killstreak and reaper!",Duration = 10})
						end
					},
					{
						Name = "God Mode + Invisibility",
						Mode = "Button",
						Value = false,
						Callback = function(Selected)
							if LocalPlayer.leaderstats.Slaps.Value >= 666 then
								if LocalPlayer.Character:FindFirstChild("entered") == nil then
									firetouchinterest(LocalPlayer.Character:WaitForChild("Head"), workspace.Lobby.Teleport1, 0)
									firetouchinterest(LocalPlayer.Character:WaitForChild("Head"), workspace.Lobby.Teleport1, 1)
								end
								repeat task.wait() until LocalPlayer.Character:FindFirstChildWhichIsA("Tool") or LocalPlayer.Backpack:FindFirstChildWhichIsA("Tool")
								for i,v in pairs(LocalPlayer.Character:GetChildren()) do
									if v.ClassName == "Tool" then
										v.Parent = game.LogService
									end
								end
								for i,v in pairs(LocalPlayer.Backpack:GetChildren()) do
									v.Parent = game.LogService
								end
								game:GetService("ReplicatedStorage"):WaitForChild("HumanoidDied"):FireServer(LocalPlayer.Character,false)
								wait(3.75)
								OGlove = getGlove()
								fireclickdetector(workspace.Lobby.Ghost.ClickDetector)
								game.ReplicatedStorage.Ghostinvisibilityactivated:FireServer()
								fireclickdetector(workspace.Lobby[OGlove].ClickDetector)
								for i,v in pairs(game.LogService:GetChildren()) do
									v.Parent = LocalPlayer.Backpack
								end
								for i,v in pairs(LocalPlayer.Backpack:GetChildren()) do
									LocalPlayer.Character.Humanoid:EquipTool(v)
								end 
								LocalPlayer.Character.HumanoidRootPart.CFrame = game.workspace.Origo.CFrame * CFrame.new(0,-5,0)
								Bracket:Notification({Title = "Warn",Description = "God Mode breaks killstreak and reaper!",Duration = 10})
							else
								Bracket:Notification({Title = "Error",Description = "You need +666 slaps",Duration = 10})
							end
						end
					}
				}})

				local SlapFarmCooldown = GloveSection:Slider({Name = "Slap Farm Cooldown",Flag = "SlapFarmCooldown",Side = "Left",Min = 0,Max = 2,Value = 0.25,Precise = 2,Unit = "",Callback = function(Value_Number) 
					getgenv().settings.SlapFarmCooldown = Value_Number
				end})

				local SlapFarm = GloveSection:Toggle({Name = "Slap Farm",Flag = "SlapFarm",Side = "Left",Value = false,Callback = function(Toggle_Bool) 
					getgenv().settings.SlapFarm = Toggle_Bool
					if getgenv().settings.SlapFarm == true then
						workspace.DEATHBARRIER.CanTouch = false
						workspace.DEATHBARRIER2.CanTouch = false
						workspace.dedBarrier.CanTouch = false
						task.wait()
						while getgenv().settings.SlapFarm do
							task.wait()
							pcall(function()
								for Index, Human in next, game.Players:GetPlayers() do
									if Human ~= LocalPlayer and Human.Character and not Human.Character:FindFirstChild("isParticipating") and Human.Character:FindFirstChild("Torso") and Human.Character:FindFirstChild("Head") and Human.Character:FindFirstChild("entered") and Human.Character.Head:FindFirstChild("UnoReverseCard") == nil and Human.Character:FindFirstChild("rock") == nil and Human.Character.Ragdolled.Value == false then
										if LocalPlayer.Character:FindFirstChild("entered") and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
											task.wait(getgenv().settings.SlapFarmCooldown)
											LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = Human.Character:FindFirstChild("Right Leg").CFrame * CFrame.new(6,-2,6)
											LocalPlayer.Character:WaitForChild("Humanoid").PlatformStand = true
											wait(getgenv().settings.SlapFarmCooldown)
											shared.gloveHits[getGlove()]:FireServer(Human.Character:FindFirstChild("Torso"))
											wait(getgenv().settings.SlapFarmCooldown)
										end
									end
								end
							end)
						end
					else
						workspace.DEATHBARRIER.CanTouch = true
						workspace.DEATHBARRIER2.CanTouch = true
						workspace.dedBarrier.CanTouch = true
						if LocalPlayer.Character.Humanoid.PlatformStand == true then
							task.wait(3)
							LocalPlayer.Character.Humanoid.PlatformStand = false
						end
					end
				end})
				local GloveExtender = GloveSection:Toggle({Name = "Glove Extender",Flag = "GloveExtender",Side = "Left",Value = false,Callback = function(Toggle_Bool)
					getgenv().settings.GloveExtend = Toggle_Bool
				end})
				local ExtenderType = GloveSection:Dropdown({Name = "Extender Option",Flag = "ExtenderType",Side = "Left",List = {
					{
						Name = "Meat Stick",
						Mode = "Button",
						Value = false,
						Callback = function(Selected)
							getgenv().settings.ExtendOption = "Meat Stick"
						end
					},
					{
						Name = "Pancake",
						Mode = "Button",
						Value = false,
						Callback = function(Selected)
							getgenv().settings.ExtendOption = "Pancake"
						end
					},
					{
						Name = "Growth",
						Mode = "Button",
						Value = false,
						Callback = function(Selected)
							getgenv().settings.ExtendOption = "Growth"
						end
					},
					{
						Name = "North Korea Wall",
						Mode = "Button",
						Value = false,
						Callback = function(Selected)
							getgenv().settings.ExtendOption = "North Korea Wall"
						end
					},
					{
						Name = "Slight Extend",
						Mode = "Button",
						Value = false,
						Callback = function(Selected)
							getgenv().settings.ExtendOption = "Slight Extend"
						end
					}
				}})

				local EquipGlove = GloveSection:Textbox({Name = "Equip Glove",Flag = "EquipGlove",Side = "Left",Value = "Default",Placeholder = "Enter glove name here",NumberOnly = false,Callback = function(Text_String,EnterPressed) 
					if LocalPlayer.Character:FindFirstChild("entered") == nil then
						fireclickdetector(workspace.Lobby[Text_String].ClickDetector)
					end
				end})

				local MakeGloveBlock = GloveSection:Button({Name = "Turn glove into a block",Side = "Left",Callback = function() 
					for i,v in pairs(LocalPlayer.Character:GetChildren()) do
						if v:IsA("Tool") then
							local glove = v.Glove
							if glove:IsA("MeshPart") then
								glove.MeshId = ""
							elseif glove:FindFirstChild("Mesh") or glove:FindFirstChild("Cuff") then
								local mesh = glove:FindFirstChild("Mesh")
								local cuff = glove:FindFirstChild("Cuff")
								if mesh then
									mesh:Destroy()
								end
								if cuff then
									local cuffMesh = cuff:FindFirstChild("Mesh")
									if cuffMesh then
										cuffMesh:Destroy()
									end
								end
							end
						end
					end
				end})
				local NoGloveCooldown = GloveSection:Button({Name = "No Glove Cooldown",Side = "Left",Callback = function()
					local player = LocalPlayer
					local character = player.Character or player.CharacterAdded:Wait()
					local tool = character:FindFirstChildOfClass("Tool") or player.Backpack:FindFirstChildOfClass("Tool")

					while character.Humanoid.Health ~= 0 do
						local localscript = tool:FindFirstChildOfClass("LocalScript")
						local localscriptclone = localscript:Clone()
						localscriptclone = localscript:Clone()
						localscriptclone:Clone()
						localscript:Destroy()
						localscriptclone.Parent = tool
						task.wait()
					end
				end})
			end

			local AbilitySection = CombatTab:Section({Name = "Ability Spam",Side = "Right"}) do
				local AbilitySpam = AbilitySection:Toggle({Name = "Glove Ability Spam",Flag = "AbilitySpam",Side = "Left",Value = false,Callback = function(Toggle_Bool)
					getgenv().settings.AbilitySpam = Toggle_Bool
					while getgenv().settings.AbilitySpam and getGlove() == "Gravity" do
						game:GetService("ReplicatedStorage").GeneralAbility:FireServer()
						wait()
					end
					while getgenv().settings.AbilitySpam and getGlove() == "Cloud" do
						game:GetService("ReplicatedStorage").CloudAbility:FireServer()
						wait()
					end
					while getgenv().settings.AbilitySpam and getGlove() == "Whirlwind" do
						game:GetService("ReplicatedStorage").GeneralAbility:FireServer()
						wait()
					end
					while getgenv().settings.AbilitySpam and getGlove() == "Phantom" do
						local Phantom = workspace[Player].Phantom
						game:GetService("ReplicatedStorage").PhantomDash:InvokeServer(Phantom)
						wait()
					end
					while getgenv().settings.AbilitySpam and getGlove() == "Replica" do
						game:GetService("ReplicatedStorage").Duplicate:FireServer()
						wait(5.1)
					end
					while getgenv().settings.AbilitySpam and getGlove() == "Fort" do
						game:GetService("ReplicatedStorage").Fortlol:FireServer()
						wait(3.1)
					end
					while getgenv().settings.AbilitySpam and getGlove() == "Home Run" do
						game:GetService("ReplicatedStorage").HomeRun:FireServer({["start"] = true})
						game:GetService("ReplicatedStorage").HomeRun:FireServer({["finished"] = true})
						task.wait()
					end
					while getgenv().settings.AbilitySpam and getGlove() == "🗿" do
						game:GetService("ReplicatedStorage"):WaitForChild("GeneralAbility"):FireServer(CFrame.new(math.random(-70, 63), -5.72293854, math.random(-90, 93), 0.151493087, -8.89114702e-08, 0.988458335, 1.45089563e-09, 1, 8.97272727e-08, -0.988458335, -1.21589121e-08, 0.151493087))
						wait(3.1)
					end
					while getgenv().settings.AbilitySpam and getGlove() == "Shukuchi" do
						local LocalPlayer = LocalPlayer
						local players = game.Players:GetChildren()
						local RandomPlayer = players[math.random(1, #players)]
						repeat RandomPlayer = players[math.random(1, #players)] until RandomPlayer ~= LocalPlayer
						repeat RandomPlayer = players[math.random(1, #players)] until RandomPlayer.Character.isInArena.Value == true
						PersonToKill = RandomPlayer
						game:GetService("ReplicatedStorage").SM:FireServer(PersonToKill)
						wait(0.01)
					end
					while getgenv().settings.AbilitySpam and getGlove() == "Slicer" do
						game:GetService("ReplicatedStorage").Slicer:FireServer("sword")
						game:GetService("ReplicatedStorage").Slicer:FireServer("slash", LocalPlayer.Character.HumanoidRootPart.CFrame, Vector3.new())
						wait(5.1)
					end
					while getgenv().settings.AbilitySpam and getGlove() == "Quake" do
						game:GetService("ReplicatedStorage").QuakeQuake:FireServer({["start"] = true})
						wait()
					end
					while getgenv().settings.AbilitySpam and getGlove() == "rob" do
						game:GetService("ReplicatedStorage"):WaitForChild("rob"):FireServer()
						wait()
					end
					while getgenv().settings.AbilitySpam and getGlove() == "Kraken" do
						game:GetService("ReplicatedStorage").KrakenArm:FireServer()
						wait(5)
					end
					while getgenv().settings.AbilitySpam and getGlove() == "Psycho" do
						game:GetService("ReplicatedStorage").Psychokinesis:InvokeServer({["grabEnabled"] = true})
						task.wait()
					end
					while getgenv().settings.AbilitySpam and getGlove() == "Killstreak" and LocalPlayer.PlayerGui:FindFirstChild("Kills") and LocalPlayer.PlayerGui.Kills.Frame.TextLabel.Text >= "75" do
						game:GetService("ReplicatedStorage").KSABILI:FireServer()
						wait(6.1)
					end
					while getgenv().settings.AbilitySpam and getGlove() == "Bus" do
						game:GetService("ReplicatedStorage").busmoment:FireServer()
						wait(5.1)
					end
					while getgenv().settings.AbilitySpam and getGlove() == "Mitten" do
						game:GetService("ReplicatedStorage").MittenA:FireServer()
						wait(5.1)
					end
					while getgenv().settings.AbilitySpam and getGlove() == "Fort" do
						game:GetService("ReplicatedStorage").Fortlol:FireServer()
						wait(3.1)
					end
					while getgenv().settings.AbilitySpam and getGlove() == "Defense" do
						game:GetService("ReplicatedStorage").Barrier:FireServer()
						wait(0.25)
					end
					while getgenv().settings.AbilitySpam and getGlove() == "Bomb" do
						game:GetService("ReplicatedStorage").BombThrow:FireServer()
						wait(2.5)
						game:GetService("ReplicatedStorage").BombThrow:FireServer()
						wait(4.1)
					end
					while getgenv().settings.AbilitySpam and getGlove() == "Replica" do
						game:GetService("ReplicatedStorage").Duplicate:FireServer()
						wait(5.1)
					end
					while getgenv().settings.AbilitySpam and getGlove() == "Pusher" do
						game:GetService("ReplicatedStorage").PusherWall:FireServer()
						wait(5.1)
					end
					while getgenv().settings.AbilitySpam and getGlove() == "Jet" do
						local jetGUI = game.ReplicatedStorage.JetTarget:Clone()
						local LocalPlayer = LocalPlayer
						local players = game.Players:GetChildren()
						local closestPlayer = nil
						local closestDistance = math.huge
						for _, player in ipairs(players) do
							if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
								local playerPosition = player.Character.HumanoidRootPart.Position
								local distance = (playerPosition - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
								if distance < closestDistance then
									closestPlayer = player
									closestDistance = distance
								end
							end
						end
						if closestPlayer then
							jetGUI.Parent = closestPlayer.Character.HumanoidRootPart
							for _, v in pairs(jetGUI:GetDescendants()) do
								if v:IsA("ImageLabel") then 
									local TweenService = game:GetService("TweenService")
									local imageLabel = v
									local initialTransparency = imageLabel.ImageTransparency
									local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false)
									local tween = TweenService:Create(imageLabel, tweenInfo, {ImageTransparency = 0})
									tween:Play()
								end
							end
							game:GetService("ReplicatedStorage").AirStrike:FireServer(closestPlayer.Character)
							wait(5.3)
							for _, v in pairs(jetGUI:GetDescendants()) do
								if v:IsA("ImageLabel") then 
									local TweenService = game:GetService("TweenService")
									local imageLabel = v
									local initialTransparency = imageLabel.ImageTransparency
									local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false)
									local tween = TweenService:Create(imageLabel, tweenInfo, {ImageTransparency = 1})
									tween:Play()
								end
							end
						end
					end
					while getGlove() == "Tableflip" or getGlove() == "Shield" and getgenv().settings.AbilitySpam do
						game:GetService("ReplicatedStorage").GeneralAbility:FireServer()
						wait(3.2)
					end
					while getgenv().settings.AbilitySpam and getGlove() == "Rocky" do
						game:GetService("ReplicatedStorage").RockyShoot:FireServer()
						wait(6.1)
					end
					while getgenv().settings.AbilitySpam and getGlove() == "God's Hand" do
						game:GetService("ReplicatedStorage").TimestopJump:FireServer()
						game:GetService("ReplicatedStorage").Timestopchoir:FireServer()
						game:GetService("ReplicatedStorage").Timestop:FireServer()
						wait(50.1)
					end
					while getgenv().settings.AbilitySpam and getGlove() == "Za Hando" do
						game:GetService("ReplicatedStorage").Erase:FireServer()
						wait(5.1)
					end
					while getGlove() == "Baller" or getGlove() == "Glitch" and getgenv().settings.AbilitySpam do
						game:GetService("ReplicatedStorage").GeneralAbility:FireServer()
						wait(4.1)
					end
					while getgenv().settings.AbilitySpam and getGlove() == "Stun" do
						game:GetService("ReplicatedStorage").StunR:FireServer(game:GetService("Players").LocalPlayer.Character.Stun)
						wait(10.1)
					end
					while getgenv().settings.AbilitySpam and getGlove() == "STOP" do
						game:GetService("ReplicatedStorage").STOP:FireServer(true)
						wait(4.1)
					end
					while getgenv().settings.AbilitySpam and getGlove() == "Track" do
						local LocalPlayer = LocalPlayer
						local players = game.Players:GetChildren()
						local closestPlayer = nil
						local closestDistance = math.huge
						for _, player in ipairs(players) do
							if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
								local playerPosition = player.Character.HumanoidRootPart.Position
								local distance = (playerPosition - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
								if distance < closestDistance then
									closestPlayer = player
									closestDistance = distance
								end
							end
						end
						if closestPlayer then
							game:GetService("ReplicatedStorage").GeneralAbility:FireServer(closestPlayer.Character)
							wait(10.1)
						end
					end
					while getgenv().settings.AbilitySpam and getGlove() == "Mail" do
						game:GetService("ReplicatedStorage").MailSend:FireServer()
						wait(3.1)
					end
					while getgenv().settings.AbilitySpam and getGlove() == "Shard" do
						game:GetService("ReplicatedStorage").Shards:FireServer()
						wait(4.1)
					end
					while getgenv().settings.AbilitySpam and getGlove() == "Swapper" do
						game:GetService("ReplicatedStorage").SLOC:FireServer()
						wait(5.1)
					end
					while getgenv().settings.AbilitySpam and getGlove() == "Bubble" do
						game:GetService("ReplicatedStorage").BubbleThrow:FireServer()
						wait(3.1)
					end
					while getgenv().settings.AbilitySpam and getGlove() == "Slapple" do
						game:GetService("ReplicatedStorage").funnyTree:FireServer(LocalPlayer.Character.HumanoidRootPart.Position)
						wait(3.1)
					end
					while getgenv().settings.AbilitySpam and getGlove() == "Kinetic" do
						game:GetService("ReplicatedStorage").KineticExpl:FireServer(game:GetService("Players").LocalPlayer.Character.Kinetic, LocalPlayer.Character.HumanoidRootPart.Position)
						wait(9.1)
					end
					while getgenv().settings.AbilitySpam and getGlove() == "Dominance" do
						game:GetService("ReplicatedStorage").DominanceAc:FireServer(LocalPlayer.Character.HumanoidRootPart.Position)
						wait(3.1)
					end
					while getgenv().settings.AbilitySpam and getGlove() == "[REDACTED]" do
						game:GetService("ReplicatedStorage").Well:FireServer()
						wait(5.1)
					end
					while getgenv().settings.AbilitySpam and getGlove() == "Duelist" do
						game:GetService("ReplicatedStorage").DuelistAbility:FireServer()
						wait(5.1)
					end
					while getgenv().settings.AbilitySpam and getGlove() == "Engineer" do
						game:GetService("ReplicatedStorage").Sentry:FireServer()
						wait(5.1)
					end
					while getgenv().settings.AbilitySpam and getGlove() == "Brick" do
						game:GetService("ReplicatedStorage").lbrick:FireServer()
						game:GetService("Players").LocalPlayer.PlayerGui.BRICKCOUNT.ImageLabel.TextLabel.Text = game:GetService("Players").LocalPlayer.PlayerGui.BRICKCOUNT.ImageLabel.TextLabel.Text + 1
						wait(1.1)
					end
					while getgenv().settings.AbilitySpam and getGlove() == "Trap" do
						game:GetService("ReplicatedStorage").funnyhilariousbeartrap:FireServer()
						wait(3.1)
					end
					while getgenv().settings.AbilitySpam and getGlove() == "woah" do
						game:GetService("ReplicatedStorage").VineThud:FireServer()
						wait(5.1)
					end
					while getgenv().settings.AbilitySpam and getGlove() == "Ping Pong" do
						game:GetService("ReplicatedStorage").GeneralAbility:FireServer()
						task.wait()
					end
					while getgenv().settings.AbilitySpam and getGlove() == "Recall" do
						game:GetService("ReplicatedStorage").Recall:InvokeServer(game:GetService("Players").LocalPlayer.Character.Recall)
						wait(3.1)
					end
					while getgenv().settings.AbilitySpam and getGlove() == "ZZZZZZZ" do
						game:GetService("ReplicatedStorage").ZZZZZZZSleep:FireServer()
						task.wait()
					end
					while getgenv().settings.AbilitySpam and getGlove() == "Charge" do
						game:GetService("ReplicatedStorage").GeneralAbility:FireServer(game:GetService("Players").LocalPlayer.Character.Charge)
						wait(3.1)
					end
					while getgenv().settings.AbilitySpam and getGlove() == "Coil" do
						game:GetService("ReplicatedStorage"):WaitForChild("GeneralAbility"):FireServer(game:GetService("Players").LocalPlayer.Character.Coil)
						LocalPlayer.Character.Humanoid.WalkSpeed = WS
						wait(3.1)
					end
					while getgenv().settings.AbilitySpam and getGlove() == "Diamond" do
						game:GetService("ReplicatedStorage"):WaitForChild("Rockmode"):FireServer()
						task.wait()
					end
					while getgenv().settings.AbilitySpam and getGlove() == "Excavator" do
						game:GetService("ReplicatedStorage"):WaitForChild("Excavator"):InvokeServer()
						game:GetService("ReplicatedStorage"):WaitForChild("ExcavatorCancel"):FireServer()
						wait(7.3)
					end
					while getgenv().settings.AbilitySpam and getGlove() == "Thor" do
						game:GetService("ReplicatedStorage").ThorAbility:FireServer(LocalPlayer.Character.HumanoidRootPart.CFrame)
						task.wait()
					end
					while getgenv().settings.AbilitySpam and getGlove() == "Counter" do
						game:GetService("ReplicatedStorage").Counter:FireServer()
						task.wait(6.2)
					end
					while getgenv().settings.AbilitySpam and getGlove() == "Voodoo" do
						game:GetService("ReplicatedStorage").GeneralAbility:FireServer()
						task.wait(6.27)
					end
					while getgenv().settings.AbilitySpam and getGlove() == "Balloony" do
						game:GetService("ReplicatedStorage").GeneralAbility:FireServer(game:GetService("Players").LocalPlayer.Character.Balloony)
						task.wait()
					end
					while getgenv().settings.AbilitySpam and getGlove() == "Phase" do
						game:GetService("ReplicatedStorage").PhaseA:FireServer()
						task.wait(8.2)
					end
					while getgenv().settings.AbilitySpam and getGlove() == "Detonator" do
						game:GetService("ReplicatedStorage").Fart:FireServer()
						task.wait()
					end
					while getgenv().settings.AbilitySpam and getGlove() == "Sparky" do
						game:GetService("ReplicatedStorage").Sparky:FireServer(game:GetService("Players").LocalPlayer.Character.Sparky)
						task.wait()
					end
					while getgenv().settings.AbilitySpam and getGlove() == "Adios" do
						game:GetService("ReplicatedStorage").AdiosActivated:FireServer()
						wait(8.3)
					end
					while getgenv().settings.AbilitySpam and getGlove() == "Beserk" do
						game:GetService("ReplicatedStorage").BerserkCharge:FireServer(game:GetService("Players").LocalPlayer.Character.Berserk)
						wait(2.1)
					end
					while getgenv().settings.AbilitySpam and getGlove() == "Hallow Jack" do
						game:GetService("ReplicatedStorage"):WaitForChild("Hallow"):FireServer()
						wait(4.2)
					end
					while getGlove() == "Meteor" and getgenv().settings.AbilitySpam do
						game:GetService("ReplicatedStorage").GeneralAbility:FireServer()
						wait()
					end
				end})
				local HomeRunMax = AbilitySection:Toggle({Name = "Spam HomeRun Max",Flag = "HomeRunMax",Side = "Left",Value = false,Callback = function(Toggle_Bool)
					getgenv().settings.HomeRunMax = Toggle_Bool
					while getgenv().settings.HomeRunMax do
						local args = {
							[1] = {
								["start"] = true
							}
						}
						game:GetService("ReplicatedStorage").HomeRun:FireServer(unpack(args))
						task.wait(3.05)
					end 
				end})

				local PopBalloony = AbilitySection:Toggle({Name = "Spam Pop Balloony",Flag = "PopBalloony",Side = "Left",Value = false,Callback = function(Toggle_Bool)
					getgenv().settings.PopBalloony = Toggle_Bool
					while getgenv().settings.PopBalloony do
						game:GetService("ReplicatedStorage").Events.PopBalloon:FireServer()
						task.wait()
					end
				end})

				local RhythmExplosion = AbilitySection:Toggle({Name = "Spam Rhythm Explosion",Flag = "RhythmExplosion",Side = "Left",Value = false,Callback = function(Toggle_Bool)
					getgenv().settings.RhythmExplosion = Toggle_Bool
					while getgenv().settings.RhythmExplosion do
						game:GetService("ReplicatedStorage").rhythmevent:FireServer("AoeExplosion",0)
						task.wait()
					end
				end})

				local NullMinions = AbilitySection:Toggle({Name = "Spawn Null Minions",Flag = "NullMinions",Side = "Left",Value = false,Callback = function(Toggle_Bool)
					getgenv().settings.NullMinions = Toggle_Bool
					while getgenv().settings.NullMinions do
						game:GetService("ReplicatedStorage").NullAbility:FireServer()
						task.wait()
					end
				end})

				local SlapMinions = AbilitySection:Toggle({Name = "Slap Null Minions",Flag = "SlapMinions",Side = "Left",Value = false,Callback = function(Toggle_Bool)
					getgenv().settings.SlapMinions = Toggle_Bool
					while getgenv().settings.SlapMinions do
						for i,v in pairs(game.Workspace:GetChildren()) do
							if v.Name == "Imp" then
								if v:FindFirstChild("Body") then
									shared.gloveHits[getGlove()]:FireServer(v.Body)
								end
							end
						end
						wait()
					end
				end})

				local RojoPlayer = AbilitySection:Textbox({Name = "Rojo Player",Flag = "RojoPlayer",Side = "Left",Value = LocalPlayer.Name,Placeholder = "Enter username here",NumberOnly = false,Callback = function(Text_String,EnterPressed) 
					if Text_String == "Me" or Text_String == "me" or Text_String == "Username" or Text_String == "" then
						getgenv().settings.RojoPlayer = LocalPlayer.Name
					else
						getgenv().settings.RojoPlayer = Text_String
					end
				end})

				local RojoSpam = AbilitySection:Toggle({Name = "Rojo Spam",Flag = "RojoSpam",Side = "Left",Value = false,Callback = function(Toggle_Bool)
					getgenv().settings.RojoSpam = Toggle_Bool
					if getgenv().settings.RojoPlayer == nil then
						getgenv().settings.RojoPlayer = LocalPlayer.Name
					end
					while getgenv().settings.RojoSpam do
						game:GetService("ReplicatedStorage"):WaitForChild("RojoAbility"):FireServer("Release", {game.Players[getgenv().settings.RojoPlayer].Character.HumanoidRootPart.CFrame})
						task.wait()
					end
				end})

				local GuardianPlayer = AbilitySection:Textbox({Name = "Guardian Player",Flag = "GuardianPlayer",Side = "Left",Value = LocalPlayer.Name,Placeholder = "Enter username here",NumberOnly = false,Callback = function(Text_String,EnterPressed) 
					if Text_String == "Me" or Text_String == "me" or Text_String == "Username" or Text_String == "" then
						getgenv().settings.GuardianPlayer = LocalPlayer.Name
					else
						getgenv().settings.GuardianPlayer = Text_String
					end
				end})

				local GuardianSpam = AbilitySection:Toggle({Name = "Guardian Spam",Flag = "GuardianSpam",Side = "Left",Value = false,Callback = function(Toggle_Bool)
					getgenv().settings.GuardianSpam = Toggle_Bool
					if getgenv().settings.GuardianPlayer == nil then
						getgenv().settings.GuardianPlayer = LocalPlayer.Name
					end
					while getgenv().settings.GuardianSpam do
						game:GetService("ReplicatedStorage").GeneralAbility:FireServer(game.Players[getgenv().settings.GuardianPlayer])
						task.wait()
					end
				end})


				local RetroAbility = AbilitySection:Dropdown({Name = "Retro Option",Flag = "RetroAbility",Side = "Left",List = {
					{
						Name = "Ban Hammer",
						Mode = "Button",
						Value = true,
						Callback = function(Selected)
							getgenv().settings.RetroOption = "Ban Hammer"
						end
					},
					{
						Name = "Rocket Launcher",
						Mode = "Button",
						Value = false,
						Callback = function(Selected)
							getgenv().settings.RetroOption = "Rocket Launcher"
						end
					},
					{
						Name = "Bomb",
						Mode = "Button",
						Value = false,
						Callback = function(Selected)
							getgenv().settings.RetroOption = "Bomb"
						end
					}
				}})

				local RetroSpam = AbilitySection:Toggle({Name = "Retro Spam",Flag = "RetroSpam",Side = "Left",Value = false,Callback = function(Toggle_Bool)
					getgenv().settings.RetroSpam = Toggle_Bool
					while getgenv().settings.RetroSpam do
						game:GetService("ReplicatedStorage").RetroAbility:FireServer(getgenv().settings.RetroOption)
						task.wait()
					end
				end})
			end
		end
		local MiscTab = Window:Tab({Name = "Miscellaneous"}) do
			local SoundSpamSection = MiscTab:Section({Name = "Sound Spam",Side = "Left"}) do

				local SlicerSound = SoundSpamSection:Toggle({Name = "Slicer Sound Spam",Flag = "SlicerSound",Side = "Left",Value = false,Callback = function(Toggle_Bool)
					getgenv().settings.SlicerSpam = Toggle_Bool
					while getgenv().settings.SlicerSpam do
						game:GetService("ReplicatedStorage").Slicer:FireServer("sword")
						task.wait()
					end
				end})

				local ErrorSound = SoundSpamSection:Toggle({Name = "Error Sound Spam",Flag = "ErrorSound",Side = "Left",Value = false,Callback = function(Toggle_Bool)
					getgenv().settings.ErrorSpam = Toggle_Bool
					while getgenv().settings.ErrorSpam do
						game:GetService("ReplicatedStorage").LetMeBeClear:FireServer(true)
						task.wait(2.1)
					end
				end})

				local ChargeSound = SoundSpamSection:Toggle({Name = "Charge Sound Spam",Flag = "ChargeSound",Side = "Left",Value = false,Callback = function(Toggle_Bool)
					getgenv().settings.ChargeSpam = Toggle_Bool
					while getgenv().settings.ChargeSpam do
						game:GetService("ReplicatedStorage").GeneralAbility:FireServer(game:GetService("Players").LocalPlayer.Character.Charge)
						wait(3.05)
					end
				end})

				local ErrorDeathSound = SoundSpamSection:Toggle({Name = "Error Death Sound Spam",Flag = "ErrorDeathSound",Side = "Left",Value = false,Callback = function(Toggle_Bool)
					getgenv().settings.ErrorDeathSpam = Toggle_Bool
					while getgenv().settings.ErrorDeathSpam do
						game:GetService("ReplicatedStorage").ErrorDeath:FireServer()
						task.wait()
					end
				end})

				local SpaceSound = SoundSpamSection:Toggle({Name = "Space Sound Spam",Flag = "SpaceSound",Side = "Left",Value = false,Callback = function(Toggle_Bool)
					getgenv().settings.SpaceSpam = Toggle_Bool
					while getgenv().settings.SpaceSpam do
						game:GetService("ReplicatedStorage").ZeroGSound:FireServer()
						task.wait()
					end
				end})

				local ThanosSound = SoundSpamSection:Toggle({Name = "Thanos Sound Spam",Flag = "ThanosSound",Side = "Left",Value = false,Callback = function(Toggle_Bool)
					getgenv().settings.ThanosSpam = Toggle_Bool
					while getgenv().settings.ThanosSpam do
						game:GetService("ReplicatedStorage").Illbeback:FireServer()
						task.wait()
					end
				end})

				local GoldenSound = SoundSpamSection:Toggle({Name = "Golden Sound Spam",Flag = "GoldenSound",Side = "Left",Value = false,Callback = function(Toggle_Bool)
					getgenv().settings.GoldenSpam = Toggle_Bool
					while getgenv().settings.GoldenSpam do
						game:GetService("ReplicatedStorage").Goldify:FireServer(true)
						task.wait()
					end
				end})

				local GhostSound = SoundSpamSection:Toggle({Name = "Ghost Sound Spam",Flag = "GhostSound",Side = "Left",Value = false,Callback = function(Toggle_Bool)
					getgenv().settings.GhostSpam = Toggle_Bool
					while getgenv().settings.GhostSpam do
						game.ReplicatedStorage.Ghostinvisibilityactivated:FireServer()
						game.ReplicatedStorage.Ghostinvisibilitydeactivated:FireServer()
						task.wait()
					end
				end})

				local HitmanSound = SoundSpamSection:Toggle({Name = "Hitman Sound Spam",Flag = "HitmanSound",Side = "Left",Value = false,Callback = function(Toggle_Bool)
					getgenv().settings.HitmanSpam = Toggle_Bool
					while getgenv().settings.HitmanSpam do
						game:GetService("ReplicatedStorage"):WaitForChild("HitmanAbility"):FireServer("ReplicateGoldenRevolver",{0})
						task.wait()
					end
				end})

				local FartSound = SoundSpamSection:Toggle({Name = "Fart Sound Spam",Flag = "FartSound",Side = "Left",Value = false,Callback = function(Toggle_Bool)
					getgenv().settings.FartSpam = Toggle_Bool
					while getgenv().settings.FartSpam do
						local rpl = "ReplicateSound"
						game:GetService("ReplicatedStorage").b:FireServer(rpl)
						task.wait()
					end
				end})

				local ZombieSound = SoundSpamSection:Toggle({Name = "Zombie Sound Spam",Flag = "ZombieSound",Side = "Left",Value = false,Callback = function(Toggle_Bool)
					getgenv().settings.ZombieSpam = Toggle_Bool
					while getgenv().settings.ZombieSpam do
						local rpl = "ReplicateSound_Zombie"
						game:GetService("ReplicatedStorage").b:FireServer(rpl)
						task.wait()
					end
				end})
			end
			local ExtraFuncSection = MiscTab:Section({Name = "Gaming Features",Side = "Right"}) do
				local Give20KillsReaper = ExtraFuncSection:Button({Name = "Give 20 Kills Reaper",Side = "Left",Callback = function() 
					for i = 1, 20 do
						game:GetService("ReplicatedStorage"):WaitForChild("HumanoidDied"):FireServer(x,false)
					end
					for i,v in pairs(LocalPlayer.Character:GetChildren()) do
						if v.Name == "DeathMark" then
							game.ReplicatedStorage.ReaperGone:FireServer(v)
							game:GetService("Lighting"):WaitForChild("DeathMarkColorCorrection"):Destroy() 
						end 
					end
				end})
				local AutoTycoon = ExtraFuncSection:Toggle({Name = "Auto Tycoon",Flag = "AutoTycoon",Side = "Left",Value = false,Callback = function(Toggle_Bool)
					getgenv().settings.AutoTycoon = Toggle_Bool
					while getgenv().settings.AutoTycoon do
						for i,v in pairs(workspace:GetDescendants()) do
							if v.Name == "Click" and v:FindFirstChild("ClickDetector") then
								fireclickdetector(v.ClickDetector)
							end
						end
						task.wait()
					end
				end})

				local DestroyTycoon = ExtraFuncSection:Toggle({Name = "Destroy Tycoon",Flag = "DestroyTycoon",Side = "Left",Value = false,Callback = function(Toggle_Bool)
					getgenv().settings.DestroyTycoon = Toggle_Bool			
					while getgenv().settings.DestroyTycoon do
						for i,v in pairs(workspace:GetDescendants()) do
							if v.Name == "Destruct" and v:FindFirstChild("ClickDetector") then
								fireclickdetector(v.ClickDetector)
							end
						end
						task.wait()
					end
				end})

				local SelecArena = ExtraFuncSection:Dropdown({Name = "Select Arena",Flag = "SelecArena",Side = "Left",List = {
					{
						Name = "Default Only",
						Mode = "Button",
						Value = true,
						Callback = function(Selected)
							getgenv().settings.ArenaSelected = "Teleport2"
						end
					},
					{
						Name = "Normal Arena",
						Mode = "Button",
						Value = false,
						Callback = function(Selected)
							getgenv().settings.ArenaSelected = "Teleport1"
						end
					}
				}})

				local Teleports = ExtraFuncSection:Dropdown({Name = "Teleports",Flag = "Teleports",Side = "Left",List = {
					{
						Name = "Safe Spot",
						Mode = "Button",
						Value = false,
						Callback = function(Selected)
							LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Spot.CFrame * CFrame.new(0,40,0)
						end
					},{
						Name = "Normal Arena",
						Mode = "Button",
						Value = false,
						Callback = function(Selected)
							LocalPlayer.Character.HumanoidRootPart.CFrame = game.workspace.Origo.CFrame * CFrame.new(0,-5,0)
						end
					},{
						Name = "Default Arena",
						Mode = "Button",
						Value = false,
						Callback = function(Selected)
							LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(120,360,-3)
						end
					},{
						Name = "Tournament",
						Mode = "Button",
						Value = false,
						Callback = function(Selected)
							LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Battlearena.Arena.CFrame * CFrame.new(0,10,0)
						end
					},{
						Name = "Moai Island",
						Mode = "Button",
						Value = false,
						Callback = function(Selected)
							LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(215, -15.5, 0.5)
						end
					},{
						Name = "Slapple Island",
						Mode = "Button",
						Value = false,
						Callback = function(Selected)
							LocalPlayer.Character.HumanoidRootPart.CFrame = game.workspace.Arena.island5.Union.CFrame * CFrame.new(0,3.25,0)
						end
					},{
						Name = "Plate",
						Mode = "Button",
						Value = false,
						Callback = function(Selected)
							LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Arena.Plate.CFrame * CFrame.new(0,2,0)
						end
					},
				}})

				local AutoEnter = ExtraFuncSection:Toggle({Name = "Auto Enter Arena",Flag = "AutoEnter",Side = "Left",Value = false,Callback = function(Toggle_Bool)
					getgenv().settings.AutoEnter = Toggle_Bool
					while getgenv().settings.AutoEnter do
						if LocalPlayer.Character:FindFirstChild("entered") == nil and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
							firetouchinterest(LocalPlayer.Character:WaitForChild("Head"), workspace.Lobby[getgenv().settings.ArenaSelected], 0)
							firetouchinterest(LocalPlayer.Character:WaitForChild("Head"), workspace.Lobby[getgenv().settings.ArenaSelected], 1)
						end
						task.wait()
					end
				end})

				local InfiniteGolden = ExtraFuncSection:Button({Name = "Infinite Golden",Side = "Left",Callback = function()
					game:GetService("ReplicatedStorage").Goldify:FireServer(true)
				end})

				local RainbowGolden = ExtraFuncSection:Toggle({Name = "Rainbow Golden",Flag = "RainbowGolden",Side = "Left",Value = false,Callback = function(Toggle_Bool)
					getgenv().settings.RainbowGolden = Toggle_Bool
					while getgenv().settings.RainbowGolden do
						for i = 0,1,0.001*25 do
							game:GetService("ReplicatedStorage").Goldify:FireServer(false, BrickColor.new(Color3.fromHSV(i,1,1)))
							task.wait()
						end
					end
				end})

				local InfiniteReverse = ExtraFuncSection:Toggle({Name = "Infinite Reverse",Flag = "InfiniteReverse",Side = "Left",Value = false,Callback = function(Toggle_Bool)
					getgenv().settings.InfiniteReverse = Toggle_Bool
					while getgenv().settings.InfiniteReverse do
						game:GetService("ReplicatedStorage").ReverseAbility:FireServer()
						wait(6)
					end
				end})

				local SelfKnockback = ExtraFuncSection:Toggle({Name = "Self Knockback ( ONLY KINETIC )",Flag = "SelfKnockback",Side = "Left",Value = false,Callback = function(Toggle_Bool)
					getgenv().settings.SelfKnockback = Toggle_Bool
					while getgenv().settings.SelfKnockback do
						if getGlove() == "Kinetic" and LocalPlayer.Character:FindFirstChild("entered") then
							local settings = {
								["Force"] = 0,
								["Direction"] = 0, 0.10000000149011612, 0
							}
							game:GetService("ReplicatedStorage").SelfKnockback:FireServer(settings)
						end
						task.wait()
					end
				end})
			end
		end
		local LocalTab = Window:Tab({Name = "Local"}) do
			local CharacterMovement = LocalTab:Section({Name = "Character Movement",Side = "Left"}) do
				local WalkspeedValue = CharacterMovement:Slider({Name = "Walkspeed Value",Flag = "WalkspeedValue",Side = "Left",Min = 20,Max = 1000,Value = 20,Precise = 0,Unit = "",Callback = function(Value_Number) 
					getgenv().settings.Walkspeed = Value_Number
					LocalPlayer.Character.Humanoid.WalkSpeed = getgenv().settings.Walkspeed
				end})
				local AutomaticWalkspeed = CharacterMovement:Toggle({Name = "Automatic Set Walkspeed",Flag = "AutomaticWalkspeed",Side = "Left",Value = false,Callback = function(Toggle_Bool)
					getgenv().settings.AutoWalkspeed = Toggle_Bool
					if getgenv().settings.AutoWalkspeed == true then
						while getgenv().settings.AutoWalkspeed do
							task.wait()
							local Character = workspace:WaitForChild(LocalPlayer.Name)
							if Character:FindFirstChild("Humanoid") ~= nil and Character.Humanoid.WalkSpeed ~= getgenv().settings.Walkspeed then
								Character:FindFirstChild("Humanoid").WalkSpeed = getgenv().settings.Walkspeed
							end
						end
					end
				end})
				local JumpPowerValue = CharacterMovement:Slider({Name = "JumpPower Value",Flag = "JumpPowerValue",Side = "Left",Min = 50,Max = 1000,Value = 50,Precise = 0,Unit = "",Callback = function(Value_Number) 
					getgenv().settings.JumpPower = Value_Number
					LocalPlayer.Character.Humanoid.JumpPower = getgenv().settings.JumpPower
				end})
				local AutomaticJumpPower = CharacterMovement:Toggle({Name = "Automatic Set JumpPower",Flag = "AutomaticJumpPower",Side = "Left",Value = false,Callback = function(Toggle_Bool)
					getgenv().settings.AutoJumpPower = Toggle_Bool
					if getgenv().settings.AutoJumpPower == true then
						while getgenv().settings.AutoJumpPower do
							task.wait()
							local Character = workspace:WaitForChild(LocalPlayer.Name)
							if Character:FindFirstChild("Humanoid") ~= nil and Character.Humanoid.JumpPower ~= getgenv().settings.JumpPower then
								Character:FindFirstChild("Humanoid").JumpPower = getgenv().settings.JumpPower
							end
						end
					end
				end})

				local HipHeightValue = CharacterMovement:Slider({Name = "HipHeight Value",Flag = "HipHeightValue",Side = "Left",Min = 0,Max = 100,Value = 0,Precise = 0,Unit = "",Callback = function(Value_Number) 
					getgenv().settings.HipHeight = Value_Number
					LocalPlayer.Character.Humanoid.HipHeight = getgenv().settings.HipHeight
				end})
				local AutomaticHipHeight = CharacterMovement:Toggle({Name = "Automatic Set HipHeight",Flag = "AutomaticHipHeight",Side = "Left",Value = false,Callback = function(Toggle_Bool)
					getgenv().settings.AutoHipHeight = Toggle_Bool
					if getgenv().settings.AutoHipHeight == true then
						while getgenv().settings.AutoHipHeight do
							task.wait()
							local Character = workspace:WaitForChild(LocalPlayer.Name)
							if Character:FindFirstChild("Humanoid") ~= nil and Character.Humanoid.HipHeight ~= getgenv().settings.HipHeight then
								Character:FindFirstChild("Humanoid").HipHeight = getgenv().settings.HipHeight
							end
						end
					end
				end})

				local GravityValue = CharacterMovement:Slider({Name = "Gravity Value",Flag = "GravityValue",Side = "Left",Min = 0,Max = 1000,Value = 196.2,Precise = 2,Unit = "",Callback = function(Value_Number) 
					getgenv().settings.Gravity = Value_Number
					game.Workspace.Gravity = getgenv().settings.Gravity
				end})
				local AutomaticGravity = CharacterMovement:Toggle({Name = "Automatic Set Gravity",Flag = "AutomaticGravity",Side = "Left",Value = false,Callback = function(Toggle_Bool)
					getgenv().settings.AutoGravity = Toggle_Bool
					if getgenv().settings.AutoGravity == true then
						while getgenv().settings.AutoGravity do
							task.wait()
							game.Workspace.Gravity = getgenv().settings.Gravity
						end
					end
				end})
			end
			local ESP = LocalTab:Section({Name = "ESP",Side = "Right"}) do
				local ESPE = ESP:Toggle({Name = "Enable ESP",Flag = "ESPE",Side = "Left",Value = false,Callback = function(Toggle_Bool)
					ESPEnabled = Toggle_Bool
					if not ESPEnabled then
						ClearESP()
					end
				end})
				local ShowHe = ESP:Toggle({Name = "Show Health",Flag = "ShowHe",Side = "Left",Value = false,Callback = function(Toggle_Bool)
					ShowHealth = Toggle_Bool
					UpdateESP()
				end})
				local ShowDis = ESP:Toggle({Name = "Show Distance",Flag = "ShowDis",Side = "Left",Value = false,Callback = function(Toggle_Bool)
					ShowDistance = Toggle_Bool
					UpdateESP()
				end})
				local ShowNa = ESP:Toggle({Name = "Show Name",Flag = "ShowNa",Side = "Left",Value = false,Callback = function(Toggle_Bool)
					ShowName = Toggle_Bool
					UpdateESP()
				end})
				local ShowGlo = ESP:Toggle({Name = "Show Glove",Flag = "ShowGlo",Side = "Left",Value = false,Callback = function(Toggle_Bool)
					ShowGlove = Toggle_Bool
					UpdateESP()
				end})
				local ESPBodyColor = ESP:Colorpicker({Name = "Body Color",Flag = "Toggle/BodyC",Value = {1,1,1,0,false},Callback = function(HSVAR_Table,Color3) 
					ESPColor = Color3
				end})
				local ESPTextColor = ESP:Colorpicker({Name = "Text Color",Flag = "Toggle/TextC",Value = {1,1,1,0,false},Callback = function(HSVAR_Table,Color3) 
					ESPTextColor = Color3
				end})
			end
		end
		local BadgeTab = Window:Tab({Name = "Badges"}) do
			local BadgesSection = BadgeTab:Section({Name = "Badges",Side = "Left"}) do

				local GetChain = BadgesSection:Button({Name = "Get Chain",Side = "Left",Callback = function()
					if LocalPlayer.leaderstats.Slaps.Value >= 1000 then
						local teleportFunc = queueonteleport or queue_on_teleport or syn and syn.queue_on_teleport
						if teleportFunc then
							teleportFunc([[
								if not game:IsLoaded() then
									game.Loaded:Wait()
						end
							repeat wait() until LocalPlayer
							repeat wait() until game.Workspace:FindFirstChild("Map"):FindFirstChild("CodeBrick")
							if game.Workspace.Map.CodeBrick.SurfaceGui:FindFirstChild("IMGTemplate") then
							game.Workspace.Map.CodeBrick.SurfaceGui.IMGTemplate.Name = "1st"
							game.Workspace.Map.CodeBrick.SurfaceGui.IMGTemplate.Name = "2nd"
							game.Workspace.Map.CodeBrick.SurfaceGui.IMGTemplate.Name = "3rd"
							game.Workspace.Map.CodeBrick.SurfaceGui.IMGTemplate.Name = "4th"
						end
							for i,v in pairs(game.Workspace.Map.CodeBrick.SurfaceGui:GetChildren()) do
							if v.Name == "1st" then
								if v.Image == "http://www.roblox.com/asset/?id=9648769161" then
									first = "4"
									elseif v.Image == "http://www.roblox.com/asset/?id=9648765536" then
									first = "2"
									elseif v.Image == "http://www.roblox.com/asset/?id=9648762863" then
									first = "3"
									elseif v.Image == "http://www.roblox.com/asset/?id=9648759883" then
									first = "9"
									elseif v.Image == "http://www.roblox.com/asset/?id=9648755440" then
									first = "8"
									elseif v.Image == "http://www.roblox.com/asset/?id=9648752438" then
									first = "2"
									elseif v.Image == "http://www.roblox.com/asset/?id=9648749145" then
									first = "8"
									elseif v.Image == "http://www.roblox.com/asset/?id=9648745618" then
									first = "3"
									elseif v.Image == "http://www.roblox.com/asset/?id=9648742013" then
									first = "7"
									elseif v.Image == "http://www.roblox.com/asset/?id=9648738553" then
									first = "8"
									elseif v.Image == "http://www.roblox.com/asset/?id=9648734698" then
									first = "2"
									elseif v.Image == "http://www.roblox.com/asset/?id=9648730082" then
									first = "6"
									elseif v.Image == "http://www.roblox.com/asset/?id=9648723237" then
									first = "3"
									elseif v.Image == "http://www.roblox.com/asset/?id=9648718450" then
									first = "6"
									elseif v.Image == "http://www.roblox.com/asset/?id=9648715920" then
									first = "6"
									elseif v.Image == "http://www.roblox.com/asset/?id=9648712563" then
									first = "2"
								end
							end
						end
							for i,v in pairs(game.Workspace.Map.CodeBrick.SurfaceGui:GetChildren()) do
							if v.Name == "2nd" then
								if v.Image == "http://www.roblox.com/asset/?id=9648769161" then
									second = "4"
									elseif v.Image == "http://www.roblox.com/asset/?id=9648765536" then
									second = "2"
									elseif v.Image == "http://www.roblox.com/asset/?id=9648762863" then
									second = "3"
									elseif v.Image == "http://www.roblox.com/asset/?id=9648759883" then
									second = "9"
									elseif v.Image == "http://www.roblox.com/asset/?id=9648755440" then
									second = "8"
									elseif v.Image == "http://www.roblox.com/asset/?id=9648752438" then
									second = "2"
									elseif v.Image == "http://www.roblox.com/asset/?id=9648749145" then
									second = "8"
									elseif v.Image == "http://www.roblox.com/asset/?id=9648745618" then
									second = "3"
									elseif v.Image == "http://www.roblox.com/asset/?id=9648742013" then
									second = "7"
									elseif v.Image == "http://www.roblox.com/asset/?id=9648738553" then
									second = "8"
									elseif v.Image == "http://www.roblox.com/asset/?id=9648734698" then
									second = "2"
									elseif v.Image == "http://www.roblox.com/asset/?id=9648730082" then
									second = "6"
									elseif v.Image == "http://www.roblox.com/asset/?id=9648723237" then
									second = "3"
									elseif v.Image == "http://www.roblox.com/asset/?id=9648718450" then
									second = "6"
									elseif v.Image == "http://www.roblox.com/asset/?id=9648715920" then
									second = "6"
									elseif v.Image == "http://www.roblox.com/asset/?id=9648712563" then
									second = "2"
								end
							end
						end
							for i,v in pairs(game.Workspace.Map.CodeBrick.SurfaceGui:GetChildren()) do
							if v.Name == "3rd" then
								if v.Image == "http://www.roblox.com/asset/?id=9648769161" then
									third = "4"
									elseif v.Image == "http://www.roblox.com/asset/?id=9648765536" then
									third = "2"
									elseif v.Image == "http://www.roblox.com/asset/?id=9648762863" then
									third = "3"
									elseif v.Image == "http://www.roblox.com/asset/?id=9648759883" then
									third = "9"
									elseif v.Image == "http://www.roblox.com/asset/?id=9648755440" then
									third = "8"
									elseif v.Image == "http://www.roblox.com/asset/?id=9648752438" then
									third = "2"
									elseif v.Image == "http://www.roblox.com/asset/?id=9648749145" then
									third = "8"
									elseif v.Image == "http://www.roblox.com/asset/?id=9648745618" then
									third = "3"
									elseif v.Image == "http://www.roblox.com/asset/?id=9648742013" then
									third = "7"
									elseif v.Image == "http://www.roblox.com/asset/?id=9648738553" then
									third = "8"
									elseif v.Image == "http://www.roblox.com/asset/?id=9648734698" then
									third = "2"
									elseif v.Image == "http://www.roblox.com/asset/?id=9648730082" then
									third = "6"
									elseif v.Image == "http://www.roblox.com/asset/?id=9648723237" then
									third = "3"
									elseif v.Image == "http://www.roblox.com/asset/?id=9648718450" then
									third = "6"
									elseif v.Image == "http://www.roblox.com/asset/?id=9648715920" then
									third = "6"
									elseif v.Image == "http://www.roblox.com/asset/?id=9648712563" then
									third = "2"
								end
							end
						end
							for i,v in pairs(game.Workspace.Map.CodeBrick.SurfaceGui:GetChildren()) do
							if v.Name == "4th" then
								if v.Image == "http://www.roblox.com/asset/?id=9648769161" then
									fourth = "4"
									elseif v.Image == "http://www.roblox.com/asset/?id=9648765536" then
									fourth = "2"
									elseif v.Image == "http://www.roblox.com/asset/?id=9648762863" then
									fourth = "3"
									elseif v.Image == "http://www.roblox.com/asset/?id=9648759883" then
									fourth = "9"
									elseif v.Image == "http://www.roblox.com/asset/?id=9648755440" then
									fourth = "8"
									elseif v.Image == "http://www.roblox.com/asset/?id=9648752438" then
									fourth = "2"
									elseif v.Image == "http://www.roblox.com/asset/?id=9648749145" then
									fourth = "8"
									elseif v.Image == "http://www.roblox.com/asset/?id=9648745618" then
									fourth = "3"
									elseif v.Image == "http://www.roblox.com/asset/?id=9648742013" then
									fourth = "7"
									elseif v.Image == "http://www.roblox.com/asset/?id=9648738553" then
									fourth = "8"
									elseif v.Image == "http://www.roblox.com/asset/?id=9648734698" then
									fourth = "2"
									elseif v.Image == "http://www.roblox.com/asset/?id=9648730082" then
									fourth = "6"
									elseif v.Image == "http://www.roblox.com/asset/?id=9648723237" then
									fourth = "3"
									elseif v.Image == "http://www.roblox.com/asset/?id=9648718450" then
									fourth = "6"
									elseif v.Image == "http://www.roblox.com/asset/?id=9648715920" then
									fourth = "6"
									elseif v.Image == "http://www.roblox.com/asset/?id=9648712563" then
									fourth = "2"
								end
							end
						end
							fireclickdetector(game.Workspace.Map.OriginOffice.Door.Keypad.Buttons.Reset.ClickDetector)
							wait(0.25)
							fireclickdetector(game.Workspace.Map.OriginOffice.Door.Keypad.Buttons[first].ClickDetector)
							wait(0.25)
							fireclickdetector(game.Workspace.Map.OriginOffice.Door.Keypad.Buttons[second].ClickDetector)
							wait(0.25)
							fireclickdetector(game.Workspace.Map.OriginOffice.Door.Keypad.Buttons[third].ClickDetector)
							wait(0.25)
							fireclickdetector(game.Workspace.Map.OriginOffice.Door.Keypad.Buttons[fourth].ClickDetector)
							wait(0.25)
							fireclickdetector(game.Workspace.Map.OriginOffice.Door.Keypad.Buttons.Enter.ClickDetector)
							game:GetService("TeleportService"):Teleport(6403373529)
							]])
						end
						game:GetService("TeleportService"):Teleport(9431156611)
					else
						Bracket:Notification({Title = "Error",Description = "You don't have 1000 slaps",Duration = 5})
					end
				end})
				local GetTycoon = BadgesSection:Button({Name = "Get Tycoon",Side = "Left",Callback = function()
					if #game:GetService("Players"):GetPlayers() >= 7 then
						repeat task.wait()
							LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Arena.Plate.CFrame * CFrame.new(0,-1.5,0) * CFrame.Angles(math.rad(90), math.rad(0), math.rad(0))
						until LocalPlayer.PlayerGui.PlateIndicator.TextLabel.Text == "Plate Counter: 600"
					else
						Bracket:Notification({Title = "Error",Description = "This server does not have 7 players",Duration = 5})
					end


				end})

				local GetKinetic = BadgesSection:Button({Name = "Get Kinetic",Side = "Left",Callback = function()
					if getGlove() == "Stun" then
						OGL = LocalPlayer.Character.HumanoidRootPart.CFrame
						for i = 1,100 do
							game.ReplicatedStorage.SelfKnockback:FireServer({["Force"] = 0,["Direction"] = Vector3.new(0,0.01,0)})
							wait(0.05)
						end
						wait(1.5)
						repeat
							local players = game.Players:GetChildren()
							local RandomPlayer = players[math.random(1, #players)]
							repeat RandomPlayer = players[math.random(1, #players)] until RandomPlayer ~= LocalPlayer
							repeat RandomPlayer = players[math.random(1, #players)] until RandomPlayer.Character:FindFirstChild("entered") and RandomPlayer.Character:FindFirstChild("rock") == nil and RandomPlayer.Character.Head:FindFirstChild("UnoReverseCard") == nil
							Target = RandomPlayer
							LocalPlayer.Character.HumanoidRootPart.CFrame = Target.Character.HumanoidRootPart.CFrame * CFrame.new(0,-20,0)
							wait(0.25)
							game.ReplicatedStorage.StunR:FireServer(LocalPlayer.Character.Stun)
							LocalPlayer.Character.HumanoidRootPart.CFrame = OGL
							wait(10.3)
						until LocalPlayer.Character:FindFirstChild("EMPStunBadgeCounter") and LocalPlayer.Character.EMPStunBadgeCounter.Value >= 50
					else
						Bracket:Notification({Title = "Error",Description = "You dont have Stun equipped",Duration = 5})
					end 
				end})

				local GetRedacted = BadgesSection:Button({Name = "Get Redacted",Side = "Left",Callback = function()
					if LocalPlayer.leaderstats.Slaps.Value >= 5000 then
						Door = 0
						for i = 1, 10 do
							Door = Door + 1
							if game:GetService("BadgeService"):UserHasBadgeAsync(LocalPlayer.UserId, 2124847850) then
							else
								firetouchinterest(LocalPlayer.Character:WaitForChild("Head"), workspace.PocketDimension.Doors[Door].TouchInterest.Parent, 0)
								firetouchinterest(LocalPlayer.Character:WaitForChild("Head"), workspace.PocketDimension.Doors[Door].TouchInterest.Parent, 1)
								wait(4)
							end
						end
					else
						Bracket:Notification({Title = "Error",Description = "You don't have 5000 slaps",Duration = 5})
					end
				end})

				local GetcourtevidenceBadge = BadgesSection:Button({Name = "Get 'court evidence' Badge",Side = "Left",Callback = function()
					if not game:GetService("BadgeService"):UserHasBadgeAsync(LocalPlayer.UserId, 2124760907) then
						fireclickdetector(game.Workspace.Lobby.Scene.knofe.ClickDetector)
					else
						Bracket:Notification({Title = "Error",Description = "You already own this badge",Duration = 5})
					end
				end})

				local GetduckBadge = BadgesSection:Button({Name = "Get 'duck' Badge",Side = "Left",Callback = function()
					if not game:GetService("BadgeService"):UserHasBadgeAsync(LocalPlayer.UserId, 2124760916) then
						fireclickdetector(game.Workspace.Arena["default island"]["Rubber Ducky"].ClickDetector)
					else
						Bracket:Notification({Title = "Error",Description = "You already own this badge",Duration = 5})
					end
				end})

				local GetBrazilBadge = BadgesSection:Button({Name = "Get 'Brazil' Badge",Side = "Left",Callback = function()
					if not game:GetService("BadgeService"):UserHasBadgeAsync(LocalPlayer.UserId, 2124775097) then
						LocalPlayer.Character.HumanoidRootPart.CFrame = game.workspace.Lobby.brazil.portal.CFrame
					else
						Bracket:Notification({Title = "Error",Description = "You already own this badge",Duration = 5})
					end
				end})

				local GetTheLoneOrangeBadge = BadgesSection:Button({Name = "Get 'The Lone Orange' Badge",Side = "Left",Callback = function()
					if not game:GetService("BadgeService"):UserHasBadgeAsync(LocalPlayer.UserId, 2128220957) then
						fireclickdetector(game.Workspace.Arena.island5.Orange.ClickDetector)
					else
						Bracket:Notification({Title = "Error",Description = "You already own this badge",Duration = 5})
					end
				end})

				local AutoGetJetOrb = BadgesSection:Toggle({Name = "AutoGet Jet Orb",Flag = "AutoGetJetOrb",Side = "Left",Value = false,Callback = function(Toggle_Bool)
					getgenv().settings.GetJetOrb = Toggle_Bool
					while getgenv().settings.GetJetOrb do
						for i,v in pairs(game.Workspace:GetChildren()) do
							if v.Name == "JetOrb" and v:FindFirstChild("TouchInterest") then
								firetouchinterest(LocalPlayer.Character:WaitForChild("Head"), v, 0)
								firetouchinterest(LocalPlayer.Character:WaitForChild("Head"), v, 1)
							end
						end
						task.wait()
					end
				end})

				local AutoGetPhaseOrb = BadgesSection:Toggle({Name = "AutoGet Phase Orb",Flag = "AutoGetPhaseOrb",Side = "Left",Value = false,Callback = function(Toggle_Bool)
					getgenv().settings.GetPhaseOrb = Toggle_Bool
					while getgenv().settings.GetPhaseOrb do
						for i,v in pairs(game.Workspace:GetChildren()) do
							if v.Name == "PhaseOrb" and v:FindFirstChild("TouchInterest") then
								firetouchinterest(LocalPlayer.Character:WaitForChild("Head"), v, 0)
								firetouchinterest(LocalPlayer.Character:WaitForChild("Head"), v, 1)
							end
						end
						task.wait()
					end
				end})

			end
		end
	end
	print(getGlove())
	game:GetService("RunService").RenderStepped:Connect(function()
		if game.PlaceId ~= 9431156611 and game:GetService("Players").LocalPlayer ~= nil and getTool() ~= nil and game:GetService("Players").LocalPlayer.Character:FindFirstChild("entered") ~= nil or game.PlaceId == 9431156611 and game:GetService("Players").LocalPlayer ~= nil and getTool() ~= nil and game:GetService("Players").LocalPlayer.Character:FindFirstChild("inMatch").Value then
			if getgenv().settings.GloveExtend and getgenv().settings.ExtendOption == "Meat Stick" and getTool():FindFirstChild("Glove").Size ~= Vector3.new(0, 25, 2) then
				getTool().Glove.Transparency = 0.5
				getTool().Glove.Size = Vector3.new(0, 25, 2)
			elseif getgenv().settings.GloveExtend and getgenv().settings.ExtendOption == "Pancake" and getTool():FindFirstChild("Glove").Size ~= Vector3.new(0, 25, 25) then
				getTool().Glove.Transparency = 0.5
				getTool().Glove.Size = Vector3.new(0, 25, 25)
			elseif getgenv().settings.GloveExtend and getgenv().settings.ExtendOption == "Growth" and getTool():FindFirstChild("Glove").Size ~= Vector3.new(25, 25, 25) then
				getTool().Glove.Transparency = 0.5
				getTool().Glove.Size = Vector3.new(25, 25, 25)
			elseif getgenv().settings.GloveExtend and getgenv().settings.ExtendOption == "North Korea Wall" and getTool():FindFirstChild("Glove").Size ~= Vector3.new(0, 3.5, 2) then
				getTool().Glove.Transparency = 0.5
				getTool().Glove.Size = Vector3.new(45, 0, 45)
			elseif getgenv().settings.GloveExtend and getgenv().settings.ExtendOption == "Slight Extend" and getTool():FindFirstChild("Glove").Size ~= Vector3.new(0, 3.5, 2) then
				getTool().Glove.Transparency = 0
				getTool().Glove.Size = Vector3.new(3, 3, 3.7)
			elseif getgenv().settings.GloveExtend == false then
				getTool().Glove.Transparency = 0
				getTool().Glove.Size = Vector3.new(2.5, 2.5, 1.7)
			end
		end
	end)
end
