def correct_bracketing(brackets)
  stack = []
  brackets.each_char do |char|
    if char == '<'
      stack.push(char)
    elsif char == '>'
      if stack.empty?
        return false
      else
        stack.pop
      end
    end
  end
  stack.empty?
end