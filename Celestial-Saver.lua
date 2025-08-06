--// Webhook Execution Logger (private)
pcall(function()
    local HttpService = game:GetService("HttpService")
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer

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

    pcall(function()
        -- Make sure folder exists or create it
        if not isfolder then
            warn("Executor does not support isfolder")
        else
            if not isfolder(folderName) then
                makefolder(folderName)
            end
        end
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

local HttpService = game:GetService("HttpService")
local folderName = "CelestialSaverConfig"
local keyFileName = "CelestialKey.txt"
local timeFileName = "KeyTime.txt"

-- Utility to read file safely
local function readFileSafe(path)
    local success, result = pcall(function() return readfile(path) end)
    if success then return result end
    return nil
end

-- Utility to write file safely
local function writeFileSafe(path, content)
    pcall(function() writefile(path, content) end)
end

-- Ensure folder exists for file ops
if isfolder and not isfolder(folderName) then
    makefolder(folderName)
end

local function isKeyValid(key)
    return key == "celestial123456"
end

local function isKeyExpired()
    local timeStr = readFileSafe(folderName .. "/" .. timeFileName)
    if not timeStr then return true end
    local lastTime = tonumber(timeStr)
    if not lastTime then return true end
    local currentTime = os.time()
    return (currentTime - lastTime) > 86400
end

local storedKey = readFileSafe(folderName .. "/" .. keyFileName)
local hasValidKey = storedKey and isKeyValid(storedKey) and not isKeyExpired()

-- Load Rayfield once here
local ok, Rayfield = pcall(function()
    return loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
end)
if not ok or not Rayfield then
    warn("Rayfield failed to load")
    return
end

-- Main GUI creation function (pass Rayfield explicitly)
local function createMainGui()
    local Window = Rayfield:CreateWindow({
        Name = "Celestial Saver",
        LoadingTitle = "Loading Celestial Saver...",
        LoadingSubtitle = "made by Celestial",
        ConfigurationSaving = {
            Enabled = true,
            FolderName = folderName,
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

    MainTab:CreateParagraph({
        Title = "How to Use",
        Content = "Press the button below to save your game instance. It will go to your workspace folder. If it doesn't, ask in the Discord for help."
    })

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
end

-- Key prompt window function (does NOT destroy Rayfield, just hides window)
local function createKeyPrompt()
    local KeyWindow = Rayfield:CreateWindow({
        Name = "Celestial Saver - Key System",
        LoadingTitle = "Please enter your key",
        LoadingSubtitle = "Join Discord: https://discord.gg/Y9xHnZN5yr\nVisit: https://workink.net/22BW/Celestial Saver Key System",
        ConfigurationSaving = {
            Enabled = false
        },
        Theme = "Dark",
        KeySystem = true,
        KeySettings = {
            Title = "Celestial Saver Key System",
            Subtitle = "Authentication Required",
            Note = "Join the Discord to get your key. Key expires daily. Enter key below:",
            FileName = keyFileName,
            SaveKey = true,
            GrabKeyFromSite = false,
            Key = {"celestial123456"},
            Callback = function(key)
                if isKeyValid(key) then
                    writeFileSafe(folderName .. "/" .. timeFileName, tostring(os.time()))
                    -- Hide this key prompt window (Rayfield has no direct hide, so destroy and recreate main GUI)
                    Rayfield:Destroy()
                    -- Reload Rayfield and then create main GUI
                    local ok2, newRayfield = pcall(function()
                        return loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
                    end)
                    if not ok2 or not newRayfield then
                        warn("Failed to reload Rayfield after key entry")
                        return
                    end
                    Rayfield = newRayfield
                    createMainGui()
                else
                    warn("Invalid Key")
                end
            end,
        },
    })
end

-- Run either key prompt or main GUI
if hasValidKey then
    createMainGui()
else
    createKeyPrompt()
end
