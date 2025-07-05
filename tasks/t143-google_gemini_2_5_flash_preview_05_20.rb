def prime_length_words(sentence)
  def is_prime?(n)
    return false if n < 2
    (2..Math.sqrt(n)).each do |i|
      return false if n % i == 0
    end
    true
  end

  sentence.split.filter_map do |word|
    word if is_prime?(word.length)
  end.join(' ')
end