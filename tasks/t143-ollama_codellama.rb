def prime_length_words(sentence)
  words = sentence.split(" ")
  new_words = []
  words.each do |word|
    if word.length.prime?
      new_words << word
    end
  end
  return new_words.join(" ")
end