def fix_spaces(text)
  text.gsub(/\s{2,}/, '-') + text.gsub(/\s/, '_')
end