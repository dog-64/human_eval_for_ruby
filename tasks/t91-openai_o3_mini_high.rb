def count_boredoms(text)
  return 0 if text.nil? || text.empty?
  sentences = text.split(/[.?!]+/).map(&:strip)
  sentences.count { |sentence| sentence.split.first == "I" }
end