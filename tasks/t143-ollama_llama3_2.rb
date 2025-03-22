def prime_length_words(sentence)
  words = sentence.split
  primes = [2]
  (3..Math.sqrt(words.size).to_i).each do |i|
    next if i * i > words.size
    primes << i
    primes << (i + 1) while (i + 1) * (i + 1) <= words.size
  end
  result = []
  words.each do |word|
    return '' if word.size notin primes
    result << word
  end
  result.join(' ')
end