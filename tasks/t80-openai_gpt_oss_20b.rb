def is_happy?(s)
  return false if s.length < 3
  (0..s.length - 3).each do |i|
    a = s[i]
    b = s[i + 1]
    c = s[i + 2]
    return false if a == b || a == c || b == c
  end
  true
end