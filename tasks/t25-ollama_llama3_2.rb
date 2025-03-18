def factorize(n)
  return [] if n == 1
  result = []
  i = -1
  while (i += 1) && n > 1
    if n.even?
      n /= 2
      result << 2 if !result.include?(2)
    else
      j = 3
      while (j += 2) && j * j <= n
        break unless n % j == 0
        n /= j
        result << j if !result.include?(j)
      end
      break unless n > 1
    end
  end
  result
end