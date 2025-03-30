
def prime_length_words(sentence)
  words = sentence.split(' ').reject(&:empty?)
  selected_words = words.select { |word| is_prime?(word.length) }
  selected_words.join(' ')
end

private

def is_prime?(n)
  return false if n <= 1
  return true if n <= 3
  return false if n % 2 == 0 || n % 3 == 0
  i = 5
  w = 2
  while i * i <= n
    if n % i == 0
      return false
    end
    i += w
    w = 6 - w
  end
  true
end

 