def is_happy?(s)
  return false if s.length < 3
  return true if s.chars.uniq.length == 1
  return false if s.chars.slice(0, 3).all? { |c| c == s[0] }
  return false if s.chars.slice(1, 3).all? { |c| c == s[1] }
  return false if s.chars.slice(2, 3).all? { |c| c == s[2] }
  true
end