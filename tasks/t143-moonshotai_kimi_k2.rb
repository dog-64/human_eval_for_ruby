def prime_length_words(sentence)
  words = sentence.split
  prime_words = words.select { |word| prime?(word.length) }
  prime_words.join(' ')
end

def prime?(n)
  return false if n < 2
  (2..Math.sqrt(n)).none? { |i| n % i == 0 }
end