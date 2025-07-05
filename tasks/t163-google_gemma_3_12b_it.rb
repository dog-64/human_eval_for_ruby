def generate_even_numbers(a, b)
  start = [a, b].min
  finish = [a, b].max
  result = []
  (start..finish).each do |num|
    if num.even?
      result << num
    end
  end
  result
end
