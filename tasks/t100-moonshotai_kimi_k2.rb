def make_a_pile(n)
  (0...n).map { |i| n + (n.odd? ? 2 * i : 2 * i) }
end