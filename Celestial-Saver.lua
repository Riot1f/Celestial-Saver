-- Load Rayfield Library First
local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Rayfield/main/source.lua"))()

-- Track Executions (You can later add webhook or HTTP logic here)
local function trackExecutions()
    -- Reserved for future use. Add webhook logic here if needed.
end
trackExecutions()

-- Main Window
local Window = Rayfield:CreateWindow({
   Name = "Celestial Saver",
   LoadingTitle = "Celestial Saver",
   LoadingSubtitle = "by Celestial",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "CelestialSaver", -- Custom folder
      FileName = "CelestialConfig"
   },
   Discord = {
      Enabled = true,
      Invite = "Y9xHnZN5yr",
      RememberJoins = true
   },
   KeySystem = false, -- Set to true if you add keys later
})

-- Main Tab
local MainTab = Window:CreateTab("Main", 4483362458)

-- Save Game Button
MainTab:CreateButton({
   Name = "Save Game",
   Callback = function()
      local HttpService = game:GetService("HttpService")
      local placeId = game.PlaceId
      local jobId = game.JobId
      local url = string.format("https://assetdelivery.roblox.com/v1/asset/?id=%s", placeId)

      if not isfolder("workspace") then makefolder("workspace") end
      writefile("workspace/" .. placeId .. "_" .. jobId .. ".rbxl", game:GetService("HttpService"):JSONEncode({url = url}))

      Rayfield:Notify({
         Title = "Celestial Saver",
         Content = "Game saved to workspace folder!",
         Duration = 6.5,
         Image = 4483362458,
         Actions = {
            Ignore = { Name = "Okay", Callback = function() end }
         }
      })
   end,
})

-- Info Text
MainTab:CreateParagraph({
   Title = "How it works",
   Content = "Press the button above to save your game instance. It will be saved in your workspace folder. If it doesn't show up, ask for help in the Discord server."
})

-- Extra Tab for More Features
local FunTab = Window:CreateTab("Fun", 4483362458)

-- Fly Button (basic example)
FunTab:CreateButton({
   Name = "Enable Fly",
   Callback = function()
      loadstring(game:HttpGet("https://pastebin.com/raw/ySLjMZKa"))() -- Uses IY fly
   end,
})

-- Walkspeed Slider
FunTab:CreateSlider({
   Name = "WalkSpeed",
   Range = {16, 200},
   Increment = 1,
   Suffix = "Speed",
   CurrentValue = 16,
   Callback = function(Value)
      game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
   end,
})

-- Noclip Button
FunTab:CreateButton({
   Name = "Noclip",
   Callback = function()
      local plr = game.Players.LocalPlayer
      local noclip = true

      game:GetService('RunService').Stepped:Connect(function()
         if noclip then
            for _,v in pairs(plr.Character:GetDescendants()) do
               if v:IsA('BasePart') then
                  v.CanCollide = false
               end
            end
         end
      end)
   end,
})

