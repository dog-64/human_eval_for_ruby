def count_boredoms(text)
  return 0 if text.empty?
  sentences = text.split(/[.?!]/)
  count = 0
  sentences.each do |sentence|
    sentence = sentence.strip
    if sentence.start_with?("I ")
      count += 1
    end
  end
  count
end
