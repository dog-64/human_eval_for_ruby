def f(n)
  return [] if n == 0
  (1..n).map do |i|
    i.even? ? factorial(i) : sum_to(i)
  end
end

def factorial(i)
  (1..i).inject(1, :*)
end

def sum_to(i)
  (1..i).sum
end