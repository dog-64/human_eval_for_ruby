def greatest_common_divisor(a, b)
  a, b = b, a % b while b != 0
  a
end