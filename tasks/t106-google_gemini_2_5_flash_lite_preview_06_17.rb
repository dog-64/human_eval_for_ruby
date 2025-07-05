def factorial(num)
  (1..num).reduce(1, :*)
end

def sum_up_to(num)
  (1..num).reduce(0, :+)
end

def f(n)
  (1..n).map do |i|
    if i.even?
      factorial(i)
    else
      sum_up_to(i)
    end
  end
end