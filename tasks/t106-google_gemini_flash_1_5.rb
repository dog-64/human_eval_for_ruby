def f(n)
  result = []
  (1..n).each do |i|
    if i % 2 == 0
      factorial = (1..i).inject(:*)
      result << factorial
    else
      sum = (1..i).inject(:+)
      result << sum
    end
  end
  result
end
