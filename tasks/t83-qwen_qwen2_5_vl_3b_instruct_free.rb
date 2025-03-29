def starts_one_ends(n)
  if n == 1
    2
  else
    (10 ** (n - 1)) * 2 - (10 ** (n - 2))
  end
end