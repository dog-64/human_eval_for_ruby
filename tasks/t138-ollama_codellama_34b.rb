def is_equal_to_sum_even?(n)
    return false if n < 0 || n % 2 != 0
    (1..(n / 2)).each do |i|
        if i % 2 == 0 && n - i == 0
            return true
        end
    end
    return false
end