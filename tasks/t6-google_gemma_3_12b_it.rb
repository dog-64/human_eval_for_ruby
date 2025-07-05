def parse_nested_parens(paren_string)
  result = []
  paren_string.split.each do |group|
    next if group.empty?
    max_depth = 0
    current_depth = 0
    group.each_char do |char|
      if char == '('
        current_depth += 1
        max_depth = [max_depth, current_depth].max
      elsif char == ')'
        current_depth -= 1
      end
    end
    result << max_depth
  end
  result
end
