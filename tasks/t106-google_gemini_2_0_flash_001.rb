def f(n)
  result = []
  (1..n).each do |i|
    if i % 2 == 0
      factorial = 1
      (1..i).each do |j|
        factorial *= j
      end
      result << factorial
    else
      sum = 0
      (1..i).each do |j|
        sum += j
      end
      result << sum
    end
  end
  result
end