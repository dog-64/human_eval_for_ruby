def generate_even_numbers(a, b)
  min = [a, b].min
  max = [a, b].max
  even_numbers = []
  (min..max).each do |num|
    even_numbers << num if num % 2 == 0
  end
  even_numbers
end
