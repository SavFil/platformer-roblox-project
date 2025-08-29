-- We will put all of our functions and variables inside this table.
local CameraModule = {}

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

-- Camera settings
local cameraOffset = Vector3.new(0, 5, 20)
local lookAtOffset = Vector3.new(0, 5, 0)
local smoothness = 0.1

-- A variable to hold the camera that will be controlled.
-- This will be set by the Init function.
local camera = nil

-- This function is called by the init.client.luau script.
-- It takes the camera as an argument and starts the camera logic.
function CameraModule:Init(targetCamera)
    -- Assign the passed-in camera to our local variable.
    camera = targetCamera
    
    local player = Players.LocalPlayer
    
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
        local targetPosition = Vector3.new(cameraOffset.X, playerPosition.Y + cameraOffset.Y, cameraOffset.Z)
        local targetLookAt = Vector3.new(lookAtOffset.X, playerPosition.Y + lookAtOffset.Y, lookAtOffset.Z)
        
        -- Define the target CFrame for the camera
        local targetCFrame = CFrame.new(targetPosition, targetLookAt)
        
        -- Smoothly move the camera to the target CFrame using Lerp
        camera.CFrame = camera.CFrame:Lerp(targetCFrame, smoothness)
    end)
end

-- We must return the table so other scripts can access our functions.
return CameraModule