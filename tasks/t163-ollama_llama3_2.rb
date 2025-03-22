def generate_even_numbers(a, b)
  a = [a] if a < b
  result = []
  a.each do |num|
    break unless num.even?
    result << num
  end
  result.sort
end