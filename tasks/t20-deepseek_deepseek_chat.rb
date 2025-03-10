def find_closest_elements(numbers)
    raise ArgumentError, "List must contain at least two numbers" if numbers.size < 2
    numbers.sort!
    min_diff = Float::INFINITY
    result = []
    (0...numbers.size-1).each do |i|
        diff = (numbers[i] - numbers[i+1]).abs
        if diff < min_diff
            min_diff = diff
            result = [numbers[i], numbers[i+1]]
        end
    end
    result
end