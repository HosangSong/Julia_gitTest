function demo()
    global x = 0
    while 1 == 1
        println("Staying alive!")
        if x == 5
            break
        end
        x += 1
    end
end
demo()