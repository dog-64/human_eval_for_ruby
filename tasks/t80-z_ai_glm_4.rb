
def is_happy?(s)
  return false if s.length < 3
  
  s_lower = s.downcase
  
  (0..(s_lower.length - 3)).each do |i|
    a = s_lower[i]
    b = s_lower[i+1]
    c = s_lower[i+2]
    return false if a == b || a == c || b == c
  end
  
  true
end