
def pluck(arr)
  min_even = Float::INFINITY
  min_index = -1

  arr.each_with_index do |num, index|
    if num % 2 == 0 && num < min_even
      min_even = num
      min_index = index
    end
  end

  if min_index == -1
    []
  else
    [min_even, min_index]
  end
end
