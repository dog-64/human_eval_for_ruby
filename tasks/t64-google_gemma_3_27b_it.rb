
def vowels_count(word)
  count = 0
  word.each_char do |char|
    if 'aeiouAEIOU'.include?(char)
      count += 1
    elsif char == 'y' || char == 'Y'
      if word.end_with?('y') || word.end_with?('Y')
        count += 1
      end
    end
  end
  count
end
