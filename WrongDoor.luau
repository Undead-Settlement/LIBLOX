script.Parent.Touched:connect(function(hit)
	if hit ~= nil then
		local char = hit.Parent
		if char ~= nil then
			local humanoid = char:FindFirstChild("Humanoid")
			if humanoid ~= nil then
				humanoid.Health = 0
			end
		end
	end
end)
