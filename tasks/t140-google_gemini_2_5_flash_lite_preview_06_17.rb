def fix_spaces(text)
  text.gsub(/ {2,}/, '-') { |match| '-' }
      .gsub(/ /, '_')
end