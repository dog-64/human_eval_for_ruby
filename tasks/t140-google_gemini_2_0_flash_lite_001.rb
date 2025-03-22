def fix_spaces(text)
  parts = text.split(/  +/)
  result = parts.map do |part|
    part.gsub(' ', '_')
  end
  result.join('-')
end