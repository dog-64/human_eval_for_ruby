
def rolling_max(numbers)
  result = []
  max_so_far = -Float::INFINITY
  numbers.each do |number|
    max_so_far = [max_so_far, number].max
    result << max_so_far
  end
  return result
end
