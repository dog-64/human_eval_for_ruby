def f(n)
  return [] if n == 0
  
  (1..n).map do |i|
    if i.even?
      (1..i).inject(:*)
    else
      (1..i).sum
    end
  end
end