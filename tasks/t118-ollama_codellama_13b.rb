def get_closest_vowel(word)
  # Split the word into an array of characters
  chars = word.split("")

  # Iterate over the characters in the array, starting from the last character
  for i in (0..chars.length-1).to_a.reverse do
    # If the current character is a vowel, return it
    if ["a", "e", "i", "o", "u"].include?(chars[i])
      return chars[i]
    end
  end

  # If no vowel was found, return an empty string
  return ""
end