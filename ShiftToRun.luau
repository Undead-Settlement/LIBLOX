

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

local camera = game.Workspace.CurrentCamera

local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local Configuration = require(game.ReplicatedStorage:WaitForChild("Configuration"))

if Configuration.WalkAnimationId ~= nil then
	character.Animate.walk.WalkAnim.AnimationId = "rbxassetid://"..Configuration.WalkAnimationId
end

if Configuration.RunAnimationId ~= nil then
	character.Animate.run.RunAnim.AnimationId = "rbxassetid://"..Configuration.RunAnimationId
end


function IsWalking()
	if humanoid.MoveDirection.Magnitude > 0 then
		return true
	else
		return false
	end
end


function Walk()
	TweenService:Create(humanoid, TweenInfo.new(Configuration.Duration, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {WalkSpeed = Configuration.WalkSpeed}):Play()
	TweenService:Create(camera, TweenInfo.new(Configuration.Duration, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {FieldOfView = Configuration.WalkFov}):Play()
end

function Run()
	TweenService:Create(humanoid, TweenInfo.new(Configuration.Duration, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {WalkSpeed = Configuration.RunSpeed}):Play()
	TweenService:Create(camera, TweenInfo.new(Configuration.Duration, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {FieldOfView = Configuration.RunFov}):Play()
end


UIS.InputBegan:Connect(function(key, proccess)
	if key.KeyCode == Configuration.RunKey then
		if IsWalking() then
			Run()
		end
	end
end)

UIS.InputEnded:Connect(function(key, proccess)
	if key.KeyCode == Configuration.RunKey then
		Walk()
	end
end)

game:GetService("RunService").RenderStepped:Connect(function()
	if IsWalking() == false then
		Walk()
	end
end)
