def fix_spaces(text)
  text.gsub(/ +/) do |match|
    if match.length > 2
      "-"
    else
      "_" * match.length
    end
  end
end