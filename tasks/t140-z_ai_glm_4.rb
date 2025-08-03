
def fix_spaces(text)
  text = text.gsub(/ {3,}/, '-')
  text = text.gsub(/\A {2}/, '_')
  text = text.gsub(/\A /, '_')
  text = text.gsub(/ {2}\z/, '__')
  text = text.gsub(/ \z/, '_')
  text = text.gsub(/  /, '__')
  text = text.gsub(/ /, '_')
  text
end