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

    -- print the result
    possibleLetters = {"a", "e", "i", "j", "k", "l", "m", "n", "o", "p", "s", "t", "u", "w"}
    for i = 1, #possibleLetters do
        local cur = possibleLetters[i]

        local percentage = letters[cur] / letters.total
        percentage = math.floor(percentage * 100)

        print(cur .. ": " .. letters[cur] .. "; " .. percentage .. "%")
    end
end

-- run main
main()
