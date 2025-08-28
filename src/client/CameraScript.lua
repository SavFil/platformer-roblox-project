-- Pseudocode for Camera Script
local player = game.Players.LocalPlayer
local camera = workspace.CurrentCamera

camera.CameraType = Enum.CameraType.Scriptable

local initialOffset = Vector3.new(0, 10, 15) -- Adjust as needed

game:GetService("RunService").RenderStepped:Connect(function()
    local character = player.Character
    if not character or not character.PrimaryPart then return end

    local humanoidRootPart = character.PrimaryPart

    -- Get the character's horizontal position
    local targetPosition = Vector3.new(humanoidRootPart.Position.X, humanoidRootPart.Position.Y, humanoidRootPart.Position.Z)

    -- Fix the camera on the target, maintaining a fixed offset
    camera.CFrame = CFrame.lookAt(
        targetPosition + initialOffset,
        targetPosition
    )
end)