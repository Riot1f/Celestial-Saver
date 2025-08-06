-- Celestial Saver - Made by Celestial
local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Rayfield/main/source.lua"))()

-- Discord Prompt
Rayfield:Notify({
    Title = "Celestial Saver",
    Content = "Join the Discord: discord.gg/Y9xHnZN5yr",
    Duration = 6.5,
    Image = 4483362458,
    Actions = {
        Ignore = {
            Name = "Okay",
            Callback = function() end
        },
    },
})

local Window = Rayfield:CreateWindow({
    Name = "Celestial Saver | Made by Celestial",
    LoadingTitle = "Celestial Saver",
    LoadingSubtitle = "Saving with style...",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "CelestialSaver",
        FileName = "CelestialConfig"
    },
    Discord = {
        Enabled = true,
        Invite = "Y9xHnZN5yr",
        RememberJoins = true
    },
    KeySystem = false,
})

-- Tab
local MainTab = Window:CreateTab("Main", 4483362458)

-- Save Game Button
MainTab:CreateButton({
    Name = "Save Game",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/therandomdevstuff/NovaX-Saver/main/NovaX-Saver.lua"))()
    end,
})

-- Info Text (appears below)
MainTab:CreateParagraph({
    Title = "How to Use",
    Content = "Press the button below to save your game instance. It will go to your workspace folder. If it doesn't, ask in the Discord for help."
})

-- WalkSpeed Slider
MainTab:CreateSlider({
    Name = "WalkSpeed",
    Range = {16, 100},
    Increment = 1,
    Suffix = "Speed",
    CurrentValue = 16,
    Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
    end,
})

-- JumpPower Slider
MainTab:CreateSlider({
    Name = "JumpPower",
    Range = {50, 200},
    Increment = 1,
    Suffix = "Power",
    CurrentValue = 50,
    Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
    end,
})

-- Noclip Toggle
local noclip = false
MainTab:CreateToggle({
    Name = "Noclip",
    CurrentValue = false,
    Callback = function(Value)
        noclip = Value
    end,
})
game:GetService("RunService").Stepped:Connect(function()
    if noclip and game.Players.LocalPlayer.Character then
        for _, part in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)

-- Fly Toggle
MainTab:CreateToggle({
    Name = "Fly (E to toggle)",
    CurrentValue = false,
    Callback = function(enabled)
        if enabled then
            loadstring(game:HttpGet("https://pastebin.com/raw/yH1jMv5R"))() -- simple fly script
        end
    end,
})
