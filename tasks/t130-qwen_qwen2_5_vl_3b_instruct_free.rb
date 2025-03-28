def tri(n)
  return [1] if n == 0
  return [1, 3] if n == 1
  result = [1, 3]
  (2..n).each do |i|
    result << (i.even? ? 1 + i / 2 : result[i - 1] + result[i - 2] + result[i + 1])
  end
  result
end