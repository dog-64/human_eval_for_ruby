def count_boredoms(text)
  text.split(/[.?!]/).count { |sentence| sentence.strip.start_with?("I") }
end