def prime_length_words(sentence)
  words = sentence.split
  primes = words.select { |word| prime?(word.length) }
  primes.join(' ')
end

def prime?(n)
  return false if n <= 1
  return true if n == 2
  (2..Math.sqrt(n).to_i).none? { |i| n % i == 0 }
end