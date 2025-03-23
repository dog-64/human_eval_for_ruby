def generate_even_numbers(a, b)
  start = [a, b].min
  finish = [a, b].max
  result = []
  (start..finish).each do |i|
    if i % 2 == 0
      result << i
    end
  end
  return result
end