def f(n)
  (1..n).map do |i|
    if i.even?
      (1..i).reduce(1, :*)
    else
      (1..i).sum
    end
  end
end