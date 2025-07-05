def is_prime(n)
  return false if n <= 1
  (2..Math.sqrt(n)).none? { |i| n % i == 0 }
end

def prime_length_words(sentence)
  sentence.split.select { |word| is_prime(word.length) }.join(' ')
end