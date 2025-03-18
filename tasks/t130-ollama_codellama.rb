def tri(n)
  return [1] if n == 0
  return [1, 3] if n == 1
  return [1, 3, 2] if n == 2

  if n.even?
    return [1, 3, 2, *tri(n / 2)]
  else
    return [1, 3, *tri(n - 1), *tri(n - 2), *tri(n + 1)]
  end
end