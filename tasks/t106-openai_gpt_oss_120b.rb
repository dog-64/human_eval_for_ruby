def f(n)
  result = []
  fact = 1
  (1..n).each do |i|
    if i.even?
      fact *= i
      result << fact
    else
      result << i * (i + 1) / 2
    end
  end
  result
end