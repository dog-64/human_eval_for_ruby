def is_happy?(s)
  return false if s.size < 3
  s.size > 2 && s[0] != s[1] && s[1] != s[2]
end