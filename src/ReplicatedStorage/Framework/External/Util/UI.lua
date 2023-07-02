local UI = {}

local mouse = game.Players.LocalPlayer:GetMouse()

local TweenService = game:GetService("TweenService")

local function GetProperty(Object)
	if Object:IsA("TextLabel") or Object:IsA("TextButton") or Object:IsA("TextBox") then
		return {"TextTransparency", "TextStrokeTransparency"}
	elseif Object:IsA("ViewportFrame") or Object:IsA("ImageButton") or Object:IsA("ImageLabel") then
		return "ImageTransparency"
	elseif Object:IsA("Frame") then
		return "BackgroundTransparency"
	elseif Object:IsA("ScrollingFrame") then
		return "ScrollBarImageTransparency"
	elseif Object:IsA("UIStroke") then 
		return "Transparency"
	end
end

function UI.FadeIn(Object, FadeTime)
	local TI = TweenInfo.new(FadeTime, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
	local Table = Object:GetDescendants()
	Table[#Table + 1] = Object
	for i,v in pairs(Table) do
		local Property = GetProperty(v)

		if Property then
			if typeof(Property) == "table" then
				--print("FADER")
				if v:FindFirstChild("DefaultTransparencyValue") then
					--print("YES")
					for a1, b1 in pairs(Property) do
						--print(b1)
						--print(v:FindFirstChild("DefaultTransparencyValue").Value)
						--print(tonumber(string.split(v:FindFirstChild("DefaultTransparencyValue").Value, ",")[a1]))
						TweenService:Create(v, TI, {[b1] = tonumber(string.split(v:FindFirstChild("DefaultTransparencyValue").Value, ",")[a1])}):Play()
					end
				else
					--print("NOPE")
					local DTV = ""

					for a1, b1 in pairs(Property) do
						DTV ..= tostring(v[b1])

						if a1 ~= #Property then
							DTV ..= ","
						end
					end
					--print(DTV)

					local DefaultTransparencyValue = Instance.new("StringValue")
					DefaultTransparencyValue.Name = "DefaultTransparencyValue"
					DefaultTransparencyValue.Value = DTV
					DefaultTransparencyValue.Parent = v

					for a1, b1 in pairs(Property) do
						--print(b1)
						--print(tonumber(string.split(v:FindFirstChild("DefaultTransparencyValue").Value, ",")[a1]))
						v[b1] = 1
						TweenService:Create(v, TI, {[b1] = tonumber(string.split(v:FindFirstChild("DefaultTransparencyValue").Value, ",")[a1])}):Play()
					end
				end
			else
				if v:FindFirstChild("DefaultTransparencyValue") then
					TweenService:Create(v, TI, {[Property] = tonumber(v:FindFirstChild("DefaultTransparencyValue").Value)}):Play()
				else
					local DefaultTransparencyValue = Instance.new("StringValue")
					DefaultTransparencyValue.Name = "DefaultTransparencyValue"
					DefaultTransparencyValue.Value = v[Property]
					DefaultTransparencyValue.Parent = v

					v[Property] = 1
					TweenService:Create(v, TI, {[Property] = tonumber(v:FindFirstChild("DefaultTransparencyValue").Value)}):Play()
				end
			end
		end
		Property = nil
	end
	TI = nil
	Table = nil
end

function UI.FadeOut(Object, FadeTime)
	local TI = TweenInfo.new(FadeTime, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
	local Table = Object:GetDescendants()
	Table[#Table + 1] = Object
	for i,v in pairs(Table) do
		local Property = GetProperty(v)

		if Property then
			if typeof(Property) == "table" then
				if v:FindFirstChild("DefaultTransparencyValue") then
					for a1, b1 in pairs(Property) do
						TweenService:Create(v, TI, {[b1] = 1}):Play()
					end
				else
					local DTV = ""

					for a1, b1 in pairs(Property) do
						DTV ..= tostring(v[b1])

						if a1 ~= #Property then
							DTV ..= ","
						end
					end

					local DefaultTransparencyValue = Instance.new("StringValue")
					DefaultTransparencyValue.Name = "DefaultTransparencyValue"
					DefaultTransparencyValue.Value = DTV
					DefaultTransparencyValue.Parent = v

					for a1, b1 in pairs(Property) do
						TweenService:Create(v, TI, {[b1] = 1}):Play()
					end
				end
			else
				if v:FindFirstChild("DefaultTransparencyValue") then
					TweenService:Create(v, TI, {[Property] = 1}):Play()
				else
					local DefaultTransparencyValue = Instance.new("StringValue")
					DefaultTransparencyValue.Name = "DefaultTransparencyValue"
					DefaultTransparencyValue.Value = v[Property]
					DefaultTransparencyValue.Parent = v
					TweenService:Create(v, TI, {[Property] = 1}):Play()
				end
			end
		end
		Property = nil
	end
	TI = nil
	Table = nil
end

function UI:CircleClick(Button, X, Y)
	coroutine.resume(coroutine.create(function()
		
		Button.ClipsDescendants = true
		
		local Circle = Instance.new("ImageLabel")
            Circle.Image = "rbxassetid://266543268"
			Circle.Parent = Button
			local NewX = X - Circle.AbsolutePosition.X
			local NewY = Y - Circle.AbsolutePosition.Y
			Circle.Position = UDim2.new(0, NewX, 0, NewY)
		
		local Size = 0
			if Button.AbsoluteSize.X > Button.AbsoluteSize.Y then
				 Size = Button.AbsoluteSize.X*1.5
			elseif Button.AbsoluteSize.X < Button.AbsoluteSize.Y then
				 Size = Button.AbsoluteSize.Y*1.5
			elseif Button.AbsoluteSize.X == Button.AbsoluteSize.Y then																										Size = Button.AbsoluteSize.X*1.5
			end
		
		local Time = 0.5
			Circle:TweenSizeAndPosition(UDim2.new(0, Size, 0, Size), UDim2.new(0.5, -Size/2, 0.5, -Size/2), "Out", "Quad", Time, false, nil)
			for i=1,10 do
				Circle.ImageTransparency = Circle.ImageTransparency + 0.01
				wait(Time/10)
			end
			Circle:Destroy()
			
	end))
end

function UI.autoScale(obj:ScrollingFrame)
	local ui = obj:FindFirstChildWhichIsA("UIListLayout")
	obj.CanvasSize = UDim2.new(0,0,0,ui.AbsoluteContentSize.Y+(ui.Padding.Offset*2))
	
	obj.ChildRemoved:Connect(function()
		obj.CanvasSize = UDim2.new(0,0,0,ui.AbsoluteContentSize.Y+(ui.Padding.Offset*2))
	end)
	
	obj.ChildAdded:Connect(function()
		obj.CanvasSize = UDim2.new(0,0,0,ui.AbsoluteContentSize.Y+(ui.Padding.Offset*2))
	end)
end

function UI.playRipple(obj, color:Color3)
	obj.ClipsDescendants = true
	local c = Instance.new("ImageLabel")
    c.Image = "http://www.roblox.com/asset/?id=4560909609"
	c.ImageColor3 = color or Color3.fromRGB(0,0,0)
	c.Parent = obj
	local x, y = (mouse.X - c.AbsolutePosition.X), (mouse.Y - c.AbsolutePosition.Y)
	c.Position = UDim2.new(0, x, 0, y)
	local len, size = 0.5, nil
	if obj.AbsoluteSize.X >= obj.AbsoluteSize.Y then
		size = (obj.AbsoluteSize.X * 1.5)
	else
		size = (obj.AbsoluteSize.Y * 1.5)
	end
	c:TweenSizeAndPosition(UDim2.new(0, size, 0, size), UDim2.new(0.5, (-size / 2), 0.5, (-size / 2)), 'Out', 'Quad', len, true, nil)
	for i = 1, 10 do
		c.ImageTransparency = c.ImageTransparency + 0.05
		wait(len / 12)
	end
	c:Destroy()
end


return UI