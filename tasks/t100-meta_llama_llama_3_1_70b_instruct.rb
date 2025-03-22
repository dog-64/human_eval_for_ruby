def make_a_pile(n)
  pile = [n]
  (n - 1).times do
    pile << (n % 2 == 0 ? pile.last + 2 : pile.last + 2)
  end
  pile
end