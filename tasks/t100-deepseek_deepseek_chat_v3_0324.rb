def make_a_pile(n)
  result = []
  current = n
  n.times do
    result << current
    current += current.even? ? 2 : 2
  end
  result
end