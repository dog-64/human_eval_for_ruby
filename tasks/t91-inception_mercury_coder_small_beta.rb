def count_boredoms(text)
  sentences = text.split(/(?<=[.!?])\s+/)
  sentences.count { |sentence| sentence.strip.start_with?('I ') }
end