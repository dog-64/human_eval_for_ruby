def pluck(arr)
  min_even_value = nil
  min_even_index = nil

  arr.each_with_index do |value, index|
    if value.even?
      if min_even_value.nil? || value < min_even_value
        min_even_value = value
        min_even_index = index
      elsif value == min_even_value && index < min_even_index
        min_even_index = index
      end
    end
  end

  if min_even_value.nil?
    []
  else
    [min_even_value, min_even_index]
  end
end