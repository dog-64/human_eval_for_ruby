def fizz_buzz(n)
    count = 0
    for i in 1..n-1
        if i % 11 == 0 or i % 13 == 0
            count += 1
    end
    return count
end