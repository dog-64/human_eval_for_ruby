def is_happy?(s)
  return false if s.length < 3

  s_lower = s.downcase
  (0..s_lower.length - 3).each do |i|
    return false if s_lower[i] == s_lower[i + 1] || s_lower[i] == s_lower[i + 2] || s_lower[i + 1] == s_lower[i + 2]
  end

  true
end