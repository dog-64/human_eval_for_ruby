def prime_length_words(sentence)
  def prime?(n)
    return false if n <= 1
    (2..Math.sqrt(n)).none? { |i| n % i == 0 }
  end

  sentence.split.select { |word| prime?(word.length) }.join(' ')
end