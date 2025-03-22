def generate_even_numbers(a, b)
  start_num = [a, b].min
  end_num = [a, b].max
  even_numbers = []

  (start_num..end_num).each do |num|
    if num.even?
      even_numbers << num
    end
  end
  even_numbers
end