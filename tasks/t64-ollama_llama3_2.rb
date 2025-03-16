def vowels_count(word)
  word.downcase.gsub(/[^aeiouy]/, '').split('').select { |c| c == 'y' }.size + (word[-1] == 'y' ? 1 : 0)
end