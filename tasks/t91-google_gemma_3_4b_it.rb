def count_boredoms(text)
  count = 0
  sentences = text.split(/[.?!]/)
  sentences.each do |sentence|
    if sentence.start_with?('I')
      count += 1
    end
  end
  count
end
