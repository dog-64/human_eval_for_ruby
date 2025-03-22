def count_boredoms(text)
  return 0 if text.empty?

  sentences = text.split(/[.?!]/)
  sentences.count { |sentence| sentence.strip.start_with?('I') }
end