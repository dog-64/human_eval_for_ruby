def count_boredoms(text)
  sentences = text.split(/[.!?]/)
  sentences.count { |sentence| sentence.strip.start_with?("I ") }
end