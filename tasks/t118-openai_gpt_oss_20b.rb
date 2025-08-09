def get_closest_vowel(word)
  vowels = 'aeiouAEIOU'
  len = word.length
  return '' if len < 3
  (len - 2).downto(1) do |i|
    char = word[i]
    next unless vowels.include?(char)
    left = word[i - 1]
    right = word[i + 1]
    next if vowels.include?(left) || vowels.include?(right)
    return char
  end
  ''
end