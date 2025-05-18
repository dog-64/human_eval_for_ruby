def prime_length_words(sentence)
  words = sentence.split
  prime_words = words.select { |word| is_prime?(word.length) }
  prime_words.join(' ')
end

def is_prime?(num)
  return false if num <= 1
  (2..Math.sqrt(num)).none? { |i| num % i == 0 }
end