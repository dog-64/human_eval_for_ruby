def remove_vowels(text)
  result = ''
  text.each_char do |char|
    if !['a', 'e', 'i', 'o', 'u', 'A', 'E', 'I', 'O', 'U'].include?(char)
      result += char
    end
  end
  result
end
