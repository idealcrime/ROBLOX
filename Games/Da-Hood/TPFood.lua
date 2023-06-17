getgenv().FoodTP_Settings = {
    Enabled = true,
    Keybind = "h"
}

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local State = false
local Shop = workspace.Ignored.Shop
local Foods = {"[Pizza] - $5", "[Chicken] - $7", "[Popcorn] - $7", "[Lettuce] - $5", "[Hamburger] - $5", "[Taco] - $4", "[HotDog] - $8", "[Meat] - $12"}

UserInputService.InputBegan:Connect(function(input)
    if not FoodTP_Settings.Enabled or State == true then
        return
    end
    if input.KeyCode == Enum.KeyCode[FoodTP_Settings.Keybind:upper()] then
        State = true
        local Old, OldV = Local.Player.Character.HumanoidRootPart.CFrame, Local.Player.Character.HumanoidRootPart.Velocity
        for _, v in next, Foods do
            local CurrentFood = Shop[v]
            LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(CurrentFood.Head.Position)
            task.wait(0.85)
            fireclickdetector(CurrentFood.ClickDetector)
        end
        LocalPlayer.Character.HumanoidRootPart.CFrame = Old
        LocalPlayer.Character.HumanoidRootPart.Velocity = OldV
        State = false
    end
end)
