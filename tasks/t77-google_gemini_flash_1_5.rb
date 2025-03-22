def is_cube?(a)
  if a == 0
    return true
  end
  x = a.abs**(1.0/3.0)
  x == x.to_i && (x**3 == a.abs)
end
