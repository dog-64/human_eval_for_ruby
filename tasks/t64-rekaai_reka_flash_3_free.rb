
def vowels_count(word)
  return 0 if word.empty?

  count = 0
  vowels = %w[a e i o u]

  word.each_char.with_index do |char, index|
    if index == word.length - 1
      count += 1 if char.downcase.in?(vowels) || char.downcase == 'y'
    else
      count += 1 if char.downcase.in?(vowels)
    end
  end

  count
end

 