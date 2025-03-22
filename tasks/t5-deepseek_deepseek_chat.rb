def intersperse(numbers, delimeter)
    return [] if numbers.empty?
    numbers.each_with_object([]) do |num, result|
        result << num
        result << delimeter unless num == numbers.last
    end
end