def generate_even_numbers(a, b)
  start_num = [a, b].min
  end_num = [a, b].max
  
  result = []
  (start_num..end_num).each do |num|
    if num.even?
      result << num
    end
  end
  
  return result
end