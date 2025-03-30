
def correct_bracketing(brackets)
  stack = []
  brackets.each_char do |char|
    case char
    when '(' then stack << char
    when ')'
      return false if stack.empty?
      stack.pop
    end
  end
  stack.empty?
end

 