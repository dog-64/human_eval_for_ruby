def make_a_pile(n)
  pile = []
  current = n
  n.times do
    pile << current
    current = current.even? ? current + 2 : current + 2
  end
  pile
end