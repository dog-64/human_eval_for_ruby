def sum_binary_digits(n)
  return "1" if n == 1
  return "0" if n == 0

  binary = n.to_s(2)
  sum = 0

  for i in (0..binary.length-1) do
    sum += binary[i].to_i
  end

  return sum.to_s(2)
end