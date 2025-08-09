def make_a_pile(n)
  result = []
  current = n
  n.times do
    result << current
    current += 2
  end
  result
end