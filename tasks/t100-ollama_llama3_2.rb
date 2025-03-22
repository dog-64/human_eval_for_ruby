def make_a_pile(n)
  result = [n]
  i = n
  while i < n * 2
    if i % 2 == 0
      result << (i + 1) / 2 * 2
    else
      result << (i + 3) / 2 * 2
    end
    i += 2
  end
  result
end