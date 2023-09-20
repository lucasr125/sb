local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local ESPObjects = {}
local ESPEnabled = true
local ESPColor = Color3.new(1, 0, 1)
local ESPTextColor = Color3.new(1, 0, 0)
local ShowName = true
local ShowHealth = true
local ShowDistance = true
local ShowGlove = true

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

local function ToggleESP()
    ESPEnabled = not ESPEnabled
    if not ESPEnabled then
        ClearESP()
    end
end

local function ToggleInformation(type)
    if type == "Name" then
        ShowName = not ShowName
    elseif type == "Health" then
        ShowHealth = not ShowHealth
    elseif type == "Distance" then
        ShowDistance = not ShowDistance
    elseif type == "Glove" then
        ShowGlove = not ShowGlove
    end
    UpdateESP()
end

UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.N then
        ToggleInformation("Name")
    elseif input.KeyCode == Enum.KeyCode.H then
        ToggleInformation("Health")
    elseif input.KeyCode == Enum.KeyCode.F then
        ToggleInformation("Distance")
    elseif input.KeyCode == Enum.KeyCode.G then
        ToggleInformation("Glove")
    end
end)

UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.Q then
        ToggleESP()
    end
end)
