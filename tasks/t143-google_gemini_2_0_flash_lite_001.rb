def prime_length_words(sentence)
  def is_prime(n)
    return false if n < 2
    (2..Math.sqrt(n)).none? { |i| n % i == 0 }
  end

  words = sentence.split
  result = words.select { |word| is_prime(word.length) }
  result.join(" ")
end