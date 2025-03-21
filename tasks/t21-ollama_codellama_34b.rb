def rescale_to_unit(numbers)
    # Check if the input list has at least two elements
    if numbers.length < 2
        raise ArgumentError, "Input list must have at least two elements"
    end

    # Find the minimum and maximum values in the list
    min_value = numbers.min
    max_value = numbers.max

    # Calculate the scaling factor
    scale_factor = 1.0 / (max_value - min_value)

    # Scale the values in the list
    return numbers.map { |x| (x - min_value) * scale_factor }
end