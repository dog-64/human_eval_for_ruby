def count_boredoms(text)
  return 0 if text.empty?

  sentences = text.split(/[.?!]/)
  count = 0
  sentences.each do |sentence|
    trimmed_sentence = sentence.strip
    count += 1 if trimmed_sentence.start_with?("I ") || trimmed_sentence == "I"
  end
  count
end