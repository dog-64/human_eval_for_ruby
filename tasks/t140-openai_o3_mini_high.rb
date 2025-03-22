def fix_spaces(text)
  text.gsub(/ +/) do |spaces|
    if spaces.size > 2
      "-"
    else
      if Regexp.last_match.begin(0).zero?
        "_" 
      else
        "_" * spaces.size
      end
    end
  end
end