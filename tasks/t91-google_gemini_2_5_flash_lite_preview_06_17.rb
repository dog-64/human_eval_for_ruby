def count_boredoms(text)
  return 0 if text.nil? || text.empty?
  sentences = text.split(/[.?!]/)
  sentences.count { |sentence| sentence.strip.start_with?("I ") || sentence.strip == "I" }
end