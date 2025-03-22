def is_cube?(a)
  c = (a**(1.0/3)).round
  c**3 == a
end