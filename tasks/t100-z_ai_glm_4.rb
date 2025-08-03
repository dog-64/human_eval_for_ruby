def make_a_pile(n)
  if n == 1
    [1, 3]
  else
    (0...n).map { |i| n + 2 * i }
  end
end