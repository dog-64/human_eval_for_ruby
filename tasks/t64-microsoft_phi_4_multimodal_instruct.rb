def vowels_count(word)
  count = 0
  word.each_char do |char|
    if %w[a e i o u y].include?(char) || (char == 'y' && word.end_with?(char))
      count += 1
    end
  end
  count
end