def correct_bracketing(brackets)
  stack = []
  brackets.each_char do |char|
    case char
    when "<"
      stack.push(char)
    when ">"
      return false unless !stack.empty? && stack.pop == "<"
    end
  end
  stack.empty?
end