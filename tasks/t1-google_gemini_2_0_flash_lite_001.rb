def separate_paren_groups(paren_string)
  paren_string = paren_string.gsub(/\s+/, "")
  result = []
  count = 0
  start = 0

  paren_string.chars.each_with_index do |char, index|
    if char == '('
      count += 1
    elsif char == ')'
      count -= 1
    end

    if count == 0 && char == ')'
      result << paren_string[start..index]
      start = index + 1
    end
  end
  result
end