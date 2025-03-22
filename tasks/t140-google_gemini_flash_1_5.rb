def fix_spaces(text)
  text.gsub(/ +/, lambda { |match| match.length > 2 ? '-' : '_' })
end
