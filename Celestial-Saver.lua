-- Celestial-Saver.lua (Final Polished Version)

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

-- Fly toggle (custom fly)
local flying = false
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local LP = game.Players.LocalPlayer
local HRP = nil

MainTab:CreateToggle({
    Name = "Fly (E to toggle)",
    CurrentValue = false,
    Callback = function(Value)
        flying = Value
        HRP = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
    end
})

UIS.InputBegan:Connect(function(input, gpe)
    if not gpe and input.KeyCode == Enum.KeyCode.E then
        flying = not flying
        HRP = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
    end
end)

local speed = 3
RunService.RenderStepped:Connect(function()
    if flying and HRP then
        local cf = workspace.CurrentCamera.CFrame
        HRP.Velocity = (cf.LookVector * speed * (UIS:IsKeyDown(Enum.KeyCode.W) and 1 or 0)) +
                       (cf.RightVector * speed * (UIS:IsKeyDown(Enum.KeyCode.D) and 1 or 0)) +
                       (-cf.RightVector * speed * (UIS:IsKeyDown(Enum.KeyCode.A) and 1 or 0)) +
                       (Vector3.new(0, speed, 0) * (UIS:IsKeyDown(Enum.KeyCode.Space) and 1 or 0)) +
                       (Vector3.new(0, -speed, 0) * (UIS:IsKeyDown(Enum.KeyCode.LeftControl) and 1 or 0))
    end
end)

-- Load saved configuration
Rayfield:LoadConfiguration()
