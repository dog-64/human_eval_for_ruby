def remove_duplicates(numbers)
  h = Hash.new { |h, k| h[k] = [] }
  numbers.each { |n| h[n] << n }
  h.values.map(&:first).sort
end