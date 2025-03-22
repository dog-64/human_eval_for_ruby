def is_nested?(string)
  stack = []
  nested = false
  string.each_char do |char|
    if char == '['
      stack.push(char)
    elsif char == ']'
      if stack.empty?
        return false
      end
      stack.pop
    end
    if stack.size > 0 && string.index(']') > string.index('[') && string.count('[') > 1 && string.count(']') > 1
        nested = true
    end
  end
  
  if stack.empty? && nested
      return true
  end
  
  false
end