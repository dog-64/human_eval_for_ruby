def fix_spaces(text)
  text.gsub(/ {3,}/, '-').gsub(' ', '_')
end