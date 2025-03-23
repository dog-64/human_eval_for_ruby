
def make_a_pile(n)
  result = []
  current = n
  n.times do
    result << current
    if current % 2 == 0
      current += 2
    else
      current += 2
    end
  end
  return result
end
