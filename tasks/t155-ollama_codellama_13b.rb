def even_odd_count(num)
    count_even = 0
    count_odd = 0
    num.to_s.chars.each do |char|
        if char.to_i % 2 == 0
            count_even += 1
        else
            count_odd += 1
        end
    end
    return [count_even, count_odd]
end