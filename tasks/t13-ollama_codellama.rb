def greatest_common_divisor(a, b)
  # Реализация функции greatest_common_divisor
  if a == 0 || b == 0
    return |a| || |b|
  end

  while b != 0
    a, b = b, a % b
  end

  return a
end