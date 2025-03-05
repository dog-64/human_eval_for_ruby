def make_a_pile(n)
  pile = [n]
  if n == 1
    pile << 3
  else
    (n - 1).times do |i|
      if pile[i] % 2 == 0
        pile << pile[i] + 2
      else
        pile << pile[i] + 2
      end
    end
  end
  return pile
end