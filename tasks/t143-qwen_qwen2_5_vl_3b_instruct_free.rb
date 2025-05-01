def prime_length_words(sentence)
  words = sentence.split(' ')
  result = words.select { |word| word.length.prime? }
  result.join(' ')
end
