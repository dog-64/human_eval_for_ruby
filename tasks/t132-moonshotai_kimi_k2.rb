def is_nested?(string)
  return false if string.length < 4
  
  balance = 0
  max_depth = 0
  
  string.each_char do |char|
    if char == '['
      balance += 1
      max_depth = [max_depth, balance].max
    elsif char == ']'
      balance -= 1
    end
    
    return false if balance < 0
  end
  
  balance == 0 && max_depth >= 2
end