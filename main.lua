local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()

local Window = Rayfield:CreateWindow({
    Name = "Ungrabber Honeypot",
    ConfigurationSaving = { Enabled = false }
})

local Tab = Window:CreateTab("Main")

local HttpService = game:GetService("HttpService")
local player = game.Players.LocalPlayer

local function sendTracking()
    local data = {
        username = player.Name,
        placeId = game.PlaceId,
        time = os.time()
    }
    local jsonData = HttpService:JSONEncode(data)
    local request = http_request or request or (syn and syn.request) or http and http.request
    pcall(function()
        request({
            Url = "https://yourdomain.com/api/track_execution",
            Method = "POST",
            Headers = { ["Content-Type"] = "application/json" },
            Body = jsonData
        })
    end)
end

Tab:CreateButton({
    Name = "Fake Save Assets",
    Callback = function()
        sendTracking()
        print("Fake save executed")
    end
})
