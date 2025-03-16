def separate_paren_groups(paren_string)
  s = paren_string.gsub(/\s+/, '')
  result = []
  current = ""
  depth = 0
  s.each_char do |ch|
    if ch == '('
      current << ch
      depth += 1
    elsif ch == ')'
      current << ch
      depth -= 1
      if depth < 0
        current = ""
        depth = 0
      elsif depth == 0
        result << current
        current = ""
      end
    end
  end
  result
end