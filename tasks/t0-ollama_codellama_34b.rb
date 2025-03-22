
def has_close_elements(numbers, threshold)
    numbers.sort!
    for i in 0..numbers.length-2 do
        if (numbers[i+1] - numbers[i]) <= threshold
            return true
        end
    end
    return false
end