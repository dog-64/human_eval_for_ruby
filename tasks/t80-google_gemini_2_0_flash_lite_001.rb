def is_happy?(s)
  return false if s.length < 3

  s.downcase!

  (0..s.length - 3).each do |i|
    if s[i] == s[i+1] && s[i] == s[i+2]
      return false
    end
  end
  
  true
end