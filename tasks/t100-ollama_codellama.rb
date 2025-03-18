def make_a_pile(n)
  pile = []
  (0...n).each do |i|
    if i == 0
      pile << n
    else
      if n % 2 != 0
        pile << (n + 1) / 2 * 2 - 1
      else
        pile << (n + 1) / 2 * 2
      end
    end
  end
  return pile
end