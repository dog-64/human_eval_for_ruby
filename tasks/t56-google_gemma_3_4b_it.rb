def correct_bracketing(brackets)
  stack = []
  brackets.each_char do |char|
    if char == '<'
      stack << char
    elsif char == '>'
      if stack.empty?
        return false
      else
        stack.pop
      end
    else
      return false
    end
  end
  stack.empty?
end
