def correct_bracketing(brackets)
  stack = []
  brackets.each_char do |char|
    if char == '('
      stack.push(char)
    elsif char == ')'
      return false if stack.empty?
      stack.pop
    end
  end
  stack.empty?
end