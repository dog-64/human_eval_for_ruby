def even_odd_count(num)
    num_str = num.to_s
    count_even = 0
    count_odd = 0
    num_str.each_char do |char|
        next if char == '-'
        digit = char.to_i
        if digit.even?
            count_even += 1
        else
            count_odd += 1
        end
    end
    [count_even, count_odd]
end