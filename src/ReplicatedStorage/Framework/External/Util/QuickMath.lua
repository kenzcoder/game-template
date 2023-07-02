--[[
	    	
	░█▀▀█ ░█─░█ ▀█▀ ░█▀▀█ ░█─▄▀ 　 ░█▀▄▀█ ─█▀▀█ ▀▀█▀▀ ░█─░█ ░█▀▀▀█ 
	░█─░█ ░█─░█ ░█─ ░█─── ░█▀▄─ 　 ░█░█░█ ░█▄▄█ ─░█── ░█▀▀█ ─▀▀▀▄▄ 
	─▀▀█▄ ─▀▄▄▀ ▄█▄ ░█▄▄█ ░█─░█ 　 ░█──░█ ░█─░█ ─░█── ░█─░█ ░█▄▄▄█
	
		
	Able to solve percentages, mean, round numbers, find the square root, list factors + mutiples, 
	list the range for numbers, list median for a number and if the number is even


	Created by @k2_nz
	k_nz on discord

]]--


local Math = {}

local Ofs = 2 ^ 52

function Math:FindPercentage(Value, MaxValue)
    return math.round(Value / MaxValue * 100)
end

function Math:isEven(num: number): boolean
	local hasRemainder = math.fmod(num, 2)
	local isEven

	if hasRemainder == 0 then
		isEven = true
	else
		isEven = false
	end

	return isEven
end


function Math.median(...: number): number
	local Numbers = {...}

	if type(...) == "table" then
		Numbers = (...)
	end

	local OriginalNumCount = #Numbers
	local IS_EVEN = Math:isEven(OriginalNumCount)
	local Median

	table.sort(Numbers)

	if not IS_EVEN then
		for i = 1, OriginalNumCount / 2 do
			table.remove(Numbers, 1)
		end

		for i = 1, OriginalNumCount / 2 do
			table.remove(Numbers, #Numbers)
		end
	else
		for i = 1, OriginalNumCount / 2 - 1 do
			table.remove(Numbers, 1)
		end

		for i = 1, OriginalNumCount / 2 - 1 do
			table.remove(Numbers, #Numbers)
		end
	end

	if IS_EVEN then
		Median = (Numbers[1] + Numbers[2]) / 2
	else
		Median = Numbers[1]
	end

	return Median
end

function Math:FindRange(...: number): number -- Measure of variation
	local Numbers = {...}

	if type(...) == "table" then
		Numbers = (...)
	end

	table.sort(Numbers)

	return Numbers[#Numbers] - Numbers[1]
end

function Math:FindMean(...: number): number
	local Numbers = {...}

	if type(...) == "table" then
		Numbers = (...)
	end

	local Average = 0
	local Sum = 0

	for i = 1, #Numbers do
		Sum += Numbers[i]
		task.wait()
	end

	Average = Sum / #Numbers
	return Average
end


function Math.Abs(Number: number): number
	if Number > 0 then 
		return Number 
	else 
		return -Number 
	end
end

function Math.Round(Number : number): number -- this part is created by MrMouse2405 why why why why
	if Math.Abs(Number) > Ofs then 
		return Number
	end

	return if Number < 0 then Number - Ofs + Ofs else Number + Ofs - Ofs
end

function Math:FindSquareRoot(Value)
    return math.floor(math.sqrt(Value))
end

function Math:ListFactors(n)
    local factors = {}
	for m = 1,n do
		for i= 0, n do
			if m*i == n then
				table.insert(factors,m.."*"..i)
			end
		end
	end
	return factors
end

function Math:ListMultiples(n, amount)
    local Multiples = {}
	local num = 1
	repeat
		local result = num * n
		table.insert(Multiples,math.floor(result))
		num = num + 1
		wait()
	until #Multiples == amount
	return Multiples
end

return Math