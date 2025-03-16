def factorial(x)
  (1..x).reduce(:*)
end

def f(n)
  (1..n).map do |i|
    if i.even?
      factorial(i)
    else
      (1..i).sum
    end
  end
end