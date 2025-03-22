def factorial(num)
  (1..num).inject(:*)
end

def f(n)
  return [] if n == 0
  (1..n).map do |i|
    i.even? ? factorial(i) : (1..i).sum
  end
end