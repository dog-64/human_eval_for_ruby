require 'prime'

def prime_length_words(sentence)
  sentence.split.map { |word| word.length.even? ? nil : word }.compact.join(' ')
end