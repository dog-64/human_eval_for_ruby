
def greatest_common_divisor(a, b)
  return 0 if a.zero? && b.zero?
  a, b = a.abs, b.abs
  while b != 0
    a, b = b, a % b
  end
  a
end

 