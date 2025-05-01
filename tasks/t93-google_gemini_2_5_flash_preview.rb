def encode(message)
  vowels = "aeiouAEIOU"
  encoded_message = ""
  message.each_char do |char|
    if vowels.include?(char)
      encoded_message += (char.ord + 2).chr
    elsif char.upcase == char
      encoded_message += char.downcase
    else
      encoded_message += char.upcase
    end
  end
  encoded_message
end