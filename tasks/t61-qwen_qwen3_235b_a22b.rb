def correct_bracketing(brackets)
  stack = []
  brackets.each_char do |c|
    if c == '('
      stack << c
    else
      return false if stack.empty?
      stack.pop
    end
  end
  stack.empty?
end