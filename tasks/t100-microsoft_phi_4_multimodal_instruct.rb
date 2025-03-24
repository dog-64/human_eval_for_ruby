def make_a_pile(n)
  pile = []
  current = n % 2 + n
  (1..n).each do
    pile << current
    current += 2
  end
  pile
end