def tri(n)
  result = [1]
  return result if n == 0

  result << 3 if n >= 1
  return result if n == 1

  for i in 2..n
    if i.even?
      result << 1 + i / 2
    else
      result << result[i - 1] + result[i - 2] + (i + 1 <= n ? (1 + (i + 1) / 2) : 0)
    end
  end
  result
end