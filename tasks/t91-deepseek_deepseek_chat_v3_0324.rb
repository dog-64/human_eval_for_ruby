def count_boredoms(text)
  sentences = text.split(/[.!?]/)
  sentences.count { |s| s.strip.start_with?('I ') || s.strip == 'I' }
end