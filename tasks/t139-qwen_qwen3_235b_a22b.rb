def special_factorial(n)
  product = 1
  current_fact = 1
  1.upto(n) do |i|
    current_fact *= i
    product *= current_fact
  end
  product
end