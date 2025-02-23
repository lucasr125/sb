if not isfile("lastRequest.txt") then
    createfile("lastRequest.txt")
    writefile("lastRequest.txt", tostring(os.time()))
end

local function safeHttpGet(url)
    local cooldown = 5
    local lastTime = tonumber(readfile("lastRequest.txt")) or 0
    local currentTime = os.time()
    if currentTime - lastTime < cooldown then
        task.wait(cooldown - (currentTime - lastTime))
    end
    local response
    local success = pcall(function()
        response = game:HttpGet(url)
    end)
    if success and response then
        writefile("lastRequest.txt", tostring(os.time()))
        return response
    elseif response and response:find("429") then
        task.wait(cooldown)
        return safeHttpGet(url)
    else
        return nil
    end
end

if not game:IsLoaded() then
    game.Loaded:Wait()
end

if game.PlaceId == 6403373529 or game.PlaceId == 9015014224 or game.PlaceId == 11520107397 then
    local teleportFunc = queueonteleport or queue_on_teleport or (syn and syn.queue_on_teleport)
    if teleportFunc then
        teleportFunc([[
if not isfile("lastRequest.txt") then
    createfile("lastRequest.txt")
    writefile("lastRequest.txt", tostring(os.time()))
end

local function safeHttpGet(url)
    local cooldown = 5
    local lastTime = tonumber(readfile("lastRequest.txt")) or 0
    local currentTime = os.time()
    if currentTime - lastTime < cooldown then
        task.wait(cooldown - (currentTime - lastTime))
    end
    local response
    local success = pcall(function()
        response = game:HttpGet(url)
    end)
    if success and response then
        writefile("lastRequest.txt", tostring(os.time()))
        return response
    elseif response and response:find("429") then
        task.wait(cooldown)
        return safeHttpGet(url)
    else
        return nil
    end
end

repeat task.wait() until game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
for i, v in pairs(game:GetService("Workspace"):WaitForChild("CandyCorns"):GetChildren()) do  
    if v:FindFirstChildWhichIsA("TouchTransmitter") then  
        firetouchinterest(game.Players.LocalPlayer.Character.Head, v, 0)  
        firetouchinterest(game.Players.LocalPlayer.Character.Head, v, 1)  
    end  
end  
task.wait(0.8)
if game.Players.LocalPlayer.Character:FindFirstChild("entered") == nil then
    firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, workspace.Lobby.Teleport2, 0) 
    firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, workspace.Lobby.Teleport2, 1) 
end
task.wait(0.11)  
for i, v in ipairs(workspace.Arena.island5.Slapples:GetDescendants()) do  
    if game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and game.Players.LocalPlayer.Character:FindFirstChild("entered") and v.Name == "Glove" and v:FindFirstChildWhichIsA("TouchTransmitter") then  
        firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v, 0)  
        firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v, 1)  
    end  
end  
task.wait(0.6)
loadstring(safeHttpGet("https://raw.githubusercontent.com/lucasr125/sb/refs/heads/main/Logical.lua"))()
        ]])
    end

    local serverList = {}
    local serversData = safeHttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100")
    if serversData then
        local decoded = game:GetService("HttpService"):JSONDecode(serversData)
        for _, v in ipairs(decoded.data) do
            if v.playing and type(v) == "table" and v.maxPlayers > v.playing and v.id ~= game.JobId then
                serverList[#serverList + 1] = v.id
            end
        end
    end
    if #serverList > 0 then
        game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, serverList[math.random(1, #serverList)])
    end
end
