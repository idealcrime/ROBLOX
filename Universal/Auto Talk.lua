getgenv().AutoTalk_Settings = {
    Keybind = "m",
    Texts = {"1", "2", "3"}
}

if not Already_Loaded then
    getgenv().Already_Loaded = true
    local UserInputService = game:GetService("UserInputService")
    UserInputService.InputBegan:Connect(function(Key)
        if not (UserInputService:GetFocusedTextBox()) then
            if Key == Enum.KeyCode[AutoTalk_Settings.Keybind:upper()] then
                game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(AutoTalk_Settings.Texts[math.random(1, #AutoTalk_Settings.Texts)], "All")
            end
        end
    end)
end
