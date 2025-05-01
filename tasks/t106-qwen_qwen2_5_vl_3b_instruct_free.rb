def f(n)
  (1..n).map do |i|
    i.odd? ? i.upto(i).sum : i.factorial
  end
end
