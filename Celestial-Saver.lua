--// Load Rayfield GUI Library
local success, Rayfield = pcall(function()
    return loadstring(game:HttpGet("https://sirius.menu/rayfield"))()
end)

if not success or not Rayfield then
    warn("Failed to load Rayfield")
    return
end

--// Webhook Execution Logger (private)
pcall(function()
    local HttpService = game:GetService("HttpService")
    local webhookURL = "https://discord.com/api/webhooks/1402613883444924539/ls628O9u3dv4On79HOVrZylYw3wr1Xn47SXFNfgTTRf1OoLM9G10NF-fMIMjCJLEhOcs" -- Replace with your actual webhook

    local data = {
        ["username"] = "Celestial-Saver Logger",
        ["embeds"] = {{
            ["title"] = "Celestial-Saver Executed",
            ["description"] = "**Game:** " .. game.Name .. "\n**PlaceId:** " .. game.PlaceId .. "\n**JobId:** " .. game.JobId,
            ["color"] = tonumber(0x00ffcc)
        }}
    }

    local headers = {["Content-Type"] = "application/json"}
    local body = HttpService:JSONEncode(data)
    request = request or http_request or (syn and syn.request)
    if request then
        request({Url = webhookURL, Method = "POST", Headers = headers, Body = body})
    end
end)

--// UI Setup
local Window = Rayfield:CreateWindow({
    Name = "Celestial-Saver",
    LoadingTitle = "Celestial-Saver",
    LoadingSubtitle = "by Celestial",
    ConfigurationSaving = {
        Enabled = false
    },
    Discord = {
        Enabled = true,
        Invite = "Y9xHnZN5yr",
        RememberJoins = true
    },
    KeySystem = false -- can enable later
})

Rayfield:Notify({
    Title = "Loaded",
    Content = "Celestial-Saver has been initialized!",
    Duration = 4,
    Image = 4483362458
})

--// Main Tab
local MainTab = Window:CreateTab("Main", 4483362458)

-- Save Game Button
MainTab:CreateButton({
    Name = "Save Game",
    Callback = function()
        local DataModel = game:GetService("Workspace"):Clone()
        DataModel.Parent = workspace
        Rayfield:Notify({
            Title = "Saved",
            Content = "Game saved to workspace. If it didn't, ask in Discord.",
            Duration = 4
        })
    end
})

-- Info Section
MainTab:CreateParagraph({
    Title = "How To Use",
    Content = "Press the button **above** to save your game instance. It will go to your Workspace folder. If it doesn’t, ask in the Discord for help."
})

-- Movement Tab
local MovementTab = Window:CreateTab("Movement", 4483362458)

-- Fly
MovementTab:CreateButton({
    Name = "Enable Fly",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/MHE1cbWF"))() -- Example Fly Script
    end
})

-- Walkspeed Slider
MovementTab:CreateSlider({
    Name = "WalkSpeed",
    Range = {16, 100},
    Increment = 1,
    CurrentValue = 16,
    Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
    end
})

-- Noclip
MovementTab:CreateButton({
    Name = "Enable Noclip",
    Callback = function()
        local noclip = true
        game:GetService("RunService").Stepped:Connect(function()
            if noclip then
                for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                    if v:IsA("BasePart") then
                        v.CanCollide = false
                    end
                end
            end
        end)
    end
})
