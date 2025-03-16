def is_happy?(s)
  return false if s.length < 3
  s = s.downcase
  (0..s.length - 3).each do |i|
    a, b, c = s[i], s[i + 1], s[i + 2]
    return false if a == b || b == c || a == c
  end
  true
end