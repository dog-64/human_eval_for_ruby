def tri(n)
  return [1] if n == 0
  return [1, 3] if n == 1
  arr = [1, 3]
  (2..n).each do |i|
    if i.even?
      arr << (1 + i / 2)
    else
      arr << (arr[i - 1] + arr[i - 2] + (1 + (i + 1) / 2))
    end
  end
  arr
end
