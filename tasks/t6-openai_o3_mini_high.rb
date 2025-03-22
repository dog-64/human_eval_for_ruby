def parse_nested_parens(paren_string)
  return [] if paren_string.strip.empty?
  
  paren_string.split.each_with_object([]) do |group, depths|
    current_depth = 0
    max_depth = 0
    group.each_char do |ch|
      if ch == '('
        current_depth += 1
        max_depth = current_depth if current_depth > max_depth
      elsif ch == ')'
        current_depth -= 1
      end
    end
    depths << max_depth
  end
end