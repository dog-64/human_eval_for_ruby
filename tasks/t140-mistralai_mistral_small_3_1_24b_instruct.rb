def fix_spaces(text)
  text.gsub(/\s+/) do |match|
    match.length > 2 ? '-' : '_'
  end
end