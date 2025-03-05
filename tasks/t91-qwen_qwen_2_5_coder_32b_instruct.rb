def count_boredoms(text)
  text.split(/(?<=[.?!])\s+/).count { |sentence| sentence.start_with?("I ") || sentence == "I" }
end