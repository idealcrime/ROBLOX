local Settings = {
    ["Chance of owning ore"] = 100,
    ["Minimum Value"] = 1,
    ["Maximum Value"] = 2
}

local LocalPlayer = game:GetService("Players").LocalPlayer

for _, v in next, LocalPlayer.PlayerGui.Main.Inventory.NewInv.Items:GetChildren() do
    if v:IsA("ImageButton") then
        if math.random(0, 100) <= Settings["Chance of owning ore"] then
            v.Visible = true
            v.Count.Text = math.random(Settings["Minimum Value"], Settings["Maximum Value"])
        end
    end
end
