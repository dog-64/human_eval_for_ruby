def parse_nested_parens(paren_string)
  paren_string.split.map do |group|
    current_depth = 0
    max_depth = 0
    group.chars.each do |char|
      if char == '('
        current_depth += 1
        max_depth = current_depth if current_depth > max_depth
      else
        current_depth -= 1
      end
    end
    max_depth
  end
end