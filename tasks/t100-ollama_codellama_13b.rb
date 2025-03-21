def make_a_pile(n)
  pile = []
  (1..n).each do |i|
    if i % 2 == 0
      pile << i * 2
    else
      pile << (i + 1) * 2 - 1
    end
  end
  return pile
end