-- This LocalScript will load and run our CameraModule

-- Get services and camera
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local camera = workspace.CurrentCamera

-- Wait for the module to exist, then load it
local CameraModule = require(ReplicatedStorage:WaitForChild("CameraModule"))

-- Call the Init function from the module and pass it the player's camera
CameraModule:Init(camera)

print("Camera Controller Initialized.")