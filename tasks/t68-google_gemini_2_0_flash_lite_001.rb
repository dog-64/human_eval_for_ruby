def pluck(arr)
  even_numbers = arr.each_with_index.select { |num, _| num.even? }
  return [] if even_numbers.empty?

  min_even = even_numbers.min_by { |num, _| num }
  [min_even[0], min_even[1]]
end
def pluck(arr)
    even_numbers = arr.each_with_index.select { |num, _| num.even? }
    return [] if even_numbers.empty?
    min_even_num = even_numbers.min_by { |num, index| num }
    [min_even_num[0], min_even_num[1]]
end