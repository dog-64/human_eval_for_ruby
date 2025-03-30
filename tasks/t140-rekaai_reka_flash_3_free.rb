
def fix_spaces(text)
  text.sub(/\s+/, lambda { |s| s.size <= 2 ? s.tr(' ', '_') : '-' })
end

 