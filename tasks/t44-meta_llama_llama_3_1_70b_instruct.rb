def change_base(x, base)
  raise ArgumentError, 'Base must be between 2 and 9' unless (2..9).include?(base)
  raise ArgumentError, 'x must be a non-negative integer' if x < 0

  x.to_s(base)
end