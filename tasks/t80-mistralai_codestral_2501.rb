def is_happy?(s)
  return false if s.length < 3

  s.each_char.with_index do |char, index|
    return false if index >= 2 && s[index] == s[index - 1] && s[index - 1] == s[index - 2]
  end

  true
end