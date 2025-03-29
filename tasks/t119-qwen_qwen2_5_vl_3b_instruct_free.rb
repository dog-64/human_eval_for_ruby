def match_parens(lst)
  stack = []
  balanced = true

  lst.each do |expr|
    expr.each_char do |char|
      if char == '('
        stack.push(char)
      else
        if stack.empty?
          balanced = false
          break
        end
        stack.pop
      end
    end
  end

  balanced && stack.empty? ? 'Yes' : 'No'
end