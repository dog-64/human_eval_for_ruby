def fix_spaces(text)
  text.gsub(/\s{3,}/, '-').gsub(/\s+/, '_')
end
