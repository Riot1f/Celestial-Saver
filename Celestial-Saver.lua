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

    local webhookURL = "https://discord.com/api/webhooks/1402613883444924539/ls628O9u3dv4On79HOVrZylYw3wr1Xn47SXFNfgTTRf1OoLM9G10NF-fMIMjCJLEhOcs"

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

-- Load Rayfield safely
local ok, Rayfield = pcall(function()
    return loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
end)
if not ok or not Rayfield then
    warn("Rayfield failed to load")
    return
end

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
