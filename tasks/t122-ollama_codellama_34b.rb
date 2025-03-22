def add_elements(arr, k)
    sum = 0
    arr.take(k).each do |num|
        if num < 10 && num > -10
            sum += num
        end
    end
    return sum
end