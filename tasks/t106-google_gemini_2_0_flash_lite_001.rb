def f(n)
  result = []
  (1..n).each do |i|
    if i.even?
      factorial = (1..i).inject(1, :*)
      result << factorial
    else
      sum = (1..i).sum
      result << sum
    end
  end
  result
end