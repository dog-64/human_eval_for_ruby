def prime_length_words(sentence)
  words = sentence.split
  primes = []
  words.each do |word|
    len = word.length
    if len < 2
      next
    end
    is_prime = true
    (2..Math.sqrt(len)).each do |i|
      if len % i == 0
        is_prime = false
        break
      end
    end
    primes << word if is_prime
  end
  primes.join(' ')
end