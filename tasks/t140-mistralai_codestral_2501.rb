def fix_spaces(text)
  text.gsub(/\s+/, ' ').gsub(/ {2,}/, '-').gsub(' ', '_')
end