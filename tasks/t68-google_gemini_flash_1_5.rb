def pluck(arr)
  min_even = -1
  min_even_index = -1
  arr.each_with_index do |num, index|
    if num % 2 == 0
      if min_even == -1 || num < min_even
        min_even = num
        min_even_index = index
      end
    end
  end
  if min_even == -1
    return []
  else
    return [min_even, min_even_index]
  end
end
