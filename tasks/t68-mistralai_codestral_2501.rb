def pluck(arr)
  min_even = nil
  min_index = nil
  arr.each_with_index do |value, index|
    if value.even?
      if min_even.nil? || value < min_even
        min_even = value
        min_index = index
      end
    end
  end
  min_even.nil? ? [] : [min_even, min_index]
end