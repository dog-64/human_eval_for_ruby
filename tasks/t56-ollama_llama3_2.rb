def correct_bracketing(brackets)
  stack = []
  brackets.each_char do |bracket|
    if bracket == "<"
      stack << bracket
    elsif bracket == ">"
      return false unless stack.empty?
      stack.pop
    end
  end
  stack.empty?
end