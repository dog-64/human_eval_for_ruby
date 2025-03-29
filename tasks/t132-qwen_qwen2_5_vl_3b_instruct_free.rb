def is_nested?(string)
  stack = []
  nested = false

  string.each_char do |char|
    if char == '['
      stack.push(char)
    else
      if stack.empty?
        nested = true
      else
        stack.pop
      end
    end
  end

  nested && !stack.empty?
end