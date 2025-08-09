def separate_paren_groups(paren_string)
  clean = paren_string.gsub(/\s+/, '')
  result = []
  depth = 0
  start = nil
  clean.chars.each_with_index do |c, i|
    case c
    when '('
      depth += 1
      start = i if depth == 1
    when ')'
      if depth == 0
        next
      end
      depth -= 1
      if depth == 0 && start
        result << clean[start..i]
        start = nil
      end
    end
  end
  result
end