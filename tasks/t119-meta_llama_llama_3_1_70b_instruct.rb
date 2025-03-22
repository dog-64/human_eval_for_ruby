def match_parens(lst)
  def is_balanced(str)
    stack = []
    str.each_char do |char|
      if char == '('
        stack.push(char)
      else
        return false if stack.empty?
        stack.pop
      end
    end
    stack.empty?
  end

  is_balanced(lst[0] + lst[1]) || is_balanced(lst[1] + lst[0]) ? 'Yes' : 'No'
end