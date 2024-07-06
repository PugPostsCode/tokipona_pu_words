--[[
    simple program for determining the letter frequency of the standard pu lexicon
    pug_plays_games
--]]

-- main function
function main()
    -- get the words
    pu = io.open("tokipona_pu", "r")
    words = pu:read("*all")
    pu:close()

	-- variables
	possibleLetters = {"a", "e", "i", "j", "k", "l", "m", "n", "o", "p", "s", "t", "u", "w"}

    -- count the letters
    letters = {}
    letters.total = 0
    for i = 1, #words do
        local let = string.sub(words, i, i)

        if letters[let] ~= nil then
            letters[let] = letters[let] + 1
        else
            letters[let] = 1
        end

        if let ~= nil and let ~= "\n" then
            letters.total = letters.total + 1
        end
    end

    print("Total Letters: " .. letters.total)

	-- rearrange in descending order
	sortLetters = {}
	for i = 1, #possibleLetters do
		table.insert(sortLetters, {possibleLetters[i], letters[possibleLetters[i]]})
	end

	unsorted = true
	difference = 1 -- amount of table indexes known to be sorted, kinda
	iterations = 1 -- amount of iterations the sort has done
	while unsorted do -- bubble sort
		--
		for i = 1, #sortLetters - difference do -- scan table, excluding difference
			if sortLetters[i][2] < sortLetters[i + 1][2] then
				local temp = sortLetters[i]

				sortLetters[i] = sortLetters[i + 1]
				sortLetters[i + 1] = temp
			end

			if i == #sortLetters - difference then
				difference = difference + 1
			end

			--[[
				a better programmer would implement a catch
				so that it would stop sorting after all checks
				return false.

				but i am not a better programmer
				(and it's really fast anyways)
			]]
		end

		-- exit loop when sorted
		if difference == #sortLetters then
			unsorted = false
		end

		-- itrations
		if iterations > 100 then
			print("ERROR: iteration overflow")
			break
		end
		iterations = iterations + 1
	end

    -- print the result
	for i = 1, #sortLetters do
		-- variables
		local letter = sortLetters[i][1]
		local amount = sortLetters[i][2]

		-- percentage
		local percentage = amount / letters.total
		percentage = math.floor(percentage * 1000)

		-- insert .
        if percentage > 99 then
			percentage = string.sub(percentage, 1, 2) .. "." .. string.sub(percentage, 3, 3)
        else
			percentage = string.sub(percentage, 1, 1) .. "." .. string.sub(percentage, 2, 2)
        end

        percentage = percentage .. "%"

        -- print
        print(letter .. ": " .. amount .. " = " .. percentage)
	end
end

-- run main
main()
