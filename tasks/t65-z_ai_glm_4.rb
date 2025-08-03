
def circular_shift(x, shift)
  s = x.to_s
  n = s.length
  if shift > n
    s.reverse
  else
    s[-shift..-1] + s[0...n-shift]
  end
end