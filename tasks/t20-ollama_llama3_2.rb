def find_closest_elements(numbers)
  return [] if numbers.size < 2
  numbers.sort!
  closest = [numbers[0], numbers[1]]
  (1...numbers.size).each do |i|
    next if i == 1
    a, b = closest
    c, d = numbers[i - 1], numbers[i]
    return closest = [a, c] if c - a < d - b
    return closest = [b, d] if d - b < c - a
  end
  closest
end