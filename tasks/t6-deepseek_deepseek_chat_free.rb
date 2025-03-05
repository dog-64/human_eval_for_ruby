def parse_nested_parens(paren_string)
  return [] if paren_string.empty?
  paren_string.split.map do |group|
    max_depth = 0
    current_depth = 0
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