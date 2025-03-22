def next_smallest(list)
  return nil if list.size < 2
  smallest = list[0]
  second_smallest = list[1]
  (2..list.size-1).each do |i|
    if list[i] < smallest
      second_smallest = smallest
      smallest = list[i]
    elsif list[i] < second_smallest && list[i] != smallest
      second_smallest = list[i]
    end
  end
  return second_smallest
end