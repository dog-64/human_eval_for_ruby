def correct_bracketing(brackets)
  stack = []
  brackets.each_char do |bracket|
    if bracket == "("
      stack.push(bracket)
    elsif bracket == ")"
      return false if stack.empty?
      stack.pop
    end
  end
  stack.empty?
end