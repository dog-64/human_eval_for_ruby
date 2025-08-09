def tri(n)
  result = []
  (0..n).each do |i|
    if i == 0
      result[i] = 1
    elsif i == 1
      result[i] = 3
    elsif i.even?
      result[i] = 1 + i / 2
    else
      result[i] = result[i - 1] + result[i - 2] + (1 + (i + 1) / 2)
    end
  end
  result
end