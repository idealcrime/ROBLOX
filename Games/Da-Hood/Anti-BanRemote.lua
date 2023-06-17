local DetectedArguments = {"TeleportDetect", "CHECKER_1", "CHECKER", "GUI_CHECK", "OneMoreTime", "checkingSPEED", "BANREMOTE", "PERMAIDBAN"}
local OldNamecall
OldNamecall = hookmetamethod(game, "__namecall", newcclosure(function(Self, ...)
    local Arguments = {...}
    if table.find(DetectedArguments, Arguments[1]) then
        return
    end
    return OldNamecall(...)
end))
