if not AimViewer_Settings then
    getgenv().AimViewer_Settings = {
        LocalPlayer = true,
        Keybind = "x",
        FromColor = Color3.fromRGB(255, 255, 255),
        MiddleColor = Color3.fromRGB(255/2, 255/2, 255/2),
        ToColor = Color3.fromRGB(0, 0, 0),
        Size = 0.25,
        Part = "Head"
    }
end

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local Attachment0 = Instance.new("Attachment")
local Attachment1 = Instance.new("Attachment")

Attachment0.Parent = workspace.Terrain
Attachment1.Parent = workspace.Terrain

local AimBeam = Instance.new("Beam", workspace)
AimBeam.Attachment0 = Attachment0
AimBeam.Attachment1 = Attachment1
AimBeam.Width0 = AimViewer_Settings.Size
AimBeam.Width1 = AimViewer_Settings.Size
AimBeam.Color = ColorSequence.new {ColorSequenceKeypoint.new(0, AimViewer_Settings.FromColor), ColorSequenceKeypoint.new(0.5, AimViewer_Settings.MiddleColor), ColorSequenceKeypoint.new(1, AimViewer_Settings.ToColor)}
AimBeam.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 0)})

local Target

local function getClosestPlayerToCursor()
    local ClosestPlayer, ShortestDistance = nil, math.huge
    local Mouse_Position = UserInputService:GetMouseLocation()
    for _, Player in next, Players:GetPlayers() do
        if (Player ~= LocalPlayer or (AimViewer_Settings.LocalPlayer)) and Player.Character and Player.Character:FindFirstChild(AimViewer_Settings.Part) then
            local Position, IsVisible = Camera:WorldToViewportPoint(Player.Character.PrimaryPart.Position)
            local Distance = (Vector2.new(Position.X, Position.Y) - Mouse_Position).Magnitude
            if IsVisible and Distance < ShortestDistance then
                ClosestPlayer = Player
                ShortestDistance = Distance
            end
        end
    end
    return ClosestPlayer
end

UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
    if gameProcessedEvent then
        return
    end
    if input.KeyCode == Enum.KeyCode[AimViewer_Settings.Keybind:upper()] then
        if Target ~= nil then
            Target = nil
        else
            Target = getClosestPlayerToCursor()
        end
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = Target ~= nil and Target.DisplayName or "Disabled",
            Text = Target ~= nil and Target.Name or "",
            Duration = 0.5
        })
    end
end)

local function Checks(Player)
    if Players:FindFirstChild(tostring(Player)) then
        local Tool = Player.Character:FindFirstChildWhichIsA("Tool")
        local hasToolEquipped = (Tool and (Tool:FindFirstChild("GunScript") or Tool:FindFirstChild("Script") or Tool:FindFirstChild("serverinfo")))
        local isAlive = (Player.Character and Player.Character:FindFirstChild("HumanoidRootPart"))
        return (isAlive ~= nil and true) and (hasToolEquipped ~= nil and true)
    end
    return false
end

RunService.Heartbeat:Connect(function()
    if Target ~= nil and Checks(Target) then
        Attachment0.Position = Target.Character[AimViewer_Settings.Part].Position
        Attachment1.Position = Target.Character.BodyEffects.MousePos.Value
    else
        Attachment0.Position = Vector3.new(1e9, 1e9, 1e9)
        Attachment1.Position = Vector3.new(1e9, 1e9, 1e9)
    end
end)
