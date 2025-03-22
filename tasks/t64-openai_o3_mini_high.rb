def vowels_count(word)
  return 0 if word.empty?

  word = word.downcase
  count = 0
  word.chars.each_with_index do |char, idx|
    if %w[a e i o u].include?(char)
      count += 1
    elsif char == 'y' && idx == word.length - 1
      count += 1
    end
  end
  count
end