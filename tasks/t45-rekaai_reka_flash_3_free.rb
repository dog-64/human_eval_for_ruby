
def triangle_area(a, h)
  if a <= 0 || h <= 0
    raise ArgumentError, 'a и h должны быть положительными числами'
  end
  (a * h) / 2.0
end

 