def f(n)
  return [] if n == 0
  list = Array.new(n, 1)
  (1..n-1).each do |i|
    list[i] = i.even? ? i.factors.reduce(:*) : (1..i).sum
  end
  list
end