--// Webhook Execution Logger (private)
pcall(function()
    local HttpService = game:GetService("HttpService")
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer

    -- Track executions locally via file save (works if executor supports writefile/readfile)
    local folderName = "CelestialSaverConfig"
    local fileName = "ExecutionCount.txt"
    local count = 0

    local success, content = pcall(function()
        return readfile(folderName .. "/" .. fileName)
    end)

    if success and content then
        count = tonumber(content) or 0
    end

    count = count + 1

    -- Save updated count
    pcall(function()
        writefile(folderName .. "/" .. fileName, tostring(count))
    end)

    local webhookURL = "https://discord.com/api/webhooks/1402625783549268008/wVXj6NRp3vQ92gOqGt0tnIwzi8sRF4j0p6nYOa42M5wRF2HgQv2ccoHYa0c25NIj4uhD"

    local data = {
        ["username"] = "Celestial-Saver Logger",
        ["embeds"] = {{
            ["title"] = "Celestial-Saver Executed",
            ["description"] =
                "**User:** " .. (LocalPlayer and LocalPlayer.Name or "Unknown") .. "\n" ..
                "**Game:** " .. game.Name .. "\n" ..
                "**PlaceId:** " .. game.PlaceId .. "\n" ..
                "**JobId:** " .. game.JobId .. "\n" ..
                "**Times Executed:** " .. count .. "\n" ..
                "**Time Executed:** " .. os.date("%Y-%m-%d %H:%M:%S"),
            ["color"] = tonumber(0x00ffcc)
        }}
    }

    local headers = {["Content-Type"] = "application/json"}
    local body = HttpService:JSONEncode(data)
    local request = request or http_request or (syn and syn.request)
    if request then
        request({Url = webhookURL, Method = "POST", Headers = headers, Body = body})
    end
end)

-- Key expiry check (run once before window creation)
do
    local keyFile = "CelestialSaverConfig/CelestialKey"
    local expiryFile = "CelestialSaverConfig/CelestialKeyExpiry"

    local function deleteKey()
        if isfile(keyFile) then delfile(keyFile) end
        if isfile(expiryFile) then delfile(expiryFile) end
    end

    local expired = false
    if isfile(expiryFile) then
        local expiry = tonumber(readfile(expiryFile))
        if expiry and os.time() > expiry then
            expired = true
        end
    end

    if expired then
        deleteKey()
    end
end

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
        Note = "Join the Discord to get the key: .gg/Y9xHnZN5yr",
        FileName = "CelestialKey",
        SaveKey = true,
        GrabKeyFromSite = false,
        Key = {"celestial123456"},
        Callback = function(success)
            if success then
                pcall(function()
                    writefile("CelestialSaverConfig/CelestialKeyExpiry", tostring(os.time() + 86400)) -- expires in 1 day
                end)
            end
        end,
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

local MovementTab = Window:CreateTab("Movement")

-- WalkSpeed slider
MovementTab:CreateSlider({
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
MovementTab:CreateSlider({
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
local noclipEnabled = false
MovementTab:CreateToggle({
    Name = "Noclip",
    CurrentValue = false,
    Callback = function(value)
        noclipEnabled = value
        if value then
            loadstring(game:HttpGet("https://pastebin.com/raw/dYHEEy1k"))()
        end
    end,
})

-- Fly toggle
local flyEnabled = false
MovementTab:CreateToggle({
    Name = "Fly (E to toggle)",
    CurrentValue = false,
    Callback = function(value)
        flyEnabled = value
        if value then
            loadstring(game:HttpGet("https://pastebin.com/raw/8LpcLT8F"))()
        end
    end,
})
