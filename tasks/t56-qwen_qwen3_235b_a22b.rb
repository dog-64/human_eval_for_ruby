def correct_bracketing(brackets)
  return false if brackets.length.odd?
  stack = []
  brackets.each_char do |char|
    if char == '<'
      stack << char
    else
      return false if stack.empty?
      stack.pop
    end
  end
  stack.empty?
end