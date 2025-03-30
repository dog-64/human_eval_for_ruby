
def pluck(arr)
  return [] if arr.empty?

  min_even = nil
  min_index = nil

  arr.each_with_index do |num, index|
    if num.even?
      if min_even.nil? || num < min_even || (num == min_even && index < min_index)
        min_even = num
        min_index = index
      end
    end
  end

  min_even.nil? ? [] : [min_even, min_index]
end

 