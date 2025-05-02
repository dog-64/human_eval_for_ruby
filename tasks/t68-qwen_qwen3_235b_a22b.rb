def pluck(arr)
  min_even = nil
  min_index = -1
  arr.each_with_index do |num, i|
    if num.even?
      if min_even.nil? || num < min_even
        min_even = num
        min_index = i
      end
    end
  end
  min_index == -1 ? [] : [min_even, min_index]
end