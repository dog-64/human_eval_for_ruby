def get_closest_vowel(word)
  word = word.downcase
  vowels = ['a', 'e', 'i', 'o', 'u']
  idx = -1
  for i in (0...word.size-1) do
    if word[i].bytes.include?('b') || word[i].bytes.include?('p')
      next
    end
    idx = i
    break
  end
  return '' if idx == -1

  min_dist = Float::INFINITY
  closest_vowel = ''

  for vowel in vowels do
    dist = (idx + 1).abs - word.index(vowel, idx+1)
    return vowel if dist < min_dist
    min_dist = dist
    closest_vowel = vowel
  end

  closest_vowel
end