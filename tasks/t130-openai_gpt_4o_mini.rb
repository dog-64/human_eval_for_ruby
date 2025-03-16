def tri(n)
  return [1] if n == 0
  result = [1]
  (1..n).each do |i|
    if i.even?
      result << (1 + i / 2)
    else
      result << (result[i - 1] + result[i - 2] + result[i + 1])
    end
  end
  result
end