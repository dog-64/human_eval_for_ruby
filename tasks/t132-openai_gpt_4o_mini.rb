def is_nested?(string)
  stack = []
  has_nested = false

  string.each_char do |char|
    if char == '['
      stack.push(char)
    elsif char == ']'
      return false if stack.empty?
      stack.pop
      has_nested = true if stack.any?
    end
  end

  has_nested && stack.empty?
end