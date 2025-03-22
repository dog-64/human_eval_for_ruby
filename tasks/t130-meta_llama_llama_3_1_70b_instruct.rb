def tri(n)
  return [1] if n == 0
  return [1, 3] if n == 1
  return [1, 3, 2] if n == 2
  arr = [1, 3, 2]
  (3..n).each do |i|
    if i % 2 == 0
      arr << 1 + i / 2
    else
      arr << arr[i - 1] + arr[i - 2] + arr[i - 3]
    end
  end
  arr
end