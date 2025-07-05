def is_nested?(string)
  stack = []
  nested = false
  string.each_char do |char|
    if char == '['
      stack.push(char)
    elsif char == ']'
      if stack.empty?
        return false
      else
        stack.pop
        nested = true if !stack.empty?
      end
    end
  end
  !stack.empty? ? false : nested
end
