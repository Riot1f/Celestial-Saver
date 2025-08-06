-- NovaX-Saver.lua

local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()

local Window = Rayfield:CreateWindow({
    Name = "NovaX-Saver",
    ConfigurationSaving = {
        Enabled = false,
    }
})

local Tab = Window:CreateTab("Main")

Tab:CreateButton({
    Name = "Copy",
    Callback = function()
        local SSI = loadstring(game:HttpGet("https://raw.githubusercontent.com/luau/SynSaveInstance/main/saveinstance.lua"))()
        local Options = {} -- See https://luau.github.io/UniversalSynSaveInstance/api/SynSaveInstance for options
        SSI(Options)
    end
})
