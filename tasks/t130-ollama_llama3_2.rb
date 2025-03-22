def tri(n)
  return [1] if n == 0
  return [1, 3] if n == 1
  a = [1]
  b = [1, 3]
  c = []
  while (a.size + b.size) <= n + 1
    next if a.empty?
    next if b.empty?
    c << a.last + b.last
    break if c.size >= n + 1
    a << a.last + b.last
    b << a.last + b.last
  end
  return (a + b + c).uniq.sort
end