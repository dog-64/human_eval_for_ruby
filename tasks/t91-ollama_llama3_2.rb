def count_boredoms(text)
  text.split('.').map { |s| s.strip }.select { |s| s =~ /^I/ }.size
end