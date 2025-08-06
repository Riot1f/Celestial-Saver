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
        GrabKeyFromSite = false,  -- change to true to fetch keys remotely
        Key = {"Celestial123", "Key2025"} -- your allowed keys here
    },
    ToggleUIKeybind = "K",
    Theme = "Dark",
})

local MainTab = Window:CreateTab("Main")

-- Custom container to center the button nicely and scale it bigger
local Section = MainTab:CreateSection("")

local Button = MainTab:CreateButton({
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

-- Optional: Style the button with Rayfield methods if available
-- Rayfield does not natively support button size, but you can add descriptive text or multiple sections for layout.

Rayfield:LoadConfiguration()
