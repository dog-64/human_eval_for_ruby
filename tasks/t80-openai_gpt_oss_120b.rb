def is_happy?(s)
  return false if s.nil? || s.length < 3
  str = s.downcase
  (0..str.length - 3).each do |i|
    a, b, c = str[i], str[i + 1], str[i + 2]
    return false unless a != b && a != c && b != c
  end
  true
end