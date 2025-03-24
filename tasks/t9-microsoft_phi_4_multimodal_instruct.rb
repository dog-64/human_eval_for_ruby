def rolling_max(numbers)
  max_seen = numbers.last
  numbers.map { |num| max_seen = [num, max_seen].max }
end