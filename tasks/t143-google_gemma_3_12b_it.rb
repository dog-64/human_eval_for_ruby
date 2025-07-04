def prime_length_words(sentence)
  def is_prime?(n)
    return false if n <= 1
    (2..Math.sqrt(n)).none? { |i| n % i == 0 }
  end

  words = sentence.split
  prime_words = words.select { |word| is_prime?(word.length) }
  prime_words.join(" ")
end
