def f(n)
  result = []
  (1..n).each do |i|
    if i.even?
      fact = 1
      (1..i).each { |j| fact *= j }
      result << fact
    else
      result << i * (i + 1) / 2
    end
  end
  result
end