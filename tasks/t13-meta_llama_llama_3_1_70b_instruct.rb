def greatest_common_divisor(a, b)
  b.zero?? a.abs : greatest_common_divisor(b, a % b)
end