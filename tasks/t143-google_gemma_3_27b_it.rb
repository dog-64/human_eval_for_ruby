
def prime_length_words(sentence)
  def is_prime(n)
    if n <= 1
      return false
    end
    i = 2
    while i * i <= n
      if n % i == 0
        return false
      end
      i += 1
    end
    return true
  end

  words = sentence.split
  result = []
  words.each do |word|
    if is_prime(word.length)
      result << word
    end
  end
  result.join(" ")
end
