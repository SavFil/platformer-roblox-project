-- This script is attached to the starting platform and dynamically cloned to new ones.

local platform = script.Parent

-- We need to find the template to clone. It should NOT have a script.
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local platformTemplate = ReplicatedStorage:WaitForChild("PlatformTemplate")

-- A debounce prevents the Touched event from firing too many times at once.
local debounce = false

local function onPlatformTouched(hit)
	-- First, check if the thing that touched the platform is a player character.
	local character = hit.Parent
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	local isFoot = (hit.Name == "LeftLowerLeg" or hit.Name == "RightLowerLeg")

	-- If it's a player and the debounce is false, then proceed.
	if humanoid and isFoot and not debounce then
		-- Set debounce to true to prevent creating multiple platforms from a single touch.
		debounce = true

		print(platform.Name .. " was touched by " .. character.Name)

		-- Create a new platform by cloning our template.
		local newPlatform = platformTemplate:Clone()

		-- Generate a random X offset between -10 and 10
		local rng = Random.new()
		local randomX = rng:NextNumber(-10, 10)

		-- Position the new platform 5 studs higher than the current one.
		newPlatform.Position = platform.Position + Vector3.new(randomX, 7, 0)

		-- Give it a unique name (optional, but good for debugging).
		newPlatform.Name = "GeneratedPlatform"

		-- Put the new platform into the Workspace so it's visible and interactable.
		newPlatform.Parent = workspace

		-- Clone THIS script and put it into the new platform.
		script:Clone().Parent = newPlatform

	end
end

-- Connect the function to the platform's Touched event.
platform.Touched:Connect(onPlatformTouched)
