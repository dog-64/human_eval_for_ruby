
def correct_bracketing(brackets)
  return true if brackets.empty?
  return false unless brackets.match?(/^[<>]*$/)

  stack = []
  brackets.each_char do |char|
    stack << char if char == '<'
    return false if char == '>' && stack.empty?
    stack.pop if char == '>'
  end

  stack.empty?
end

 