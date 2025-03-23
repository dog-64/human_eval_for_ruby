def rolling_max(numbers)
    max_so_far = -Float::INFINITY
    numbers.map { |num| max_so_far = [max_so_far, num].max }
end
