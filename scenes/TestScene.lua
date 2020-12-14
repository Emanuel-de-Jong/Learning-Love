--[[
testing stuff.
--]]

local TestScene = Class:new()

toStart = 5
toEnd = 20
fromStart = 4
fromEnd = 19
printStyle = "code" -- simple, code
-- printPath = "D:\\Media\\Downloads\\automap.txt"

function round(x)
    return math.floor(x + 0.5)
end

local config = {}

function printSimple()
	local sum
    local s = {}
	for i = toStart, toEnd do
		for j = fromStart, math.min(i - 1, fromEnd) do
			s[#s+1] = ("\n[%d][%d]:\n"):format(i, j)
			for x = 1, j do
				for y = 1, i do
					s[#s+1] = config[i][j][x][y]
				end
				sum = math.ceil(j / 2)
				if x == sum or (j % 2 == 0 and x - 1 == sum) then
					s[#s+1] = "--\n"
				else
					s[#s+1] = "\n"
				end
			end
		end
	end

	if printPath then
		local file = io.open(printPath, "w")
		file:write(table.concat(s))
		file:close()
		print("done")
	else
		print(table.concat(s))
	end
end

function printCode()
    local s = {}
	for i = toStart, toEnd do
		s[#s+1] = ("config[%d] = {}\n\n"):format(i)
		for j = fromStart, math.min(i - 1, fromEnd) do
			s[#s+1] = ("config[%d][%d] = {"):format(i, j)
			for x = 1, j do
				s[#s+1] = "\n\t{"
				for y = 1, i do
					s[#s+1] = config[i][j][x][y] .. ","
				end
				s[#s+1] = "},"
			end
			s[#s+1] = "\n}\n\n"
		end
	end

	if printPath then
		local file = io.open(printPath, "w")
		file:write(table.concat(s))
		file:close()
		print("done")
	else
		print(table.concat(s))
	end
end

TestScene.load = function()
	local groups
	local average

	local toHalfUp
	local toHalfDown
	local toEven

	local fromHalfUp
	local fromHalfDown
	local fromQuartLeft
	local fromQuartRight
	local fromEven

	local remainder
	local remHalfUp
	local remHalfDown
	local remQuartUp
	local remQuartDown
	local remEven
	local remPos

	local changeGroup

    local start

    for to = toStart, toEnd do
        config[to] = {}
        for from = fromStart, math.min(to - 1, fromEnd) do
			config[to][from] = {}

			toEven = to % 2 == 0 and true or false
			toHalfUp = math.ceil(to / 2)
			toHalfDown = math.floor(to / 2)

			fromEven = from % 2 == 0 and true or false
			fromHalfUp = math.ceil(from / 2)
			fromHalfDown = math.floor(from / 2)
			fromQuartLeft = math.floor(from / 4)
			fromQuartRight = from - fromQuartLeft + 1

			groups = {}

			average = round(to / from)

			remainder = to - (average * from)
			if (not fromEven) or (fromEven and remainder % 2 == 1) then
				remainder = remainder - 1
			end
			if toEven and fromEven then
				remainder = remainder - 2
			end
			remPos = remainder > 0 and true or false
			remainder = math.abs(remainder)
			remEven = remainder % 2 == 0 and true or false
			remHalfUp = math.ceil(remainder / 2)
			remHalfDown = math.floor(remainder / 2)
			remQuartUp = math.ceil(remainder / 4)
			remQuartDown = math.floor(remainder / 4)

			average = average + 1
			changeGroup = average + 1

			for i = 1, from do
				groups[i] = average
			end

			if remainder ~= 0 then

				if not remPos then
					remainder = from - remainder
					remEven = remainder % 2 == 0 and true or false
					remHalfUp = math.ceil(remainder / 2)
					remHalfDown = math.floor(remainder / 2)
					remQuartUp = math.ceil(remainder / 4)
					remQuartDown = math.floor(remainder / 4)
				end

				if not fromEven and to <= 10 or to <= 8 then
					for i = 0, remHalfDown - 1 do
						groups[(fromEven and fromHalfUp or fromHalfUp - 1) - i] = changeGroup
					end

					for i = 0, remHalfDown - 1 do
						groups[(fromHalfUp + 1) + i] = changeGroup
					end
				else
					for i = 0, remHalfDown - 1 do
						groups[fromQuartLeft + remQuartUp - i] = changeGroup
					end

					for i = 0, remHalfDown - 1 do
						groups[fromQuartRight - remQuartUp + i] = changeGroup
					end
				end

				if not remEven then
					groups[fromHalfUp] = changeGroup
				end

				if not remPos then
					for i, ones in pairs(groups) do
						groups[i] = ones - 1
					end
				end
			end


			for row = 1, from do
                config[to][from][row] = {}

                for col = 1, to do
                    config[to][from][row][col] = 0
                end
			end

			start = 1
			for row = 1, fromHalfUp do
				for i = 1, groups[row] do
                    config[to][from][row][start + (i - 1)] = 1
				end
				
				start = start + (groups[row] - 1)
			end

			start = to
			for row = from, fromHalfUp + 1, -1 do
				for i = 1, groups[row] do
                    config[to][from][row][start - (i - 1)] = 1
				end
				
				start = start - (groups[row] - 1)
			end
        end
	end

	if printStyle == "simple" then
		printSimple()
	elseif printStyle == "code" then
		printCode()
	end
end

return TestScene