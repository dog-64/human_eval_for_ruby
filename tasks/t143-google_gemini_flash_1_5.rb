def prime_length_words(sentence)
  words = sentence.split
  primes = words.select do |word|
    len = word.length
    next if len <= 1
    (2...len).none? { |i| len % i == 0 }
  end
  primes.join(" ")
end
