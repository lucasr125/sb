if not game:IsLoaded() then
  game.Loaded:Wait()
end

game:GetService("GuiService"):ClearError()

if game.PlaceId == 6403373529 or game.PlaceId == 9015014224 then
  local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/lucasr125/Orion/main/source')))()
  local Window = OrionLib:MakeWindow({Name = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name.." Script" or "Slap Battles Script", HidePremium = false, SaveConfig = false, IntroEnabled = false, ConfigFolder = "SB"})

  -- Bypass
  local Namecall
  Namecall = hookmetamethod(game, '__namecall', function(self, ...)
      if getnamecallmethod() == 'FireServer' and tostring(self) == 'Ban' then
        return
      elseif getnamecallmethod() == 'FireServer' and tostring(self) == 'WalkSpeedChanged' then
        return
      elseif getnamecallmethod() == 'FireServer' and tostring(self) == 'AdminGUI' then
        return
      end
      return Namecall(self, ...)
    end)

  -- Player
  local Player = game.Players.LocalPlayer.Character.Name
  if setfpscap then
    setfpscap(12569)
  end

  local Gloves = loadstring(game:HttpGet("https://raw.githubusercontent.com/lucasr125/sb/main/GlovesSB"))()
  local Beds = loadstring(game:HttpGet("https://raw.githubusercontent.com/Giangplay/slap-battles/main/File/Bed.lua"))()

  local function getGlove()
    return game.Players.LocalPlayer.leaderstats.Glove.Value
  end

  local function getTool()
    local tool = game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Tool") or game:GetService("Players").LocalPlayer:WaitForChild("Backpack"):FindFirstChildOfClass("Tool")
    if tool ~= nil and tool:FindFirstChild("Glove") ~= nil then
      return tool
    end
  end

  local GloveExtend = false
  local ExtendOption = "Pancake"
  local AutoClick = false
  
  shared.createBed()

  -- Anti Voids
  local SafeSpot = Instance.new("Part", workspace)
  SafeSpot.Position = Vector3.new(-1500,100,-1500)
  SafeSpot.Name = "Spot"
  SafeSpot.Size = Vector3.new(100,1,100)
  SafeSpot.Anchored = true
  SafeSpot.Transparency = .7

  local AntiVoid = Instance.new("Part", workspace)
  AntiVoid.Name = "AntiVoid"
  AntiVoid.Size = Vector3.new(2047, 0.009, 2019)
  AntiVoid.Position = Vector3.new(-80.5, -10.005, -246.5)
  AntiVoid.CanCollide = false
  AntiVoid.Anchored = true
  AntiVoid.Transparency = 1

  local arenaVoid = Instance.new("Part", workspace)
  arenaVoid.Name = "arenaVoid"
  arenaVoid.Size = Vector3.new(798, 1, 1290)
  arenaVoid.Position = Vector3.new(3450, 59.009, 68)
  arenaVoid.CanCollide = false
  arenaVoid.Anchored = true
  arenaVoid.Transparency = 1

  -- Anti Obby ( NOT WORKING )
  function disable(username, cantouch)
    print(username)
    if workspace:FindFirstChild("ObbyItem"..username.."LavaBlock") then
      print("ObbyItem"..username.."LavaBlock")
      workspace:FindFirstChild("ObbyItem"..username.."LavaBlock").CanTouch = cantouch
    elseif workspace:FindFirstChild("ObbyItem"..username.."LavaSpinner") then
      print("ObbyItem"..username.."LavaSpinner")
      workspace:FindFirstChild("ObbyItem"..username.."LavaSpinner").CanTouch = cantouch
    end
  end

  OrionLib:MakeNotification({Name = "Version",Content = "1.0.8",Image = "rbxassetid://7733956210",Time = 5})
  wait(.5)
  OrionLib:MakeNotification({Name = "Slap Battles Script",Content = "ID: "..game.PlaceId,Time = 5})
  wait(.5)
  OrionLib:MakeNotification({Name = "Loading...",Content = "Loading script...",Time = 5})
  wait(.25)
  local MainTab = Window:MakeTab({Name = "Main",Icon = "rbxassetid://4483345998",PremiumOnly = false})
  local AntiTab = Window:MakeTab({Name = "Antis",Icon = "rbxassetid://4483345998",PremiumOnly = false})
  local BadgesTab = Window:MakeTab({Name = "Badges",Icon = "rbxassetid://4483345998",PremiumOnly = false})
  local LocalTab = Window:MakeTab({Name = "Local",Icon = "rbxassetid://4483345998",PremiumOnly = false})
  local TelepTab = Window:MakeTab({Name = "Teleports",Icon = "rbxassetid://4483345998",PremiumOnly = false})
  local Tab11 = Window:MakeTab({Name = "Misc",Icon = "rbxassetid://4483345998",PremiumOnly = false})
  local Tab12 = Window:MakeTab({Name = "Game",Icon = "rbxassetid://4483345998",PremiumOnly = false})
  local Tab18 = Window:MakeTab({Name = "AutoEquip Glove",Icon = "rbxassetid://4483345998",PremiumOnly = false})
  local Tab13 = Window:MakeTab({Name = "AutoFarm Slap",Icon = "rbxassetid://4483345998",PremiumOnly = false})
  local Tab14 = Window:MakeTab({Name = "Troll Server",Icon = "rbxassetid://4483345998",PremiumOnly = false})
  local Tab21 = Window:MakeTab({Name = "Teleport Player",Icon = "rbxassetid://4483345998",PremiumOnly = false})
  local Tab15 = Window:MakeTab({Name = "Ability Spams",Icon = "rbxassetid://4483345998",PremiumOnly = false})
  local Tab16 = Window:MakeTab({Name = "Games",Icon = "rbxassetid://4483345998",PremiumOnly = false})

  local Section = MainTab:AddSection({Name = "Main"})

  MainTab:AddToggle({Name = "AutoFarm Slapples",Default = false,Callback = function(Value)
        _G.SlappleFarm = Value
        while _G.SlappleFarm do
          task.wait()
          spawn(function()
              for i, v in pairs(game:GetService("Workspace").Arena.island5.Slapples:GetDescendants()) do
                if v:IsA("TouchTransmitter") then
                  firetouchinterest(game.Players.LocalPlayer.Character.Head, v.Parent, 0)
                  task.wait()
                  firetouchinterest(game.Players.LocalPlayer.Character.Head, v.Parent, 1)
                end
              end
            end)
        end
      end})

  MainTab:AddToggle({Name = "AutoFarm Candy",Default = false,Callback = function(Value)
        _G.CandyFarm = Value
        while _G.CandyFarm do
          task.wait()
          spawn(function()
              for i,v in pairs(game:GetService("Workspace").CandyCorns:GetDescendants()) do
                if v.Name == ("TouchInterest") and v.Parent then
                  firetouchinterest(game.Players.LocalPlayer.Character.Head, v.Parent, 0)
                  task.wait()
                  firetouchinterest(game.Players.LocalPlayer.Character.Head, v.Parent, 1)
                end
              end
            end)
        end
      end})

  MainTab:AddToggle({Name = "AutoSlap Baller [ Equip Baller ]",Default = false,Callback = function(Value)
        _G.BallerFarm = Value
        while _G.BallerFarm do
          task.wait()
          for _, v in ipairs(workspace:GetChildren()) do
            if string.sub(v.Name, 3, 8) == "Baller" then
              game:GetService("ReplicatedStorage").GeneralHit:FireServer(v:WaitForChild("HumanoidRootPart"))
            end
          end
        end
      end})

  MainTab:AddToggle({Name = "AutoSlap Replica [ Enter Default Arena ]",Default = false,Callback = function(Value)
        _G.SlapReplica = Value
        while _G.SlapReplica do
          task.wait()
          for _, replica in pairs(workspace:GetChildren()) do
            if string.find(replica.Name, "Å") then
              game:GetService("ReplicatedStorage").b:FireServer(replica:WaitForChild("HumanoidRootPart"))
            end
          end
        end
      end})

  MainTab:AddButton({Name = "Script All Animations [ /e emotename ]",Callback = function()
        Floss = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(game.ReplicatedStorage.AnimationPack.Floss, game.Players.LocalPlayer.Character.Humanoid)
        Groove = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(game.ReplicatedStorage.AnimationPack.Groove, game.Players.LocalPlayer.Character.Humanoid)
        Headless = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(game.ReplicatedStorage.AnimationPack.Headless, game.Players.LocalPlayer.Character.Humanoid)
        Helicopter = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(game.ReplicatedStorage.AnimationPack.Helicopter, game.Players.LocalPlayer.Character.Humanoid)
        Kick = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(game.ReplicatedStorage.AnimationPack.Kick, game.Players.LocalPlayer.Character.Humanoid)
        L = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(game.ReplicatedStorage.AnimationPack.L, game.Players.LocalPlayer.Character.Humanoid)
        Laugh = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(game.ReplicatedStorage.AnimationPack.Laugh, game.Players.LocalPlayer.Character.Humanoid)
        Parker = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(game.ReplicatedStorage.AnimationPack.Parker, game.Players.LocalPlayer.Character.Humanoid)
        Spasm = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(game.ReplicatedStorage.AnimationPack.Spasm, game.Players.LocalPlayer.Character.Humanoid)
        Thriller = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(game.ReplicatedStorage.AnimationPack.Thriller, game.Players.LocalPlayer.Character.Humanoid)
        game.Players.LocalPlayer.Chatted:connect(function(msg)
            if game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
              Floss = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(game.ReplicatedStorage.AnimationPack.Floss, game.Players.LocalPlayer.Character.Humanoid)
              Groove = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(game.ReplicatedStorage.AnimationPack.Groove, game.Players.LocalPlayer.Character.Humanoid)
              Headless = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(game.ReplicatedStorage.AnimationPack.Headless, game.Players.LocalPlayer.Character.Humanoid)
              Helicopter = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(game.ReplicatedStorage.AnimationPack.Helicopter, game.Players.LocalPlayer.Character.Humanoid)
              Kick = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(game.ReplicatedStorage.AnimationPack.Kick, game.Players.LocalPlayer.Character.Humanoid)
              L = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(game.ReplicatedStorage.AnimationPack.L, game.Players.LocalPlayer.Character.Humanoid)
              Laugh = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(game.ReplicatedStorage.AnimationPack.Laugh, game.Players.LocalPlayer.Character.Humanoid)
              Parker = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(game.ReplicatedStorage.AnimationPack.Parker, game.Players.LocalPlayer.Character.Humanoid)
              Spasm = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(game.ReplicatedStorage.AnimationPack.Spasm, game.Players.LocalPlayer.Character.Humanoid)
              Thriller = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(game.ReplicatedStorage.AnimationPack.Thriller, game.Players.LocalPlayer.Character.Humanoid)
              if string.lower(msg) == "/e Floss" or string.lower(msg) == "/e floss" then
                Floss:Play()
              elseif string.lower(msg) == "/e Groove" or string.lower(msg) == "/e groove" then
                Groove:Play()
              elseif string.lower(msg) == "/e Headless" or string.lower(msg) == "/e headless" then
                Headless:Play()
              elseif string.lower(msg) == "/e Helicopter" or string.lower(msg) == "/e helicopter" then
                Helicopter:Play()
              elseif string.lower(msg) == "/e Kick" or string.lower(msg) == "/e kick" then
                Kick:Play()
              elseif string.lower(msg) == "/e L" or string.lower(msg) == "/e l" then
                L:Play()
              elseif string.lower(msg) == "/e Laugh" or string.lower(msg) == "/e laugh" then
                Laugh:Play()
              elseif string.lower(msg) == "/e Parker" or string.lower(msg) == "/e parker" then
                Parker:Play()
              elseif string.lower(msg) == "/e Spasm" or string.lower(msg) == "/e spasm" then
                Spasm:Play()
              elseif string.lower(msg) == "/e Thriller" or string.lower(msg) == "/e thriller" then
                Thriller:Play()
              end
              EP = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
            end
          end)
        game:GetService("RunService").Heartbeat:Connect(function()
            if EP ~= nil and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and Floss.IsPlaying or Groove.IsPlaying or Headless.IsPlaying or Helicopter.IsPlaying or Kick.IsPlaying or L.IsPlaying or Laugh.IsPlaying or Parker.IsPlaying or Spasm.IsPlaying or Thriller.IsPlaying then
              Magnitude = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - EP).Magnitude
              if Magnitude > 1 then
                Floss:Stop(); Groove:Stop(); Headless:Stop(); Helicopter:Stop(); Kick:Stop(); L:Stop(); Laugh:Stop(); Parker:Stop(); Spasm:Stop(); Thriller:Stop()
              end
            end
          end)
      end})
  
  MainTab:AddButton({Name = "Rejoin",Callback = function()
        game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, game.Players.LocalPlayer)
      end})

  MainTab:AddButton({Name = "Infinite Yield",Callback = function()
        loadstring(game:HttpGet(('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'),true))()
      end})

  MainTab:AddButton({Name = "Simple Spy",Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/exxtremestuffs/SimpleSpySource/master/SimpleSpy.lua", true))()
      end})

  MainTab:AddButton({Name = "Destroy GUI",Callback = function()
        OrionLib:Destroy()
      end})

  AntiTab:AddToggle({Name = "AntiVoid Tournament",Default = false,Callback = function(state)
        if state then
          arenaVoid.CanCollide = true
          arenaVoid.Anchored = true
          arenaVoid.Transparency = 0.5
        else
          arenaVoid.CanCollide = false
          arenaVoid.Anchored = true
          arenaVoid.Transparency = 1
        end
      end})
  
  AntiTab:AddToggle({Name = "Arena Anti-Void",Default = false,Callback = function(state)
        if state then
          AntiVoid.CanCollide = true
          AntiVoid.Anchored = true
          AntiVoid.Transparency = 0.5
        else
          AntiVoid.CanCollide = false
          AntiVoid.Anchored = true
          AntiVoid.Transparency = 1
        end
      end})

  AntiTab:AddToggle({Name = "Anti Void",Default = false,Callback = function(Value)
        if Value == true then
          for i,v in pairs(game.Workspace:GetDescendants()) do
            if v.Name == "dedBarrier"  or v.Name == "ArenaBarrier" or v.Name == "DEATHBARRIER" or v.Name == "DEATHBARRIER2" then
              if v.CanCollide == false then
                v.CanCollide = true
                v.Material = "ForceField"
                v.Color = Color3.new(255,255,255)
                v.Transparency = .9
              end
            end
          end
        else
          for i,v in pairs(game.Workspace:GetDescendants()) do
            if v.Name == "dedBarrier"  or v.Name == "ArenaBarrier" or v.Name == "DEATHBARRIER" or v.Name == "DEATHBARRIER2" then
              if v.CanCollide == true then
                v.CanCollide = false
                v.Transparency = 1
              end
            end
          end
        end
      end})

  BadgesTab:AddToggle({Name = "AutoGet Jet Orb [ 10% to Spawn ]",Default = false,Callback = function(Value)
        _G.GetJetOrb = Value
        while _G.GetJetOrb do
          for _, v in pairs(workspace:GetChildren()) do
            if v.Name == "JetOrb" then
              v.Position = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
            end
          end
          task.wait()
        end
      end})

  BadgesTab:AddToggle({Name = "AutoGet Phase Orb [ 5% to Spawn ]",Default = false,Callback = function(Value)
        _G.GetPhaseOrb = Value
        while _G.GetPhaseOrb do
          for _, v in pairs(workspace:GetChildren()) do
            if v.Name == "PhaseOrb" then
              v.Position = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
            end
          end
          task.wait()
        end
      end})

  BadgesTab:AddButton({Name = "Auto Keypad",Callback = function()
        if not workspace:FindFirstChild("Keypad") then
          for _, server in ipairs(game.HttpService:JSONDecode(game:HttpGetAsync("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100")).data) do
            if server.playing < server.maxPlayers and server.JobId ~= game.JobId then
              wait(2.5)
              game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, server.id)
            end
          end
        else
          pcall(function()
              repeat task.wait()
                firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, workspace.Lobby.Teleport1, 0)
                firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, workspace.Lobby.Teleport1, 1)
              until game.Players.LocalPlayer.Character:FindFirstChild("entered") ~= nil
            end)
          fireclickdetector(workspace:WaitForChild("Keypad").Buttons:FindFirstChild("Reset").ClickDetector)
          local digits = tostring((#game.Players:GetPlayers() * 25) + 1100 - 7)
          for i = 1, #digits do
            wait(.5)
            local digit = digits:sub(i, i)
            fireclickdetector(workspace:WaitForChild("Keypad").Buttons:FindFirstChild(digit).ClickDetector)
          end
          game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Keypad.Buttons.Enter.CFrame
          wait(1)
          fireclickdetector(workspace:WaitForChild("Keypad").Buttons:FindFirstChild("Enter").ClickDetector)
          wait(1)
          fireclickdetector(workspace:WaitForChild("Keypad").Buttons:FindFirstChild("Reset").ClickDetector)
          local digits = tostring((#game.Players:GetPlayers() * 25) + 1100 - 7)
          for i = 1, #digits do
            wait(.5)
            local digit = digits:sub(i, i)
            fireclickdetector(workspace:WaitForChild("Keypad").Buttons:FindFirstChild(digit).ClickDetector)
          end
          game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Keypad.Buttons.Enter.CFrame
          wait(1)
          fireclickdetector(workspace:WaitForChild("Keypad").Buttons:FindFirstChild("Enter").ClickDetector)
        end
      end})

  BadgesTab:AddButton({Name = "Elude Maze Code",Callback = function()
        if not workspace:FindFirstChild("Keypad") then
          OrionLib:MakeNotification({Name = "Error",Content = "Could not find keypad!",Image = "rbxassetid://7743878496",Time = 5})
        end
        wait(0.5)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Keypad.Buttons.Enter.CFrame
        task.wait(0.1)
        print(#game.Players:GetPlayers() * 25 + 1100 - 7)
        OrionLib:MakeNotification({Name = "Code",Content = #game.Players:GetPlayers() * 25 + 1100 - 7,Image = "rbxassetid://7733777166",Time = 5})
      end})

  BadgesTab:AddButton({Name = "TP To SafeSpot",Callback = function()
        if workspace[game.Players.LocalPlayer.Name]:FindFirstChild("entered") then
          game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Spot.CFrame * CFrame.new(0,50,0)
        else
          OrionLib:MakeNotification({Name = "Error",Content = "You need join in arena.",Image = "rbxassetid://7743878496",Time = 5})
        end
      end})

  BadgesTab:AddButton({Name = "TP To Bed",Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace["Bed"].Bed3.CFrame * CFrame.new(0,0,-1)
      end})

  BadgesTab:AddButton({Name = "Get Chain [ Requires 1k Slaps ]",Callback = function()
        if game.Players.LocalPlayer.leaderstats.Slaps.Value >= 1000 then
          local teleportFunc = queueonteleport or queue_on_teleport or syn and syn.queue_on_teleport
          if teleportFunc then
            teleportFunc([[
              if not game:IsLoaded() then
              game.Loaded:Wait()
            end
              repeat wait() until game.Players.LocalPlayer
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
              game:GetService("TeleportService"):Teleport(6403373529)]])
          end
          game:GetService("TeleportService"):Teleport(9431156611)
        end
      end})

  BadgesTab:AddButton({Name = "Get [REDACTED] [ Requires 5k Slaps ]",Callback = function()
        if game.Players.LocalPlayer.leaderstats.Slaps.Value >= 5000 then
          Door = 0
          for i = 1, 10 do
            Door = Door + 1
            if game:GetService("BadgeService"):UserHasBadgeAsync(game.Players.LocalPlayer.UserId, 2124847850) then
              OrionLib:MakeNotification({Name = "Error",Content = "You already have the badge!",Image = "rbxassetid://7743878496",Time = 5})
            else
              firetouchinterest(game.Players.LocalPlayer.Character:WaitForChild("Head"), workspace.PocketDimension.Doors[Door].TouchInterest.Parent, 0)
              firetouchinterest(game.Players.LocalPlayer.Character:WaitForChild("Head"), workspace.PocketDimension.Doors[Door].TouchInterest.Parent, 1)
              wait(4)
            end
          end
        else
          OrionLib:MakeNotification({Name = "Error",Content = "You need 5k Slaps",Image = "rbxassetid://7743878496",Time = 5})
        end
      end})

  BadgesTab:AddButton({Name = "Get Duck Badge",Callback = function()
        if not game:GetService("BadgeService"):UserHasBadgeAsync(game.Players.LocalPlayer.UserId, 2124760916) then
          fireclickdetector(game.Workspace.Arena["default island"]["Rubber Ducky"].ClickDetector)
        else
          OrionLib:MakeNotification({Name = "Error",Content = "You already have the badge!",Image = "rbxassetid://7743878496",Time = 5})
        end
      end})

  BadgesTab:AddButton({Name = "Get Orange Badge",Callback = function()
        if not game:GetService("BadgeService"):UserHasBadgeAsync(game.Players.LocalPlayer.UserId, 2128220957) then
          fireclickdetector(game.Workspace.Arena.island5.Orange.ClickDetector)
        else
          OrionLib:MakeNotification({Name = "Error",Content = "You already have the badge!",Image = "rbxassetid://7743878496",Time = 5})
        end
      end})

  BadgesTab:AddButton({Name = "Get Knife Badge",Callback = function()
        if not game:GetService("BadgeService"):UserHasBadgeAsync(game.Players.LocalPlayer.UserId, 2124760907) then
          fireclickdetector(game.Workspace.Lobby.Scene.knofe.ClickDetector)
        else
          OrionLib:MakeNotification({Name = "Error",Content = "You already have the badge!",Image = "rbxassetid://7743878496",Time = 5})
        end
      end})

  BadgesTab:AddButton({Name = "Get Toolbox",Callback = function()
        if not workspace:FindFirstChild("Toolbox") then
          OrionLib:MakeNotification({Name = "Error",Content = "There is no toolbox for now.",Image = "rbxassetid://7743878496",Time = 5})
        end
        task.wait()
        for i,v in pairs(workspace.Toolbox:GetDescendants()) do
          if v:IsA("ClickDetector") then
            fireclickdetector(v)
          end
        end
      end})

  BadgesTab:AddToggle({Name = "Get bob",Default = false,Callback = function(Value)
        _G.BobFarm = Value
        if _G.BobFarm == true then
          while _G.BobFarm do
            task.wait()
            if getGlove() == "Replica" and _G.BobFarm and not game:GetService("BadgeService"):UserHasBadgeAsync(game.Players.LocalPlayer.UserId, 2125950512) then
              game.ReplicatedStorage.Duplicate:FireServer(true)
              task.wait()
              tick = os.time()
              repeat task.wait()
              until os.time() - tick >= 5.2
            end
          end
        else
          task.wait(10.2)
        end
      end})

  BadgesTab:AddToggle({Name = "AutoFarm Brick [ Get Trap ] [ Auto E ]",Default = false,Callback = function(Value)
        _G.FarmBrick = Value
        while _G.FarmBrick do
          if game.Players.LocalPlayer.leaderstats.Glove.Value == "Brick" and game.Players.LocalPlayer.Character:FindFirstChild("entered") then
            task.wait()
            game.VirtualInputManager:SendKeyEvent(true, "E", false, game)
            task.wait(5.2)
          end
        end
      end})   

  BadgesTab:AddToggle({Name = "Auto TP Plate [ Get Tycoon ]",Default = false,Callback = function(Value)
        _G.AutoTpPlate = Value
        if game.Players.LocalPlayer.Character:FindFirstChild("entered") then
          while _G.AutoTpPlate do
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Arena.Plate.CFrame
            task.wait()
          end
        else
          firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, workspace.Lobby.Teleport1, 0)
          firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, workspace.Lobby.Teleport1, 1)
          while _G.AutoTpPlate do
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Arena.Plate.CFrame
            task.wait()
          end
        end
        end})

  LocalTab:AddSlider({Name = "WalkSpeed",Min = 20,Max = 1000,Default = 20,Color = Color3.fromRGB(255,255,255),Increment = 1,ValueName = "WalkSpeed",Callback = function(WS)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = WS
        WS1 = WS
      end})

  LocalTab:AddToggle({Name = "Auto Walkspeed",Default = false,Callback = function(Value)
        _G.AutoWalkspeed = Value
        if _G.AutoWalkspeed == true then
          while _G.AutoWalkspeed do
            task.wait()
            local Character = workspace:WaitForChild(game.Players.LocalPlayer.Name)
            if Character:FindFirstChild("Humanoid") ~= nil and Character.Humanoid.WalkSpeed ~= WS1 then
              Character:FindFirstChild("Humanoid").WalkSpeed = WS1
            end
          end
        end
      end})

  LocalTab:AddSlider({Name = "JumpPower",Min = 50,Max = 1000,Default = 50,Color = Color3.fromRGB(255,255,255),Increment = 1,ValueName = "JumpPower",Callback = function(JP)
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = JP
        WS2 = JP
      end})

  LocalTab:AddToggle({Name = "Auto JumpPower",Default = false,Callback = function(Value)
        _G.AutoJumpPower = Value
        if _G.AutoJumpPower == true then
          while _G.AutoJumpPower do
            task.wait()
            local Character = workspace:WaitForChild(game.Players.LocalPlayer.Name)
            if Character:FindFirstChild("Humanoid") ~= nil and Character.Humanoid.JumpPower ~= WS2 then
              Character:FindFirstChild("Humanoid").JumpPower = WS2
            end
          end
        end
      end})

  LocalTab:AddSlider({Name = "Hip Height",Min = 0,Max = 100,Default = 0,Color = Color3.fromRGB(255,255,255),Increment = 1,ValueName = "Hip Height",Callback = function(HT)
        game.Players.LocalPlayer.Character.Humanoid.HipHeight = HT
        WS3 = HT
      end})

  LocalTab:AddToggle({Name = "Auto Hip Height",Default = false,Callback = function(Value)
        _G.AutoHipHeight = Value
        if _G.AutoHipHeight == true then
          while _G.AutoHipHeight do
            task.wait()
            local Character = workspace:WaitForChild(game.Players.LocalPlayer.Name)
            if Character:FindFirstChild("Humanoid") ~= nil and Character.Humanoid.HipHeight ~= WS3 then
              Character:FindFirstChild("Humanoid").HipHeight  = WS3
            end
          end
        end
      end})

  TelepTab:AddButton({Name = "TP To Arena",Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0, 0, 0)
      end})

  TelepTab:AddButton({Name = "TP To Spam Player",Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-339.448792, 324.929474, -1.96081245)
      end})

  TelepTab:AddButton({Name = "TP To Brazil",Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.workspace.Lobby.brazil.portal.CFrame
      end})

  TelepTab:AddButton({Name = "TP To Island Slapple",Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-399.643463, 50.7640572, -15.5156841, -0.219157591, -0, -0.97568953, -0, 1.00000012, -0, 0.97568953, 0, -0.219157591)
      end})

  TelepTab:AddButton({Name = "TP To Plate",Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Arena.Plate.CFrame
      end})

  TelepTab:AddButton({Name = "TP To Arena Default",Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(103.019653, 359.984283, -9.12073612, 0.00716629531, -7.62347554e-08, -0.99997431, 5.0424859e-08, 1, -7.58753416e-08, 0.99997431, -4.98798194e-08, 0.00716629531)
      end})

  TelepTab:AddButton({Name = "TP To Round",Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(3034.03369, 144.78009, -5.25375271, 0.935709953, 0.160234556, -0.314279824, 0.00408654613, 0.885907471, 0.463844001, 0.352746665, -0.435307741, 0.828297615)
      end})

  TelepTab:AddButton({Name = "TP To island 1",Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-211.210846, -5.27827597, 4.13719559, -0.0225322824, 1.83683113e-08, -0.999746144, -1.83560154e-08, 1, 1.87866842e-08, 0.999746144, 1.87746618e-08, -0.0225322824)
      end})

  TelepTab:AddButton({Name = "TP To island 2",Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-8.17191315, -5.14452887, -205.249741, -0.98216176, -3.48867246e-09, -0.188037917, -4.19987778e-09, 1, 3.38382322e-09, 0.188037917, 4.11319823e-09, -0.98216176)
      end})

  TelepTab:AddButton({Name = "TP To island 3",Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-6.66747713, -5.06731462, 213.575378, 0.945777893, 2.52095178e-10, 0.324814111, -3.7823856e-08, 1, 1.09357536e-07, -0.324814111, -1.15713661e-07, 0.945777893)
      end})

  TelepTab:AddButton({Name = "TP To Moyai",Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(227.625656, -15.7160769, -12.4729147, -0.00455607148, 0, 0.999989569, 0, 1, -0, -0.999989688, 0, -0.00455607101)
      end})

  TelepTab:AddButton({Name = "Join Tournament",Callback = function()
        game:GetService("ReplicatedStorage").EventAnswered:FireServer(true)
      end})

  Tab11:AddToggle({Name = "Auto Enter Arena",Default = false,Callback = function(Value)
        _G.AutoEnterArena = Value
        if _G.AutoEnterArena == true then
          while _G.AutoEnterArena do
            wait()
            repeat task.wait() until game.Players.LocalPlayer.Character
            if not game.Players.LocalPlayer.Character:FindFirstChild("entered") and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
              repeat task.wait(.005)
                firetouchinterest(game.Players.LocalPlayer.Character:WaitForChild("Head"), workspace.Lobby.Teleport1.TouchInterest.Parent, 0)
                firetouchinterest(game.Players.LocalPlayer.Character:WaitForChild("Head"), workspace.Lobby.Teleport1.TouchInterest.Parent, 1)
              until game.Players.LocalPlayer.Character:FindFirstChild("entered")
            end
          end
        end
      end})

  Tab11:AddToggle({Name = "Auto Enter Default Only Arena",Default = false,Callback = function(Value)
        _G.AutoEnterDefault = Value
        if _G.AutoEnterDefault == true then
          while _G.AutoEnterDefault do
            wait()
            repeat task.wait() until game.Players.LocalPlayer.Character
            if not game.Players.LocalPlayer.Character:FindFirstChild("entered") and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
              repeat task.wait(.005)
                firetouchinterest(game.Players.LocalPlayer.Character:WaitForChild("Head"), workspace.Lobby.Teleport2.TouchInterest.Parent, 0)
                firetouchinterest(game.Players.LocalPlayer.Character:WaitForChild("Head"), workspace.Lobby.Teleport2.TouchInterest.Parent, 1)
              until game.Players.LocalPlayer.Character:FindFirstChild("entered")
            end
          end
        end
      end})

    Tab11:AddTextbox({Name = "Reach Glove",Default = "",TextDisappear = false,Callback = function(Value)
          if shared.SizeGlove == nil then
            shared.SizeGlove = Value
          end
          function supaSiza(v)
            if v:IsA("Tool") then
              v.Glove.Transparency = 1
              v.Glove.Size = Vector3.new(shared.SizeGlove, shared.SizeGlove, shared.SizeGlove)
            end
          end
          game.Players.LocalPlayer.Character.ChildAdded:Connect(supaSiza)
          game.Players.LocalPlayer.CharacterAdded:Connect(function(char)
              char.ChildAdded:Connect(supaSiza)
            end)
	        end})

  Tab11:AddTextbox({Name = "hitbox [ Reach ]",Default = "",TextDisappear = false,Callback = function(Value)
        if shared.Size == nil then
          shared.Size = Value
        end
        for i,x in pairs(game.Players:GetPlayers()) do
          if x ~= game.Players.LocalPlayer and x.Character ~= nil and x.Character:FindFirstChild("HumanoidRootPart") then
            x.Character:WaitForChild("HumanoidRootPart").Size = Vector3.new(shared.Size, shared.Size, shared.Size) 
            x.Character:WaitForChild("HumanoidRootPart").Color = Color3.fromRGB(0, 255, 255)
            x.Character:WaitForChild("HumanoidRootPart").Material = "Neon"
            x.Character:WaitForChild("HumanoidRootPart").Transparency = .9
            task.wait(.1)
            x.CharacterAdded:Connect(function(x)
                repeat task.wait() until x:FindFirstChild("HumanoidRootPart")
                task.wait(.35)
                x.HumanoidRootPart.Size =  Vector3.new(shared.Size, shared.Size, shared.Size)
                x.HumanoidRootPart.Color = Color3.fromRGB(0, 255, 255)
                x.HumanoidRootPart.Material = "Neon"
                x.HumanoidRootPart.Transparency = .9
              end)
          end
        end
        game.Players.PlayerAdded:Connect(function(Child)
            Child.CharacterAdded:Connect(function(x)
                repeat task.wait() until x:FindFirstChild("HumanoidRootPart")
                task.wait(.35)
                x.HumanoidRootPart.Size = Vector3.new(shared.Size, shared.Size, shared.Size) 
                x.HumanoidRootPart.Color = Color3.fromRGB(0, 255, 255)
                x.HumanoidRootPart.Material = "Neon"
                x.HumanoidRootPart.Transparency = .9
              end)
          end)
      end})


  Tab11:AddButton({Name = "Give reaper 20 kill",Callback = function()
        for i = 1, 20 do
          game:GetService("ReplicatedStorage"):WaitForChild("HumanoidDied"):FireServer(x,false)
        end
        for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
          if v.Name == "DeathMark" then
            game:GetService("ReplicatedStorage").ReaperGone:FireServer(game:GetService("Players").LocalPlayer.Character.DeathMark)
            game:GetService("Lighting"):WaitForChild("DeathMarkColorCorrection"):Destroy() 
          end 
        end
      end})

  Tab11:AddButton({Name = "Destroy All Tycoons",Callback = function()
        for _, tycoon in pairs(workspace:GetChildren()) do
          if string.find(tycoon.Name, "ÅTycoon") then
            for i = 0,100 do
              fireclickdetector(tycoon.Destruct.ClickDetector, 0)
              fireclickdetector(tycoon.Destruct.ClickDetector, 1)
            end
          end
        end
      end})

  Tab11:AddButton({Name = "Godmode [ All Glove ]",Callback = function()
        if game.Players.LocalPlayer.Character:FindFirstChild("entered") == nil then
          firetouchinterest(game.Players.LocalPlayer.Character:WaitForChild("Head"), workspace.Lobby.Teleport1.TouchInterest.Parent, 0)
          firetouchinterest(game.Players.LocalPlayer.Character:WaitForChild("Head"), workspace.Lobby.Teleport1.TouchInterest.Parent, 1)
          wait(0.5)
          for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
            if v.ClassName == "Tool" then
              v.Parent = game.LogService
            end
          end
          game:GetService("ReplicatedStorage"):WaitForChild("HumanoidDied"):FireServer(game.Players.LocalPlayer.Character,false)
          wait(4)
          for i,v in pairs(game.LogService:GetChildren()) do
            if v.ClassName == "Tool" then
              v.Parent = game.Players.LocalPlayer.Character
            end
          end
          game.Players.LocalPlayer.Character.Humanoid:UnequipTools()
          for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
            if v.ClassName == "Tool" then
              game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
            end
          end 
          game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Workspace.Origo.CFrame
        elseif game.Players.LocalPlayer.Character:FindFirstChild("entered") then
          game.Players.LocalPlayer.Character.Humanoid:UnequipTools()
          for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
            if v.ClassName == "Tool" then
              v.Parent = game.LogService
            end
          end
          game:GetService("ReplicatedStorage"):WaitForChild("HumanoidDied"):FireServer(game.Players.LocalPlayer.Character,false)
          wait(4)
          for i,v in pairs(game.LogService:GetChildren()) do
            if v.ClassName == "Tool" then
              v.Parent = game.Players.LocalPlayer.Character
            end
          end
          game.Players.LocalPlayer.Character.Humanoid:UnequipTools()
          for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
            if v.ClassName == "Tool" then
              game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
            end
          end 
          game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Workspace.Origo.CFrame
        end
      end})

  Tab11:AddToggle({Name = "Auto Click Tycoon",Default = false,Callback = function(Value)
        _G.AutoTycoon = Value
        for i,v in pairs(workspace:GetDescendants()) do
          if v.Name == "End" and v.ClassName == "Part" then
            v.Size = Vector3.new(28, 0.3, 4)
          end
        end
        while _G.AutoTycoon do
          for i,v in pairs(workspace:GetDescendants()) do
            if v.Name == "Click" and v:FindFirstChild("ClickDetector") then
              fireclickdetector(v.ClickDetector)
            end
          end
          task.wait()
        end
      end})

  Tab11:AddToggle({Name = "Rhythm Note Spam + Auto Press [ Equip Rhythm ]",Default = false,Callback = function(Value)
        _G.RhythmNoteSpam = Value
        while _G.RhythmNoteSpam do
          game.Players.LocalPlayer.PlayerGui.Rhythm.LocalScript.Disabled = false
          game.Players.LocalPlayer.PlayerGui.Rhythm.LocalScript.Disabled = true
          game.Players.LocalPlayer.Character.Rhythm:Activate()
          task.wait()
        end
      end})

  Tab11:AddToggle({Name = "Auto Rainbow [ Equip Golden ]",Default = false,Callback = function(Value)
        _G.Rainbow = Value
        while _G.Rainbow do
          local randomnumber = math.random(1004, 1032)
          local args = {
            [1] = false,
            [2] = BrickColor.new(randomnumber)
          }
          game:GetService("ReplicatedStorage").Goldify:FireServer(unpack(args))
          task.wait(0.075)
        end
      end})

  Tab13:AddToggle({Name = "Slap Aura [ All Gloves ]",Default = false,Callback = function(Value)		
        _G.SlapAura = Value
        if _G.SlapAura == true then
          while _G.SlapAura do
            task.wait()
            pcall(function()
                for Index, Player in next, game.Players:GetPlayers() do
                  if Player ~= game.Players.LocalPlayer and Player.Character and Player.Character:FindFirstChild("entered") then
                    if Player.Character:FindFirstChild("Head") then
                      if Player.Character.Head:FindFirstChild("UnoReverseCard") == nil and Player.Character:FindFirstChild("rock") == nil then
                        if game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and not game.Players.LocalPlayer:IsFriendsWith(Player.UserId) then
                          local Magnitude = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Player.Character.HumanoidRootPart.Position).Magnitude
                          if 25 >= Magnitude then
                            shared.gloveHits[getGlove()]:FireServer(Player.Character:WaitForChild("Head"))
                          end
                        end
                      end
                    end
                  end
                end
              end)
          end
        end
      end})

  Tab13:AddToggle({Name = "Glove Extend",Default = false,Callback = function(bool)		
        GloveExtend = bool
      end})

  Tab13:AddDropdown({Name = "Glove Type",Default = "Pancake",Options = {"Pancake", "Meat Stick", "Growth", "North Korea Wall", "Slight Extend"},Callback = function(Value)
        ExtendOption = Value
      end})

  Tab13:AddToggle({Name = "Autoclicker",Default = false,Callback = function(bool)		
        AutoClick = bool
      end})

  AntiTab:AddToggle({Name = "Anti Admin [ Kick You When Mod/Admin Joins ]",Default = false,Callback = function(Value)
        _G.AntiAdmin = Value
        if _G.AntiAdmin == true then
          game.Players.PlayerAdded:Connect(function(Plr)
              if Plr:GetRankInGroup(9950771) and 7 <= Plr:GetRankInGroup(9950771) and _G.AntiAdmin then
                game.Players.LocalPlayer:Kick("Admin Detected")
              end
            end)
        end
      end})

  AntiTab:AddToggle({Name = "Anti Kick",Default = false,Callback = function(Value)
        _G.AntiKick = Value
        while _G.AntiKick do
          for i,v in pairs(game.CoreGui.RobloxPromptGui.promptOverlay:GetDescendants()) do
            if v.Name == "ErrorPrompt" then
              game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, game.Players.LocalPlayer)
            end
          end
          task.wait()
        end
      end})

  AntiTab:AddToggle({Name = "Anti Obby",Default = false,Callback = function(Value)
        _G.Disable = Value
        if _G.Disable == false then
          for i,v in pairs(game.Players:GetChildren()) do
            if v.leaderstats.Glove.Value == "Obby" then
              disable(v.Name, true)
            end
          end
        end
        while _G.Disable do
          for i,v in pairs(game.Players:GetChildren()) do
            if v.leaderstats.Glove.Value == "Obby" then
              disable(v.Name, false)
            end
          end
          task.wait()
        end
      end})

  AntiTab:AddToggle({Name = "Anti Megarock / Custom",Default = false,Callback = function(Value)
        _G.AntiRocks = Value
        while _G.AntiRocks do
          for i,v in pairs(game.Workspace:GetDescendants()) do
            if v.Name == "rock" then
              v.CanTouch = false
              v.CanQuery = false
            end
          end
          task.wait()
        end
      end})

  AntiTab:AddToggle({Name = "Anti Mail",Default = false,Callback = function(Value)
        game.Players.LocalPlayer.Character.YouHaveGotMail.Disabled = Value
        _G.AntiMail = Value
        while _G.AntiMail do
          if game.Players.LocalPlayer.Character:FindFirstChild("YouHaveGotMail") then
            game.Players.LocalPlayer.Character.YouHaveGotMail.Disabled = true
          end
          task.wait()
        end
      end})

  AntiTab:AddToggle({Name = "Anti HallowJack",Default = false,Callback = function(Value)
        _G.AntiHallowJack = Value
        if _G.AntiHallowJack == true then
          game.Players.LocalPlayer.PlayerScripts.HallowJackAbilities.Disabled = true
        else
          game.Players.LocalPlayer.PlayerScripts.HallowJackAbilities.Enabled = true
        end
      end})

  AntiTab:AddToggle({Name = "Anti Booster",Default = false,Callback = function(Value)
        _G.AntiBooster = Value
        while _G.AntiBooster do
          for i,v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
            if v.Name == "BoosterObject" then
              v:Destroy()
            end
          end
          task.wait()
        end
      end})

  Tab13:AddToggle({Name = "AutoSlap",Default = false,Callback = function(Value)
        _G.SlapFarm = Value
        if _G.SlapFarm == true then
          workspace.DEATHBARRIER.CanTouch = false
          workspace.DEATHBARRIER2.CanTouch = false
          workspace.dedBarrier.CanTouch = false
          task.wait()
          while _G.SlapFarm do
            task.wait()
            pcall(function()
                for Index, Human in next, game.Players:GetPlayers() do
                  if Human ~= game.Players.LocalPlayer and Human.Character and not Human.Character:FindFirstChild("isParticipating") and Human.Character:FindFirstChild("Torso") and Human.Character:FindFirstChild("Head") and Human.Character:FindFirstChild("entered") and Human.Character.Head:FindFirstChild("UnoReverseCard") == nil and Human.Character:FindFirstChild("rock") == nil and Human.Character.Ragdolled.Value == false then
                    if game.Players.LocalPlayer.Character:FindFirstChild("entered") and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                      task.wait(.1)
                      game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = Human.Character:FindFirstChild("Right Leg").CFrame * CFrame.new(6,-2,6)
                      task.wait()
                      game.Players.LocalPlayer.Character:WaitForChild("Humanoid").PlatformStand = true
                      wait(.1)
                      shared.gloveHits[getGlove()]:FireServer(Human.Character:FindFirstChild("Torso"))
                      wait(.1)
                    end
                  end
                end
              end)
          end
        else
          workspace.DEATHBARRIER.CanTouch = true
          workspace.DEATHBARRIER2.CanTouch = true
          workspace.dedBarrier.CanTouch = true
          if game.Players.LocalPlayer.Character.Humanoid.PlatformStand == true then
            task.wait(3)
            game.Players.LocalPlayer.Character.Humanoid.PlatformStand = false
          end
        end
      end})

  AntiTab:AddToggle({Name = "Anti Squid",Default = false,Callback = function(Value)
        _G.AntiSquid = Value
        if _G.AntiSquid == false then
          game.Players.LocalPlayer.PlayerGui.SquidInk.Enabled = true
        end
        while _G.AntiSquid do
          if game.Players.LocalPlayer.PlayerGui:FindFirstChild("SquidInk") then
            game.Players.LocalPlayer.PlayerGui.SquidInk.Enabled = false
          end
          task.wait()
        end
      end})

  AntiTab:AddToggle({Name = "Anti Conveyor",Default = false,Callback = function(Value)
        _G.AntiConv = Value
        if _G.AntiConv == true then
          game.Players.LocalPlayer.PlayerScripts.ConveyorVictimized.Disabled = true
        else
          game.Players.LocalPlayer.PlayerScripts.ConveyorVictimized.Enabled = true
        end
      end})

  AntiTab:AddToggle({Name = "Anti TimeStop",Default = false,Callback = function(Value)
        _G.AntiTimestop = Value
        while _G.AntiTimestop do
          for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
            if v.ClassName == "Part" then
              v.Anchored = false
            end
          end
          task.wait()
        end
      end})

  AntiTab:AddToggle({Name = "Anti Brick",Default = false,Callback = function(Value)
        _G.AntiBrick = Value
        while _G.AntiBrick do
          for i,v in pairs(game.Workspace:GetChildren()) do
            if v.Name == "Union" then
              v.CanTouch = false
            end
          end
          task.wait()
        end
      end})

  AntiTab:AddToggle({Name = "Anti [REDACTED]",Default = false,Callback = function(Value)
        _G.AntiRedacted = Value
        if _G.AntiRedacted == true then
          game.Players.LocalPlayer.PlayerScripts.Well.Disabled = true
        else
          game.Players.LocalPlayer.PlayerScripts.Well.Enabled = true
        end
      end})

  AntiTab:AddToggle({Name = "Anti Brazil",Default = false,Callback = function(Value)
        _G.AntiBrazil = Value
        if _G.AntiBrazil == true then
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

  Tab13:AddToggle({Name = "Ghost Autofarm Slap",Default = false,Callback = function(Value)
        _G.GhostFarm = Value
        if _G.GhostFarm == true then
          game.ReplicatedStorage.Ghostinvisibilityactivated:FireServer()
          while _G.GhostFarm do
            wait()
            pcall(function()
                for Index, Human in next, game.Players:GetPlayers() do
                  if Human ~= game.Players.LocalPlayer and Human.Character and Human.Character:FindFirstChild("Head") and Human.Character:FindFirstChild("entered") and Human.Character.Head:FindFirstChild("UnoReverseCard") == nil and Human.Character:FindFirstChild("rock") == nil and Human.Character.Ragdolled.Value == false then
                    if game.Players.LocalPlayer.Character:FindFirstChild("entered") and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                      task.wait(.1)
                      if getGlove() == "Ghost" then
                        game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = Human.Character:FindFirstChild("Torso").CFrame * CFrame.new(6,-2,6)
                        task.wait()
                        game.Players.LocalPlayer.Character:WaitForChild("Humanoid").PlatformStand = true
                        wait(.1)
                        game.ReplicatedStorage.GhostHit:FireServer(Human.Character:WaitForChild(toHit))
                        wait(.1)
                      end
                    end
                  end
                end
              end)
          end
        else
          game.ReplicatedStorage.Ghostinvisibilitydeactivated:FireServer()
          if game.Players.LocalPlayer.Character.Humanoid.PlatformStand == true then
            task.wait(3)
            game.Players.LocalPlayer.Character.Humanoid.PlatformStand = false
          end
        end
      end})

  AntiTab:AddToggle({Name = "Anti ZaHando",Default = false,Callback = function(Value)
        _G.AntiZaHando = Value
        while _G.AntiZaHando do
          for i,v in pairs(game.Workspace:GetChildren()) do
            if v.ClassName == "Part" and v.Name == "Part" then
              v:Destroy()
            end
          end
          task.wait()
        end
      end})

  AntiTab:AddToggle({Name = "Anti Reaper",Default = false,Callback = function(Value)
        _G.AntiReaper = Value
        while _G.AntiReaper do
          for i,v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
            if v.Name == "DeathMark" then
              game:GetService("ReplicatedStorage").ReaperGone:FireServer(game.Players.LocalPlayer.Character.DeathMark)
              game:GetService("Lighting"):WaitForChild("DeathMarkColorCorrection"):Destroy() 
            end
          end
          task.wait()
        end
      end})

  AntiTab:AddToggle({Name = "Anti Pusher",Default = false,Callback = function(Value)
        _G.AntiPusher = Value
        while _G.AntiPusher do
          for i,v in pairs(game.Workspace:GetChildren()) do
            if v.Name == "wall" then
              v.CanCollide = false
            end
          end
          task.wait()
        end
      end})

  AntiTab:AddToggle({Name = "Anti Barrier",Default = false,Callback = function(Value)
        _G.NoclipBarrier = Value
        if _G.NoclipBarrier == false then
          for i,v in pairs(game.Workspace:GetChildren()) do
            if string.find(v.Name, "ÅBarrier") then
              v.CanCollide = true
            end
          end
        end
        while _G.NoclipBarrier do
          for i,v in pairs(game.Workspace:GetChildren()) do
            if string.find(v.Name, "ÅBarrier") then
              v.CanCollide = false
            end
          end
          task.wait()
        end
      end})

  AntiTab:AddToggle({Name = "Anti Bubble",Default = false,Callback = function(Value)
        _G.AntiBubble = Value
        if _G.AntiBubble == true then
          while _G.AntiBubble do
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

  AntiTab:AddToggle({Name = "Anti Stun",Default = false,Callback = function(Value)
        _G.AntiStun = Value
        while _G.AntiStun do
          if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") ~= nil and game.Workspace:FindFirstChild("Shockwave") then
            game.Players.LocalPlayer.Character.Humanoid.PlatformStand = false
          end
          task.wait()
        end
      end})

  AntiTab:AddToggle({Name = "Disable Cube Of Death",Default = false,Callback = function(Value)
        _G.DisableCOD = Value
        if _G.DisableCOD == true then
          if game.Workspace:FindFirstChild("the cube of death(i heard it kills)", 1) then
            workspace.Arena.CubeOfDeathArea["the cube of death(i heard it kills)"].CanTouch = false
          end
        else
          if game.Workspace:FindFirstChild("the cube of death(i heard it kills)", 1) then
            workspace.Arena.CubeOfDeathArea["the cube of death(i heard it kills)"].CanTouch = true
          end
        end
      end})

  AntiTab:AddToggle({Name = "Disable Death Barriers",Default = false,Callback = function(Value)
        _G.DisableDB = Value
        if _G.DisableDB == true then
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

  Tab11:AddToggle({Name = "Auto Remove Nametag",Default = false,Callback = function(Value)		 
        _G.AutoRemoveNametag = Value
        if _G.AutoRemoveNametag == true then
          game.Players.LocalPlayer.Character:FindFirstChild("Head").Nametag.TextLabel:Destroy()
          task.wait()
          game.Players.LocalPlayer.CharacterAdded:Connect(function()
              if _G.AutoRemoveNametag == true then
                repeat task.wait()
                until game.Players.LocalPlayer.Character:FindFirstChild("Head")
                game.Players.LocalPlayer.Character:FindFirstChild("Head").Nametag.TextLabel:Destroy()
              end
            end)
        end
      end})

  AntiTab:AddToggle({Name = "Anti Ragdoll",Default = false,Callback = function(Value)
        _G.AntiRagdoll = Value
        if _G.AntiRagdoll == true then
          game.Players.LocalPlayer.Character.Humanoid.Health = 0
          task.wait()
          game.Players.LocalPlayer.CharacterAdded:Connect(function()
              local Character = game.Workspace[game.Players.LocalPlayer.Name]
              task.wait()
              Character:WaitForChild("Ragdolled").Changed:Connect(function()
                  if Character:WaitForChild("Ragdolled").Value == true and _G.AntiRagdoll == true then
                    repeat task.wait()
                      Character.Torso.Anchored = true
                    until Character:FindFirstChild("Torso") == nil or Character:WaitForChild("Ragdolled").Value == false
                    Character.Torso.Anchored = false
                  end
                end)
            end)
        end
	      end})

  Tab11:AddToggle({Name = "Invisible Reverse [ FE ]",Default = false,Callback = function(Value)
        _G.InvisibleReverse = Value
        if _G.InvisibleReverse == true then
          while _G.InvisibleReverse do
            repeat task.wait() until game.Players.LocalPlayer.Character:FindFirstChild("SelectionBox", 1) and game.Players.LocalPlayer.Character:FindFirstChild("Head"):FindFirstChild("UnoReverseCard")
            game.Players.LocalPlayer.Character.Head["UnoReverseCard"]:Destroy()
            for i,v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
              if v.Name == "SelectionBox" then
                v:Destroy()
              end
            end
          end
        end
      end})

  Tab11:AddToggle({Name = "Infinite Reverse",Default = false,Callback = function(Value)
        _G.InfiniteReverse = Value
        if _G.InfiniteReverse == true then
          while _G.InfiniteReverse do
            task.wait()
            local Character = workspace:WaitForChild(game.Players.LocalPlayer.Name)
            if game.Players.LocalPlayer.leaderstats.Glove.Value == "Reverse" and Character:FindFirstChild("entered") then
              task.wait(5.7)
              game:GetService("ReplicatedStorage"):WaitForChild("ReverseAbility"):FireServer()
            end
          end
        end
      end})

  Tab11:AddToggle({Name = "Ping Pong Orbit",Default = false,Callback = function(Value)
        _G.PingPongOrbit = Value
        game.Players.LocalPlayer.Character.Torso.RadioPart.Rotation = game.Players.LocalPlayer.Character.HumanoidRootPart.Rotation
        Orbit = "0"
        PingPongBall = game.Players.LocalPlayer.Name.."_PingPongBall"
        while _G.PingPongOrbit do
          game:GetService("ReplicatedStorage").GeneralAbility:FireServer()
          Orbit = Orbit + OrbitSpeed
          game.Players.LocalPlayer.Character.Torso.RadioPart.Rotation = Vector3.new(-180, Orbit, -180)
          if game.Players.LocalPlayer.Character.Torso.RadioPart:GetChildren()[2] then
            for i,v in pairs(game.Workspace:GetChildren()) do
              if v.ClassName == "Part" and v.Name == PingPongBall then
                v.CFrame = game.Players.LocalPlayer.Character.Torso.RadioPart.CFrame * CFrame.new(0,0,-15) * CFrame.Angles(math.rad(0), math.rad(-90), math.rad(0))
              end
            end
            for i,v in pairs(game.Players.LocalPlayer.Character.Torso.RadioPart:GetChildren()) do
              if v.ClassName == "Part" and v.Name == PingPongBall then
                v.CFrame = game.Players.LocalPlayer.Character.Torso.RadioPart.CFrame * CFrame.new(0,0,15) * CFrame.Angles(math.rad(0), math.rad(90), math.rad(0))
              end
            end
          elseif game.Players.LocalPlayer.Character.Torso.RadioPart:GetChildren()[1] or game.Players.LocalPlayer.Character.Torso.RadioPart:GetChildren()[2] then
            for i,v in pairs(game.Workspace:GetChildren()) do
              if v.ClassName == "Part" and v.Name == PingPongBall then
                v.Parent = game.Players.LocalPlayer.Character.Torso.RadioPart
                break
              end
            end
          end
          task.wait(0.01)
        end
      end})

  Tab11:AddSlider({Name = "Ping Pong Orbit Speed",Min = 0,Max = 100,Default = 10,Color = Color3.fromRGB(255,255,255),Increment = 1,ValueName = "Speed",Callback = function(Value)
        OrbitSpeed = Value
      end})

  Tab12:AddButton({Name = "Tool Click Tp",Callback = function()
        local plr = game:GetService("Players").LocalPlayer
        local mouse = plr:GetMouse()
        local tool = Instance.new("Tool")

        tool.RequiresHandle = false
        tool.Name = "Click Teleport"
        tool.Activated:Connect(function()
            local root = plr.Character.HumanoidRootPart
            local pos = mouse.Hit.Position+Vector3.new(0,2.5,0)
            local offset = pos-root.Position
            root.CFrame = root.CFrame+offset
          end)
        tool.Parent = plr.Backpack
      end})

  Tab12:AddButton({Name = "Make the Glove turn into a block",Callback = function()
        OrionLib:MakeNotification({Name = "Warning",Content = "May not work on some gloves.",Image = "rbxassetid://7733956210",Time = 5})
        wait(1.5)
        for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
          if v:IsA("Tool") then
            if v.Glove.Mesh or v.Glove.Cuff.Mesh then
              v.Glove.Mesh:Destroy()
              v.Glove.Cuff.Mesh:Destroy()
            end
          end
        end
      end})

  Tab12:AddButton({Name = "View Testing Server [ Good for glove leaking ]",Callback = function()
        local teleportFunc = queueonteleport or queue_on_teleport or syn and syn.queue_on_teleport
        if teleportFunc then
          teleportFunc([[
            if not game:IsLoaded() then
            game.Loaded:Wait()
          end
            local localPlr = game:GetService("Players").LocalPlayer
            repeat wait() until localPlr
            game:GetService("RunService").RenderStepped:Connect(function()
            game:GetService("GuiService"):ClearError()
          end)]])
        end
        game:GetService("TeleportService"):Teleport(9020359053)
      end})

  Tab21:AddTextbox({Name = "Player",Default = "",TextDisappear = false,Callback = function(Value)
        PlayerTP = Value
      end})


  Tab21:AddButton({Name = "TP Player",Callback = function()
        local lplayer = game:GetService('Players').LocalPlayer
        local yeeting = false
        function GetPlayer(String)
          local Found = {}
          local strl = String:lower()
          if strl == "all" then
            for i,v in pairs(game:GetService("Players"):GetPlayers()) do
              table.insert(Found,v)
            end
          elseif strl == "Random" then
            for i,v in pairs(game:GetService("Players"):GetPlayers()) do
              if v.Name ~= lplayer.Name then
                table.insert(Found,v)
              end
            end
          elseif strl == "me" then
            for i,v in pairs(game:GetService("Players"):GetPlayers()) do
              if v.Name == lplayer.Name then
                table.insert(Found,v)
              end
            end 
          else
            for i,v in pairs(game:GetService("Players"):GetPlayers()) do
              if v.Name:lower():sub(1, #String) == String:lower() then
                table.insert(Found,v)
              end
            end 
          end
          return Found 
        end
        function ahh(thing)
          local asd = {'yeet','gui','yeet gui'}
          local f = string.upper(asd[math.random(1,#asd)])
          return f
        end
        local target = unpack(GetPlayer(PlayerTP)).Character
        game:GetService'Players'.LocalPlayer.Character.HumanoidRootPart.CFrame = target.Head.CFrame;coin.Location = target.Head.Position game["Run Service"].Heartbeat:wait()
      end})

  Tab14:AddToggle({Name = "Spam Slicer Sound",Default = false,Callback = function(Value)
        _G.SpamSlicer = Value
        while _G.SpamSlicer do
          game:GetService("ReplicatedStorage").Slicer:FireServer("sword")
          task.wait()
        end
      end})

  Tab14:AddToggle({Name = "Spam Thanos Sound",Default = false,Callback = function(Value)
        _G.SpamThanos = Value
        while _G.SpamThanos do
          game.ReplicatedStorage.Illbeback:FireServer()
          task.wait()
        end
      end})

  Tab14:AddToggle({Name = "Spam Sleep Sound",Default = false,Callback = function(Value)
        _G.SpamSleep = Value
        while _G.SpamSleep do
          game:GetService("ReplicatedStorage").ZZZZZZZSleep:FireServer()
          task.wait()
        end
      end})

  Tab14:AddToggle({Name = "Spam Ghost Sound",Default = false,Callback = function(Value)
        _G.GhostSoundSpam = Value
        while _G.GhostSoundSpam do
          game.ReplicatedStorage.Ghostinvisibilityactivated:FireServer()
          game.ReplicatedStorage.Ghostinvisibilitydeactivated:FireServer()
          task.wait()
        end 
      end})

  Tab14:AddToggle({Name = "Spam Error Sound",Default = false,Callback = function(Value)
        _G.ErrorSoundSpam = Value
        while _G.ErrorSoundSpam do
          game:GetService("ReplicatedStorage").LetMeBeClear:FireServer(true)
          task.wait(2.1)
        end
      end})

  Tab14:AddToggle({Name = "Spam Hitman Sound",Default = false,Callback = function(Value)
        _G.HitmanSoundSpam = Value
        while _G.HitmanSoundSpam do
          game:GetService("ReplicatedStorage"):WaitForChild("HitmanAbility"):FireServer("ReplicateGoldenRevolver",{0})
          task.wait()
        end
      end})

  Tab14:AddToggle({Name = "Spam ErrorDeath Sound",Default = false,Callback = function(Value)
        _G.ErrorDeath = Value
        while _G.ErrorDeath do
          game.ReplicatedStorage.ErrorDeath:FireServer()
          task.wait()
        end
      end})

  Tab14:AddToggle({Name = "Spam Charge Sound",Default = false,Callback = function(Value)
        _G.ChargeSoundSpam = Value
        while _G.ChargeSoundSpam do
          game:GetService("ReplicatedStorage").GeneralAbility:FireServer(game:GetService("Players").LocalPlayer.Character.Charge)
          wait(3.05)
        end
      end})

  Tab14:AddToggle({Name = "Spam Golden Sound",Default = false,Callback = function(Value)
        _G.GoldenSoundSpam = Value
        while _G.GoldenSoundSpam do
          local args = {
            [1] = true
          }
          game:GetService("ReplicatedStorage").Goldify:FireServer(unpack(args))  
          task.wait()
        end
      end})


  Tab14:AddToggle({Name = "Spam Zero G Sound",Default = false,Callback = function(Value)
        _G.ZeroGSound = Value
        if _G.ZeroGSound == true then
          while _G.ZeroGSound do
            task.wait()
            if getGlove() == "Space" then
              game.ReplicatedStorage["ZeroGSound"]:FireServer()
              game.Players.LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Landed)
            end
          end
        else
          for x = 1,5 do
            task.wait()
            game.Players.LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Landed)
          end
        end
      end})

  Tab15:AddButton({Name = "Spawn nimbus cloud ( All gloves )",Callback = function()
        game.ReplicatedStorage.NimbusAbility:FireServer()
      end})

  Tab15:AddButton({Name = "Spawn cloud ( All gloves )",Callback = function()
        game:GetService("ReplicatedStorage").CloudAbility:FireServer()
      end})

  Tab15:AddToggle({Name = "Auto Spam Ability",Default = false,Callback = function(Value)
        On = Value
        while On and game.Players.LocalPlayer.leaderstats.Glove.Value == "Gravity" do
          game:GetService("ReplicatedStorage").GeneralAbility:FireServer()
          wait()
        end
        while On and game.Players.LocalPlayer.leaderstats.Glove.Value == "Cloud" do
          game:GetService("ReplicatedStorage").CloudAbility:FireServer()
          wait()
        end
        while On and game.Players.LocalPlayer.leaderstats.Glove.Value == "Whirlwind" do
          game:GetService("ReplicatedStorage").GeneralAbility:FireServer()
          wait()
        end
        while On and game.Players.LocalPlayer.leaderstats.Glove.Value == "Phantom" do
          local Phantom = workspace[Player].Phantom
          game:GetService("ReplicatedStorage").PhantomDash:InvokeServer(Phantom)
          wait()
        end
        while On and game.Players.LocalPlayer.leaderstats.Glove.Value == "Replica" do
          game:GetService("ReplicatedStorage").Duplicate:FireServer()
          wait(5.1)
        end
        while On and game.Players.LocalPlayer.leaderstats.Glove.Value == "Fort" do
          game:GetService("ReplicatedStorage").Fortlol:FireServer()
          wait(3.1)
        end
        while On and game.Players.LocalPlayer.leaderstats.Glove.Value == "Home Run" do
          game:GetService("ReplicatedStorage").HomeRun:FireServer({["start"] = true})
          game:GetService("ReplicatedStorage").HomeRun:FireServer({["finished"] = true})
          task.wait()
        end
        while On and game.Players.LocalPlayer.leaderstats.Glove.Value == "🗿" do
          game:GetService("ReplicatedStorage"):WaitForChild("GeneralAbility"):FireServer(CFrame.new(math.random(-70, 63), -5.72293854, math.random(-90, 93), 0.151493087, -8.89114702e-08, 0.988458335, 1.45089563e-09, 1, 8.97272727e-08, -0.988458335, -1.21589121e-08, 0.151493087))
          wait(3.1)
        end
        while On and game.Players.LocalPlayer.leaderstats.Glove.Value == "Shukuchi" do
          local LocalPlayer = game.Players.LocalPlayer
          local players = game.Players:GetChildren()
          local RandomPlayer = players[math.random(1, #players)]
          repeat RandomPlayer = players[math.random(1, #players)] until RandomPlayer ~= LocalPlayer
          repeat RandomPlayer = players[math.random(1, #players)] until RandomPlayer.Character.isInArena.Value == true
          PersonToKill = RandomPlayer
          game:GetService("ReplicatedStorage").SM:FireServer(PersonToKill)
          wait(0.01)
        end
        while On and game.Players.LocalPlayer.leaderstats.Glove.Value == "Slicer" do
          game:GetService("ReplicatedStorage").Slicer:FireServer("sword")
          game:GetService("ReplicatedStorage").Slicer:FireServer("slash", game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame, Vector3.new())
          wait(5.1)
        end
        while On and game.Players.LocalPlayer.leaderstats.Glove.Value == "Quake" do
          game:GetService("ReplicatedStorage").QuakeQuake:FireServer({["start"] = true})
          wait()
        end
        while On and game.Players.LocalPlayer.leaderstats.Glove.Value == "rob" do
          game:GetService("ReplicatedStorage"):WaitForChild("rob"):FireServer()
          wait()
        end
        while On and game.Players.LocalPlayer.leaderstats.Glove.Value == "Kraken" do
          game:GetService("ReplicatedStorage").KrakenArm:FireServer()
          wait(5)
        end
        while On and game.Players.LocalPlayer.leaderstats.Glove.Value == "Psycho" do
          game:GetService("ReplicatedStorage").Psychokinesis:InvokeServer({["grabEnabled"] = true})
          task.wait()
        end
        while On and game.Players.LocalPlayer.leaderstats.Glove.Value == "Killstreak" and game.Players.LocalPlayer.PlayerGui:FindFirstChild("Kills") and game.Players.LocalPlayer.PlayerGui.Kills.Frame.TextLabel.Text >= "75" do
          game:GetService("ReplicatedStorage").KSABILI:FireServer()
          wait(6.1)
        end
        while On and game.Players.LocalPlayer.leaderstats.Glove.Value == "Bus" do
          game:GetService("ReplicatedStorage").busmoment:FireServer()
          wait(5.1)
        end
        while On and game.Players.LocalPlayer.leaderstats.Glove.Value == "Mitten" do
          game:GetService("ReplicatedStorage").MittenA:FireServer()
          wait(5.1)
        end
        while On and game.Players.LocalPlayer.leaderstats.Glove.Value == "Fort" do
          game:GetService("ReplicatedStorage").Fortlol:FireServer()
          wait(3.1)
        end
        while On and game.Players.LocalPlayer.leaderstats.Glove.Value == "Defense" do
          game:GetService("ReplicatedStorage").Barrier:FireServer()
          wait(0.25)
        end
        while On and game.Players.LocalPlayer.leaderstats.Glove.Value == "Bomb" do
          game:GetService("ReplicatedStorage").BombThrow:FireServer()
          wait(2.5)
          game:GetService("ReplicatedStorage").BombThrow:FireServer()
          wait(4.1)
        end
        while On and game.Players.LocalPlayer.leaderstats.Glove.Value == "Replica" do
          game:GetService("ReplicatedStorage").Duplicate:FireServer()
          wait(5.1)
        end
        while On and game.Players.LocalPlayer.leaderstats.Glove.Value == "Pusher" do
          game:GetService("ReplicatedStorage").PusherWall:FireServer()
          wait(5.1)
        end
        while On and game.Players.LocalPlayer.leaderstats.Glove.Value == "Jet" do
          local LocalPlayer = game.Players.LocalPlayer
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
            game:GetService("ReplicatedStorage").AirStrike:FireServer(closestPlayer.Character)
            wait(5.3)
          end
        end
        while game.Players.LocalPlayer.leaderstats.Glove.Value == "Tableflip" or game.Players.LocalPlayer.leaderstats.Glove.Value == "Shield" and On do
          game:GetService("ReplicatedStorage").GeneralAbility:FireServer()
          wait(3.1)
        end
        while On and game.Players.LocalPlayer.leaderstats.Glove.Value == "Rocky" do
          game:GetService("ReplicatedStorage").RockyShoot:FireServer()
          wait(6.1)
        end
        while On and game.Players.LocalPlayer.leaderstats.Glove.Value == "God's Hand" do
          game:GetService("ReplicatedStorage").TimestopJump:FireServer()
          game:GetService("ReplicatedStorage").Timestopchoir:FireServer()
          game:GetService("ReplicatedStorage").Timestop:FireServer()
          wait(50.1)
        end
        while On and game.Players.LocalPlayer.leaderstats.Glove.Value == "Za Hando" do
          game:GetService("ReplicatedStorage").Erase:FireServer()
          wait(5.1)
        end
        while game.Players.LocalPlayer.leaderstats.Glove.Value == "Baller" or game.Players.LocalPlayer.leaderstats.Glove.Value == "Glitch" and On do
          game:GetService("ReplicatedStorage").GeneralAbility:FireServer()
          wait(4.1)
        end
        while On and game.Players.LocalPlayer.leaderstats.Glove.Value == "Stun" do
          game:GetService("ReplicatedStorage").StunR:FireServer(game:GetService("Players").LocalPlayer.Character.Stun)
          wait(10.1)
        end
        while On and game.Players.LocalPlayer.leaderstats.Glove.Value == "STOP" do
          game:GetService("ReplicatedStorage").STOP:FireServer(true)
          wait(4.1)
        end
        while On and game.Players.LocalPlayer.leaderstats.Glove.Value == "Track" do
          local LocalPlayer = game.Players.LocalPlayer
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
        while On and game.Players.LocalPlayer.leaderstats.Glove.Value == "Mail" do
          game:GetService("ReplicatedStorage").MailSend:FireServer()
          wait(3.1)
        end
        while On and game.Players.LocalPlayer.leaderstats.Glove.Value == "Shard" do
          game:GetService("ReplicatedStorage").Shards:FireServer()
          wait(4.1)
        end
        while On and game.Players.LocalPlayer.leaderstats.Glove.Value == "Swapper" do
          game:GetService("ReplicatedStorage").SLOC:FireServer()
          wait(5.1)
        end
        while On and game.Players.LocalPlayer.leaderstats.Glove.Value == "Bubble" do
          game:GetService("ReplicatedStorage").BubbleThrow:FireServer()
          wait(3.1)
        end
        while On and game.Players.LocalPlayer.leaderstats.Glove.Value == "Slapple" do
          game:GetService("ReplicatedStorage").funnyTree:FireServer(game.Players.LocalPlayer.Character.HumanoidRootPart.Position)
          wait(3.1)
        end
        while On and game.Players.LocalPlayer.leaderstats.Glove.Value == "Kinetic" do
          game:GetService("ReplicatedStorage").KineticExpl:FireServer(game:GetService("Players").LocalPlayer.Character.Kinetic, game.Players.LocalPlayer.Character.HumanoidRootPart.Position)
          wait(9.1)
        end
        while On and game.Players.LocalPlayer.leaderstats.Glove.Value == "Dominance" do
          game:GetService("ReplicatedStorage").DominanceAc:FireServer(game.Players.LocalPlayer.Character.HumanoidRootPart.Position)
          wait(3.1)
        end
        while On and game.Players.LocalPlayer.leaderstats.Glove.Value == "[REDACTED]" do
          game:GetService("ReplicatedStorage").Well:FireServer()
          wait(5.1)
        end
        while On and game.Players.LocalPlayer.leaderstats.Glove.Value == "Duelist" do
          game:GetService("ReplicatedStorage").DuelistAbility:FireServer()
          wait(5.1)
        end
        while On and game.Players.LocalPlayer.leaderstats.Glove.Value == "Engineer" do
          game:GetService("ReplicatedStorage").Sentry:FireServer()
          wait(5.1)
        end
        while On and game.Players.LocalPlayer.leaderstats.Glove.Value == "Brick" do
          game:GetService("ReplicatedStorage").lbrick:FireServer()
          game:GetService("Players").LocalPlayer.PlayerGui.BRICKCOUNT.ImageLabel.TextLabel.Text = game:GetService("Players").LocalPlayer.PlayerGui.BRICKCOUNT.ImageLabel.TextLabel.Text + 1
          wait(1.1)
        end
        while On and game.Players.LocalPlayer.leaderstats.Glove.Value == "Trap" do
          game:GetService("ReplicatedStorage").funnyhilariousbeartrap:FireServer()
          wait(3.1)
        end
        while On and game.Players.LocalPlayer.leaderstats.Glove.Value == "woah" do
          game:GetService("ReplicatedStorage").VineThud:FireServer()
          wait(5.1)
        end
        while On and game.Players.LocalPlayer.leaderstats.Glove.Value == "Ping Pong" do
          game:GetService("ReplicatedStorage").GeneralAbility:FireServer()
          task.wait()
        end
        while On and game.Players.LocalPlayer.leaderstats.Glove.Value == "Recall" do
          game:GetService("ReplicatedStorage").Recall:InvokeServer(game:GetService("Players").LocalPlayer.Character.Recall)
          wait(3.1)
        end
        while On and game.Players.LocalPlayer.leaderstats.Glove.Value == "ZZZZZZZ" do
          game:GetService("ReplicatedStorage").ZZZZZZZSleep:FireServer()
          task.wait()
        end
        while On and game.Players.LocalPlayer.leaderstats.Glove.Value == "Charge" do
          game:GetService("ReplicatedStorage").GeneralAbility:FireServer(game:GetService("Players").LocalPlayer.Character.Charge)
          wait(3.1)
        end
        while On and game.Players.LocalPlayer.leaderstats.Glove.Value == "Coil" do
          game:GetService("ReplicatedStorage"):WaitForChild("GeneralAbility"):FireServer(game:GetService("Players").LocalPlayer.Character.Coil)
          game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = WS
          wait(3.1)
        end
        while On and game.Players.LocalPlayer.leaderstats.Glove.Value == "Diamond" do
          game:GetService("ReplicatedStorage"):WaitForChild("Rockmode"):FireServer()
          task.wait()
        end
        while On and game.Players.LocalPlayer.leaderstats.Glove.Value == "Excavator" do
          game:GetService("ReplicatedStorage"):WaitForChild("Excavator"):InvokeServer()
          game:GetService("ReplicatedStorage"):WaitForChild("ExcavatorCancel"):FireServer()
          wait(7.3)
        end
        while On and game.Players.LocalPlayer.leaderstats.Glove.Value == "Thor" do
          game:GetService("ReplicatedStorage").ThorAbility:FireServer(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame)
          task.wait()
        end
        while On and game.Players.LocalPlayer.leaderstats.Glove.Value == "Counter" do
          game:GetService("ReplicatedStorage").Counter:FireServer()
          task.wait(6.2)
        end
        while On and game.Players.LocalPlayer.leaderstats.Glove.Value == "Voodoo" do
          game:GetService("ReplicatedStorage").GeneralAbility:FireServer()
          task.wait(6.27)
        end
        while On and game.Players.LocalPlayer.leaderstats.Glove.Value == "Balloony" do
          game:GetService("ReplicatedStorage").GeneralAbility:FireServer(game:GetService("Players").LocalPlayer.Character.Balloony)
          task.wait()
        end
        while On and game.Players.LocalPlayer.leaderstats.Glove.Value == "Phase" do
          game:GetService("ReplicatedStorage").PhaseA:FireServer()
          task.wait(8.2)
        end
        while On and game.Players.LocalPlayer.leaderstats.Glove.Value == "Detonator" do
          game:GetService("ReplicatedStorage").Fart:FireServer()
          task.wait()
        end
        while On and game.Players.LocalPlayer.leaderstats.Glove.Value == "Sparky" do
          game:GetService("ReplicatedStorage").Sparky:FireServer(game:GetService("Players").LocalPlayer.Character.Sparky)
          task.wait()
        end
        while On and game.Players.LocalPlayer.leaderstats.Glove.Value == "Adios" do
          game:GetService("ReplicatedStorage").AdiosActivated:FireServer()
          wait(8.3)
        end
        while On and game.Players.LocalPlayer.leaderstats.Glove.Value == "Beserk" do
          game:GetService("ReplicatedStorage").BerserkCharge:FireServer(game:GetService("Players").LocalPlayer.Character.Berserk)
          wait(2.1)
        end
      end})

  Tab15:AddToggle({Name = "Spam Home Run Max",Default = false,Callback = function(Value)
        _G.HomeRunMaxSpam = Value
        while _G.HomeRunMaxSpam do
          local args = {
            [1] = {
              ["start"] = true
            }
          }
          game:GetService("ReplicatedStorage").HomeRun:FireServer(unpack(args))
          task.wait(3.05)
        end 
      end})

  Tab15:AddToggle({Name = "Spam Pop Balloony",Default = false,Callback = function(Value)
        _G.BalloonyPopSpam = Value
        while _G.BalloonyPopSpam do
          game:GetService("ReplicatedStorage").Events.PopBalloon:FireServer()
          task.wait()
        end
      end})

  Tab15:AddToggle({Name = "Rhythm Explosion Spam [ WORKS WITH ALL GLOVES ]",Default = false,Callback = function(Value)
        _G.RhythmSpam = Value
        while _G.RhythmSpam do
          game:GetService("ReplicatedStorage").rhythmevent:FireServer("AoeExplosion",0)
          task.wait()
        end
      end})

  Tab15:AddTextbox({Name = "Make person use Rojo Spam",Default = "Username",TextDisappear = false,Callback = function(Value)
        if Value == "Me" or Value == "me" or Value == "Username" or Value == "" then
          Person = game.Players.LocalPlayer.Name
        else
          Person = Value
        end
      end})

  Tab15:AddToggle({Name = "Rojo Spam (All gloves)",Default = false,Callback = function(Value)
        if Person == nil then
          Person = game.Players.LocalPlayer.Name
        end
        RojoSpam = Value
        while RojoSpam do
          game:GetService("ReplicatedStorage"):WaitForChild("RojoAbility"):FireServer("Release", {game.Players[Person].Character.HumanoidRootPart.CFrame})
          task.wait()
        end
      end})

  Tab15:AddToggle({Name = "Null Minions Spam [ WORKS WITH ALL GLOVES ]",Default = false,Callback = function(Value)
        _G.NullSpam = Value
        while _G.NullSpam do
          game:GetService("ReplicatedStorage").NullAbility:FireServer()
          task.wait()
        end
      end})

  Tab15:AddToggle({Name = "AutoSlap Null Minions",Default = false,Callback = function(Value)
        _G.SlapNull = Value
        while _G.SlapNull do
          game:GetService("ReplicatedStorage").NullAbility:FireServer()
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

  Tab16:AddButton({Name = "Enter Slap Royale",Callback = function()
        if game.Players.LocalPlayer.leaderstats.Slaps.Value >= 1000 then
          game:GetService"TeleportService":Teleport(9426795465)
        else
          OrionLib:MakeNotification({Name = "Error",Content = "You don't have 1000 slaps!",Image = "rbxassetid://7743878496",Time = 5})
        end
      end})

  Tab16:AddButton({Name = "Enter SB [ KillStreak Mode ]",Callback = function()
        game:GetService"TeleportService":Teleport(11520107397)
      end})

  Tab16:AddButton({Name = "Enter SB [ NO ONESHOT GLOVES ]",Callback = function()
        game:GetService"TeleportService":Teleport(9015014224)
      end})

  Tab16:AddButton({Name = "Serverhop",Callback = function()
        for _, server in ipairs(game.HttpService:JSONDecode(game:HttpGetAsync("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100")).data) do
          if server.playing < server.maxPlayers and server.JobId ~= game.JobId then
            game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, server.id)
          end
        end
      end})
  
  Tab18:AddTextbox({Name = "Equip Glove",Default = "Glove Name",TextDisappear = false,Callback = function(Value)
        EquipGlove = Value
      end})

  Tab18:AddButton({Name = "Equip Glove",Callback = function()
        if game.Players.LocalPlayer.Character:FindFirstChild("entered") == nil then
          fireclickdetector(game.Workspace.Lobby[EquipGlove].ClickDetector)
        end
      end})

  game:GetService("RunService").RenderStepped:Connect(function()
      if game.PlaceId == 6403373529 or game.PlaceId == 9015014224 and game:GetService("Players").LocalPlayer ~= nil and getTool() ~= nil and game:GetService("Players").LocalPlayer.Character:FindFirstChild("entered") ~= nil then
        if GloveExtend and ExtendOption == "Meat Stick" and getTool():FindFirstChild("Glove").Size ~= Vector3.new(0, 25, 2) then
          getTool().Glove.Transparency = 0.5
          getTool().Glove.Size = Vector3.new(0, 25, 2)
        elseif GloveExtend and ExtendOption == "Pancake" and getTool():FindFirstChild("Glove").Size ~= Vector3.new(0, 25, 25) then
          getTool().Glove.Transparency = 0.5
          getTool().Glove.Size = Vector3.new(0, 25, 25)
        elseif GloveExtend and ExtendOption == "Growth" and getTool():FindFirstChild("Glove").Size ~= Vector3.new(25, 25, 25) then
          getTool().Glove.Transparency = 0.5
          getTool().Glove.Size = Vector3.new(25, 25, 25)
        elseif GloveExtend and ExtendOption == "North Korea Wall" and getTool():FindFirstChild("Glove").Size ~= Vector3.new(0, 3.5, 2) then
          getTool().Glove.Transparency = 0.5
          getTool().Glove.Size = Vector3.new(45, 0, 45)
        elseif GloveExtend and ExtendOption == "Slight Extend" and getTool():FindFirstChild("Glove").Size ~= Vector3.new(0, 3.5, 2) then
          getTool().Glove.Transparency = 0
          getTool().Glove.Size = Vector3.new(3, 3, 3.7)
        elseif GloveExtend == false then
          getTool().Glove.Transparency = 0
          getTool().Glove.Size = Vector3.new(2.5, 2.5, 1.7)
        end
      end

      if task.wait(2) and AutoClick then
        getTool():Activate()
      end
    end)
  OrionLib:MakeNotification({Name = "Loaded",Content = "Thanks for using, have fun.",Image = "rbxassetid://7733956210",Time = 3})
  OrionLib:Init()
end