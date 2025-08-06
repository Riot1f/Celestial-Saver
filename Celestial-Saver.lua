local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "NovaX-Saver",
    LoadingTitle = "NovaX-Saver Loader",
    LoadingSubtitle = "by CC",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "NovaXSaverConfig",  -- Your custom folder name
        FileName = "Settings",            -- Your config file name
    },
    Discord = {
        Enabled = false,  -- Set true if you want a Discord join prompt
        Invite = "",      -- Your invite code (no discord.gg/ prefix)
        RememberJoins = true,
    },
    KeySystem = false,  -- Change to true later if you want a key system
    KeySettings = {
        Title = "NovaX-Saver Key System",
        Subtitle = "Enter your key below",
        Note = "Please get your key from your source",
        FileName = "Key",
        SaveKey = true,
        GrabKeyFromSite = false,
        Key = {"YourKeyHere"}  -- List of valid keys or URLs to keys
    },
    ToggleUIKeybind = "K", -- Press K to toggle GUI
    Theme = "Default",
})

local MainTab = Window:CreateTab("Main")

MainTab:CreateButton({
    Name = "Copy",
    Callback = function()
        local ok, synsave = pcall(function()
            return loadstring(game:HttpGet("https://raw.githubusercontent.com/luau/SynSaveInstance/main/saveinstance.lua"))()
        end)

        if not ok or not synsave then
            warn("Failed to load SaveInstance script")
            return
        end

        synsave({})
    end
})

-- Loads saved config automatically (very important)
Rayfield:LoadConfiguration()
