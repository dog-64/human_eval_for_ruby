def prime_length_words(sentence)
  prime = ->(n) {
    return false if n <= 1
    (2..Math.sqrt(n).floor).all? { |i| n % i != 0 }
  }
  sentence.split.select { |word| prime.call(word.length) }.join(" ")
end