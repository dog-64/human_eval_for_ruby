def is_happy?(s)
  return false if s.length < 3
  return false if s[0..2].include? s[1] && s[1..2].include? s[2]
  true
end