def tri(n)
  if n == 0
    [1]
  elsif n == 1
    [1, 3]
  elsif n == 2
    [1, 3, 2]
  else
    result = [1, 3, 2]
    (3..n).each do |i|
      if i.even?
        result << 1 + i / 2
      else
        result << result[i - 1] + result[i - 2] + result[i - 3]
      end
    end
    result
  end
end
