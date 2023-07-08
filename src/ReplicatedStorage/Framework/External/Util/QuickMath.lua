local Math = setmetatable({}, {__index = math})

Math.tau = math.pi * 2

function Math:isEven(num: number): boolean
	return (num % 2) == 0
end

function Math.percent(x: number, y: number): number
	return (x / 100) * y
end

function Math.median(...: number): number
	local Numbers = {...}

	if typeof(...) == "table" then
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

	if typeof(...) == "table" then
		Numbers = (...)
	end

	table.sort(Numbers)

	return Numbers[#Numbers] - Numbers[1]
end

function Math:FindMean(...: number): number
	local Numbers = {...}

	if typeof(...) == "table" then
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

function Math:ListFactors(n)
    local factors = {}
	for m = 1,n do
		for i= 0, n do
			if m*i == n then
				table.insert(factors, `{m}*{i}`)
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
		table.insert(Multiples, math.floor(result))
		num += 1
		task.wait()
	until #Multiples == amount
	return Multiples
end

return Math
