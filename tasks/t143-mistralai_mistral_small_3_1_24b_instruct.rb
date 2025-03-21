def prime?(num)
  return false if num < 2
  (2..Math.sqrt(num)).each do |i|
    return false if num % i == 0
  end
  true
end

def prime_length_words(sentence)
  sentence.split.select { |word| prime?(word.length) }.join(' ')
end