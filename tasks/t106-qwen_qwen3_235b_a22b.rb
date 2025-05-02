def f(n)
  result = []
  (1..n).each do |i|
    if i.even?
      result << (1..i).reduce(1, :*)
    else
      result << (1..i).sum
    end
  end
  result
end