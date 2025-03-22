def fix_spaces(text)
  text.gsub(/ {2,}/, '-').tr(' ', '_')
end