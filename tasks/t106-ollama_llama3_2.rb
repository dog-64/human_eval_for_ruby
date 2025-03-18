def f(n)
  return [] if n < 0
  (1..n).map do |i|
    i.even? ? factorial(i) : sum(i)
  end
end

def factorial(n)
  n == 0 ? 1 : n * factorial(n-1)
end

def sum(n)
  n * (n + 1) / 2
end