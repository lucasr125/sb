if not game:IsLoaded() then
    game.Loaded:Wait()
end

if game.PlaceId == 6403373529 or game.PlaceId == 9015014224 or game.PlaceId == 11520107397 then
    local teleportFunc = queueonteleport or queue_on_teleport or (syn and syn.queue_on_teleport)
    if teleportFunc then
        teleportFunc([[
            repeat task.wait() until game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            for _, v in pairs(game:GetService("Workspace"):WaitForChild("CandyCorns"):GetChildren()) do  
                if v:FindFirstChildWhichIsA("TouchTransmitter") then  
                    firetouchinterest(game.Players.LocalPlayer.Character.Head, v, 0)  
                    firetouchinterest(game.Players.LocalPlayer.Character.Head, v, 1)  
                end  
            end  
            task.wait(0.8)
            if not game.Players.LocalPlayer.Character:FindFirstChild("entered") then
                firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, workspace.Lobby.Teleport1, 0) 
                firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, workspace.Lobby.Teleport1, 1) 
            end
            task.wait(0.11)  
            for _, v in ipairs(workspace.Arena.island5.Slapples:GetDescendants()) do  
                if game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and game.Players.LocalPlayer.Character:FindFirstChild("entered") and v.Name == "Glove" and v:FindFirstChildWhichIsA("TouchTransmitter") then  
                    firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v, 0)  
                    firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v, 1)  
                end  
            end  
            task.wait(0.6)
            loadstring(game:HttpGet("https://raw.githubusercontent.com/Giangplay/Slap-Battles-and-Ability-wars/main/AutoFarm%20Candy%20Slapple.lua"))()
        ]])
    end

    local HttpService = game:GetService("HttpService")
    local TeleportService = game:GetService("TeleportService")
    local url = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"
    local serverData, retries, maxRetries = nil, 0, 5

    repeat
        local success, result = pcall(function()
            return game:HttpGetAsync(url)
        end)
        if success then
            serverData = result
        else
            if result:find("429") then
                task.wait(2)
            else
                warn("HTTP error: " .. result)
                break
            end
        end
        retries = retries + 1
    until serverData or retries >= maxRetries

    if serverData then
        local data = HttpService:JSONDecode(serverData)
        local serverList = {}
        for _, v in ipairs(data.data) do
            if v.playing and type(v) == "table" and v.maxPlayers > v.playing and v.id ~= game.JobId then
                table.insert(serverList, v.id)
            end
        end
        if #serverList > 0 then
            TeleportService:TeleportToPlaceInstance(game.PlaceId, serverList[math.random(1, #serverList)])
        else
            warn("No available servers found.")
        end
    else
        warn("Failed to fetch server data after retries.")
    end
end
