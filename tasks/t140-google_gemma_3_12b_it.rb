def fix_spaces(text)
  result = ""
  count = 0
  text.each_char do |char|
    if char == ' '
      count += 1
      if count > 2
        result += "-"
        count = 0
      else
        result += "_"
      end
    else
      result += char
      count = 0
    end
  end
  result
end
