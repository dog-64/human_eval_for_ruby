def prime_length_words(sentence)
  words = sentence.split
  primes = words.select { |word| prime?(word.length) }
  primes.join(' ')
end

def prime?(n)
  return false if n < 2
  return true if n == 2
  return false if n.even?
  limit = Math.sqrt(n).to_i
  (3..limit).step(2).none? { |i| n % i == 0 }
end