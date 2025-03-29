def fix_spaces(text)
  return "" if text.nil?  # Защита от nil
  result = text.gsub(/ {3,}/, '-').gsub(' ', '_')
  result
end
