def count_boredoms(text)
  return 0 if text.empty?

  sentences = text.split(/[.!?]/)
  count = 0

  sentences.each do |sentence|
    sentence.strip!
    count += 1 if sentence.start_with?("I ") || sentence == "I"
  end

  count
end