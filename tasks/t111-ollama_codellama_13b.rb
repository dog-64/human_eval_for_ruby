def histogram(text)
  # Initialize an empty hash to store the character frequencies
  freq = {}

  # Iterate over each character in the input text
  text.each_char do |c|
    # If the character is a lowercase letter, increment its frequency
    if c.downcase >= 'a' && c.downcase <= 'z'
      freq[c] ||= 0
      freq[c] += 1
    end
  end

  # Return the hash with the character frequencies
  freq
end