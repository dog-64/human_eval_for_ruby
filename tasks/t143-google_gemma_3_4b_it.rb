def prime_length_words(sentence)
  words = sentence.split
  prime_words = []
  words.each do |word|
    if is_prime?(word.length)
      prime_words << word
    end
  end
  prime_words.join(' ')
end

def is_prime?(num)
  return false if num <= 1
  (2..Math.sqrt(num)).each do |i|
    return false if num % i == 0
  end
  true
end
