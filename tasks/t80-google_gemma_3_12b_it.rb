def is_happy?(s)
  return false if s.length < 3
  s.downcase.chars.each_with_index do |char, index|
    return false if index > 0 && index < s.length - 1 &&
                     s[index].downcase == s[index - 1].downcase &&
                     s[index].downcase == s[index + 1].downcase
  end
  true
end
