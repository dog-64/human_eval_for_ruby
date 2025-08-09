def fix_spaces(text)
  text.gsub(/ +/) { |s| s.length > 2 ? '-' : '_' * s.length }
end