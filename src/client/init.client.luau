local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local camera = workspace.CurrentCamera
local player = Players.LocalPlayer

-- Camera settings
local cameraOffset = Vector3.new(0, 5, 20)
local lookAtOffset = Vector3.new(0, 5, 0)
local smoothness = 0.025 -- A value between 0 and 1. Lower is smoother.

-- Wait for the character to spawn
local character = player.Character or player.CharacterAdded:Wait()
local rootPart = character:WaitForChild("HumanoidRootPart")

-- Set the camera to be controlled by the script
camera.CameraType = Enum.CameraType.Scriptable

-- Main loop for the camera movement
RunService.RenderStepped:Connect(function()
	if not character or not rootPart then return end

	-- Get the player's current position, but only use the Y-axis
	local playerPosition = rootPart.Position

	-- Define the camera's target position and look-at point
	-- The X and Z coordinates are fixed, only the Y changes
	local targetPosition = Vector3.new(cameraOffset.X, playerPosition.Y + cameraOffset.Y, cameraOffset.Z)
	local targetLookAt = Vector3.new(lookAtOffset.X, playerPosition.Y + lookAtOffset.Y, lookAtOffset.Z)

	-- Define the target CFrame for the camera
	local targetCFrame = CFrame.new(targetPosition, targetLookAt)

	-- Smoothly move the camera to the target CFrame using Lerp
	camera.CFrame = camera.CFrame:Lerp(targetCFrame, smoothness)
end)