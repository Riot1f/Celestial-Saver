local HttpService = game:GetService("HttpService")
local folderName = "CelestialSaverConfig"
local keyFileName = "CelestialKey.txt"
local timeFileName = "KeyTime.txt"

local function readFileSafe(path)
    local success, result = pcall(function() return readfile(path) end)
    if success then return result end
    return nil
end

local function writeFileSafe(path, content)
    pcall(function() writefile(path, content) end)
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
    -- expired if more than 24h (86400s) passed
    return (currentTime - lastTime) > 86400
end

local function saveKeyAndTime(key)
    writeFileSafe(folderName .. "/" .. keyFileName, key)
    writeFileSafe(folderName .. "/" .. timeFileName, tostring(os.time()))
end

-- Read stored key
local storedKey = readFileSafe(folderName .. "/" .. keyFileName)
local hasValidKey = storedKey and isKeyValid(storedKey) and not isKeyExpired()

local Window = nil

if not hasValidKey then
    -- Show key prompt
    Window = Rayfield:CreateWindow({
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
            -- accept only one key:
            Key = {"celestial123456"},
            Callback = function(key)
                if isKeyValid(key) then
                    saveKeyAndTime(key)
                    Rayfield:Destroy()
                    -- Relaunch main GUI after key success
                    loadstring(game:HttpGet("https://raw.githubusercontent.com/Riot1f/Celestial-Saver/refs/heads/main/Celestial-Saver.lua"))()
                else
                    warn("Invalid Key")
                end
            end,
        },
    })
else
    -- Key is valid and not expired, load main GUI
    Window = Rayfield:CreateWindow({
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
        KeySystem = false, -- already authenticated
        Theme = "Dark",
    })
end
