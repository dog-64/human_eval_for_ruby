
def circular_shift(x, shift)
  raise ArgumentError, "x must be non-negative" if x.negative?
  raise ArgumentError, "shift must be non-negative" if shift.negative?

  s = x.to_s
  n = s.length

  shift > n ? s.reverse : s[-shift, shift] + s[0...-shift]
end

 