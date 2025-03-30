
def is_cube?(a)
  return true if a == 0

  x_candidate = a.negative? ? (-a ** (1.0/3)) * -1 : a ** (1.0/3)
  x_rounded = x_candidate.round

  [x_rounded - 1, x_rounded, x_rounded + 1].any? { |x| x ** 3 == a }
end

 