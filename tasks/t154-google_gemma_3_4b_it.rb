def cycpattern_check(a, b)
  return false if a.empty? || b.empty?
  return true if b.length > a.length
  
  a_chars = a.chars
  b_chars = b.chars
  
  a_chars.each do |char_a|
    found = false
    (0..b_chars.length - 1).each do |i|
      if char_a == b_chars[i]
        found = true
        break
      end
    end
    
    if !found
      return false
    end
  end
  
  return true
end
