def fix_spaces(text)
  text.gsub(/ +/) do |spaces|
    spaces.size > 2 ? '-' : '_' * spaces.size
  end
end