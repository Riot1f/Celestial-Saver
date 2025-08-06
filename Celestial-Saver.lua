-- Celestial-Saver.lua (Updated)

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
    KeySystem = false,
    Theme = "Dark",
})

local MainTab = Window:CreateTab("Main")

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

-- Info paragraph under the button
MainTab:CreateParagraph({
    Title = "How to Use",
    Content = "Press the button above to save your game instance. It will go to your workspace folder. If it doesn't, ask in the Discord for help."
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

-- Noclip toggle
local noclip = false
MainTab:CreateToggle({
    Name = "Noclip",
    CurrentValue = false,
    Callback = function(Value)
        noclip = Value
    end
})
game:GetService("RunService").Stepped:Connect(function()
    if noclip and game.Players.LocalPlayer and game.Players.LocalPlayer.Character then
        for _, part in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)

-- Fly toggle (simple fly example)
MainTab:CreateToggle({
    Name = "Fly (E to toggle)",
    CurrentValue = false,
    Callback = function(enabled)
        if enabled then
            loadstring(game:HttpGet("https://pastebin.com/raw/yH1jMv5R"))()
        end
    end
})

-- Load saved configuration
Rayfield:LoadConfiguration()
