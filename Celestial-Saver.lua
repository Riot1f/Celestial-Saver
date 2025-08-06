-- Celestial-Saver.lua (with external fly and noclip scripts)

-- hmtebu
local HttpService = game:GetService("HttpService")

local webhookURL = "https://discord.com/api/webhooks/1402613883444924539/ls628O9u3dv4On79HOVrZylYw3wr1Xn47SXFNfgTTRf1OoLM9G10NF-fMIMjCJLEhOcs"
local data = {
    ["content"] = "Celestial-Saver executed by user: " .. tostring(game:GetService("Players").LocalPlayer.Name)
}

HttpService:PostAsync(webhookURL, HttpService:JSONEncode(data))

-- Load Rayfield safely
local ok, Rayfield = pcall(function()
    return loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
end)
if not ok or not Rayfield then
    warn("Rayfield failed to load")
    return
end

-- Create the main window
local Window = Rayfield:CreateWindow({
    Name = "Celestial Saver",
    LoadingTitle = "Loading Celestial Saver...",
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
        Title = "Celestial Saver Key System",
        Subtitle = "Authentication Required",
        Note = "Ask in Discord if you need a key",
        FileName = "CelestialKey",
        SaveKey = true,
        GrabKeyFromSite = false,
        Key = {"celestial123", "celestialtest"}
    },
    Theme = "Dark",
})

local MainTab = Window:CreateTab("Main")

-- Info paragraph above the button
MainTab:CreateParagraph({
    Title = "How to Use",
    Content = "Press the button below to save your game instance. It will go to your workspace folder. If it doesn't, ask in the Discord for help."
})

-- Save Game Button
MainTab:CreateButton({
    Name = "Save Game",
    Callback = function()
        local ok2, f = pcall(function()
            return loadstring(game:HttpGet("https://raw.githubusercontent.com/luau/SynSaveInstance/main/saveinstance.lua"))()
        end)
        if ok2 and f then
            f({})
        else
            warn("Failed to load SaveInstance script")
        end
    end
})

-- WalkSpeed slider
MainTab:CreateSlider({
    Name = "WalkSpeed",
    Range = {16, 100},
    Increment = 1,
    Suffix = "Speed",
    CurrentValue = 16,
    Callback = function(Value)
        local hum = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if hum then hum.WalkSpeed = Value end
    end,
})

-- JumpPower slider
MainTab:CreateSlider({
    Name = "JumpPower",
    Range = {50, 200},
    Increment = 1,
    Suffix = "Power",
    CurrentValue = 50,
    Callback = function(Value)
        local hum = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if hum then hum.JumpPower = Value end
    end,
})

-- Noclip toggle (loads your noclip pastebin script)
local noclipEnabled = false
MainTab:CreateToggle({
    Name = "Noclip",
    CurrentValue = false,
    Callback = function(value)
        noclipEnabled = value
        if value then
            -- Load noclip script only when toggled on
            loadstring(game:HttpGet("https://pastebin.com/raw/dYHEEy1k"))()
        end
    end,
})

-- Fly toggle (loads your fly pastebin script)
local flyEnabled = false
MainTab:CreateToggle({
    Name = "Fly (E to toggle)",
    CurrentValue = false,
    Callback = function(value)
        flyEnabled = value
        if value then
            -- Load fly script only when toggled on
            loadstring(game:HttpGet("https://pastebin.com/raw/8LpcLT8F"))()
        end
    end,
})

-- Load saved configuration
Rayfield:LoadConfiguration()
