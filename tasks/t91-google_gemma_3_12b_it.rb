def count_boredoms(text)
  return 0 if text.empty?
  sentences = text.split(/[.?!]/).map(&:strip)
  count = 0
  sentences.each do |sentence|
    count += 1 if sentence.start_with?("I")
  end
  count
end
