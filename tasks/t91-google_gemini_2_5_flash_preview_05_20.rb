def count_boredoms(text)
  return 0 if text.empty?

  sentences = text.split(/[.?!]/)
  count = 0
  sentences.each do |sentence|
    stripped_sentence = sentence.strip
    count += 1 if stripped_sentence.start_with?("I ") || stripped_sentence == "I"
  end
  count
end