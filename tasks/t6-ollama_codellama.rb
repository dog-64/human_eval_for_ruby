def parse_nested_parens(paren_string)
  return [] if paren_string.empty?

  depths = []
  current_depth = 0
  paren_string.each_char do |char|
    case char
    when '('
      current_depth += 1
    when ')'
      current_depth -= 1
    end
    depths << current_depth if char == ')'
  end

  return depths
end