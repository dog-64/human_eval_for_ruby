def parse_nested_parens(paren_string)
  paren_string.split.map do |group|
    max_depth = 0
    current_depth = 0
    group.each_char do |char|
      case char
      when '(' then current_depth += 1
      when ')' then current_depth -= 1
      end
      max_depth = [max_depth, current_depth].max
    end
    max_depth
  end
end