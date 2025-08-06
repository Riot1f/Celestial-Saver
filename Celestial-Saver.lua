local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "Celestial-Saver",
    LoadingTitle = "Loading Celestial-Saver...",
    LoadingSubtitle = "made by Celestial",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "CelestialSaverConfig",
        FileName = "Settings",
    },
    Discord = {
        Enabled = true,
        Invite = "Y9xHnZN5yr",
        RememberJoins = true,
    },
    KeySystem = true,
    KeySettings = {
        Title = "Celestial-Saver Key System",
        Subtitle = "Enter your key below to continue",
        Note = "Join our Discord for keys and support",
        FileName = "Key",
        SaveKey = true,
        GrabKeyFromSite = false,
        Key = {"Celestial123", "Key2025"}
    },
    ToggleUIKeybind = "K",
    Theme = "Dark",
})

local MainTab = Window:CreateTab("Main")

MainTab:CreateSection("Press the button above to save your game instance, it will go to your workspace folder if it doesn't ask the discord for help.")

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

Rayfield:LoadConfiguration()
