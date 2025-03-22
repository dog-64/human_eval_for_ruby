def parse_nested_parens(paren_string)
  return [] if paren_string.empty?

  depths = []
  current_depth = 0
  balanced = true

  paren_string.each_char do |char|
    case char
    when '('
      current_depth += 1
      balanced = false if current_depth == 0
    when ')'
      current_depth -= 1
      balanced = false if current_depth < 0
    end

    depths << current_depth if balanced
  end

  return depths
end