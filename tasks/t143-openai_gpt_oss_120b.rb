def prime?(n)
  return false if n < 2
  return true if n == 2
  return false if n.even?
  i = 3
  while i * i <= n
    return false if n % i == 0
    i += 2
  end
  true
end

def prime_length_words(sentence)
  words = sentence.split(' ')
  selected = words.select { |w| prime?(w.length) }
  selected.join(' ')
end