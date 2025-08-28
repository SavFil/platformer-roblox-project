local ReplicatedStorage = game:GetService("ReplicatedStorage")
local platformTemplate = ReplicatedStorage:WaitForChild("PlatformTemplate")

local players = game:GetService("Players")
local debounce = false

-- Function to spawn a new platform and connect the event
local function spawnNextPlatform(currentPlatform)
    print("touched!")
	-- Use a debounce to prevent multiple platforms from spawning at once
	-- if debounce == false then
	-- 	debounce = true

	-- 	local character = players:GetPlayerFromCharacter(currentPlatform.Parent):WaitForChild("HumanoidRootPart")
	-- 	local currentPlatformY = currentPlatform.Position.Y
	-- 	local nextPlatformY = currentPlatformY + 10 -- 10 studs above the current one

	-- 	local newPlatform = platformTemplate:Clone()
	-- 	newPlatform.Position = Vector3.new(math.random(-20, 20), nextPlatformY, math.random(-20, 20))
	-- 	newPlatform.Parent = workspace
		
	-- 	-- Disconnect the touch event from the current platform
	-- 	currentPlatform.Touched:Disconnect()

	-- 	-- Connect the touch event to the new platform
	-- 	newPlatform.Touched:Connect(function(otherPart)
	-- 		-- Check if the part that touched it belongs to a player character
	-- 		if otherPart.Parent:FindFirstChild("Humanoid") then
	-- 			spawnNextPlatform(newPlatform)
	-- 		end
	-- 	end)
		
	-- 	-- Wait for the player to get off the platform before allowing another spawn
	-- 	wait(0.5)
	-- 	debounce = false
	-- end
end

-- Spawn the first platform and connect the event
local firstPlatform = platformTemplate:Clone()
firstPlatform.Position = Vector3.new(0, 5, 0)
firstPlatform.Parent = workspace

firstPlatform.Touched:Connect(function(otherPart)
	if otherPart.Parent:FindFirstChild("Humanoid") then
		spawnNextPlatform(firstPlatform)
	end
end)