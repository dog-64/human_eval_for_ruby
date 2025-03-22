def vowels_count(word)
  count = 0
  word.each_char do |c|
    if c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u' || (c == 'y' && word[-1] == 'y')
      count += 1
    end
  end
  return count
end