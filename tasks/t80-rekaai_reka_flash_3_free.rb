
def is_happy?(s)
  return false if s.length < 3
  lower_s = s.downcase
  (0...lower_s.length - 2).each do |i|
    a, b, c = lower_s[i], lower_s[i+1], lower_s[i+2]
    return false if a == b || b == c || a == c
  end
  true
end

 