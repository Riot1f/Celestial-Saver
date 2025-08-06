local success, RayfieldLib = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Rayfield/main/source"))()
end)

if not success then
    warn("Rayfield failed to load.")
    return
end

local Window = RayfieldLib:CreateWindow({
    Name = "NovaX-Saver",
    ConfigurationSaving = {
        Enabled = false
    }
})

local Tab = Window:CreateTab("Main")

Tab:CreateButton({
    Name = "Copy",
    Callback = function()
        local success, synsave = pcall(function()
            return loadstring(game:HttpGet("https://raw.githubusercontent.com/luau/SynSaveInstance/main/saveinstance.lua"))()
        end)

        if success and synsave then
            local Options = {} -- Put options here if needed
            synsave(Options)
        else
            warn("Failed to load SynSaveInstance.")
        end
    end
})
