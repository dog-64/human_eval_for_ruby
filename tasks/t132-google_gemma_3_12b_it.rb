def is_nested?(string)
  return false if string.empty?
  stack = []
  for char in string
    if char == '['
      stack.push(char)
    elsif char == ']'
      if stack.empty?
        return false
      else
        stack.pop
      end
    end
  end
  return stack.empty? && string.count('[') > 0 && string.count(']') > 0 && string.include?('[[]]')
end
