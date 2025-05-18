def is_nested?(string)
  stack = []
  nested = false

  string.each_char do |char|
    if char == '['
      stack << char
    elsif char == ']'
      if stack.empty?
        return false
      end
      stack.pop
      nested = true unless stack.empty?
    end
  end

  nested && stack.empty?
end