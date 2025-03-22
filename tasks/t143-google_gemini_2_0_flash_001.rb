def prime_length_words(sentence)
  def is_prime(n)
    return false if n <= 1
    (2..Math.sqrt(n)).each do |i|
      return false if n % i == 0
    end
    true
  end

  words = sentence.split
  result = words.select { |word| is_prime(word.length) }.join(" ")
  return result
end