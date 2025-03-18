def correct_bracketing(brackets)
  stack = []
  brackets.each_char do |char|
    case char
    when '('
      stack << char
    when ')'
      if stack.empty? || stack.pop != '('
        return false
      end
    end
  end
  stack.empty?
end