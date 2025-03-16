def prime_length_words(sentence)
  def prime?(num)
    return false if num < 2
    (2..Math.sqrt(num)).none? { |i| num % i == 0 }
  end

  words = sentence.split
  prime_words = words.select { |word| prime?(word.length) }
  prime_words.join(' ')
end