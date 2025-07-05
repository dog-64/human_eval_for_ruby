def generate_even_numbers(a, b)
  result = []
  start = a
  end_val = b

  if a > b
    start = b
    end_val = a
  end

  while start <= end_val
    if start % 2 == 0
      result << start
    end
    start += 1
  end

  result
end
