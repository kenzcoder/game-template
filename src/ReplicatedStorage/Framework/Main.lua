local Main = {}

Main.LoadedServices = {}
Main.Services = {}

local Remotes = game:GetService("ReplicatedStorage"):WaitForChild("Remotes")

function Main:CreateEvent(name)
	local RemoteEvent = Instance.new("RemoteEvent", script.Parent.Parent.Remotes)

	RemoteEvent.Name = name
end

function Main:CreateFunction(name)
	local RemoteFunction = Instance.new("RemoteFunction", script.Parent.Parent.Remotes)

	RemoteFunction.Name = name
end

function Main:ConnectEvent(func, name)
	local RemoteEvent = Remotes:FindFirstChild(name)

	if RemoteEvent then
		RemoteEvent.OnServerEvent:Connect(func)
	end
end

function Main:Fire(name, ...)
	local Remote = Remotes:FindFirstChild(name)
	
	if Remote then
		

	if Remote.ClassName == "RemoteEvent" then
		Remote:FireServer(...)
	elseif Remote.ClassName == "RemoteFunction" then
		Remote:InvokeServer(...)
	end
		
	end

end

function Main:Initialize(path, ModuleName)
	local ModuleScript = path:FindFirstChild(ModuleName)

	if not ModuleScript then error("Could not find "..ModuleName) end

	local LoadedModule = require(ModuleScript)

	self.Modules[ModuleName] = LoadedModule

	task.spawn(function()
		if LoadedModule.Init then
			table.insert(self.Loaded,LoadedModule)
			LoadedModule:Init()
		end
	end)
end

function Main:LoadAllServices(path)
	for _, module in pairs(path:GetChildren()) do
		self:LoadModule(module.Name)
		task.wait(2)
		print(self.LoadedServices)
	end
end

return Main