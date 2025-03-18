def fix_spaces(text)
  text.gsub(/ +/, '-').gsub(/\s+/, '_')
end