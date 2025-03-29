def is_nested?(string)
  stack = []
  has_nested = false

  string.each_char do |char|
    if char == '['
      stack.push(char)
    elsif char == ']'
      if stack.size >= 2
        has_nested = true
        stack.pop
      elsif !stack.empty?
        stack.pop
      end
    end
  end

  has_nested
end