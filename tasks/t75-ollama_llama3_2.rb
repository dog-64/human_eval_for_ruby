def is_multiply_prime?(a)
  return false if a < 10 || a > 99
  i = 2
  while i * i <= a
    break if a % i != 0
    c = 0
    while a % i == 0 do
      a /= i
      c += 1
    end
    return false if c >= 3
    i += 1
  end
  a > 1 && a.size == 3 ? true : false
end