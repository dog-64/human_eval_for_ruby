def encode(message)
  vowels = 'aeiouAEIOU'
  message.tr('a-zA-Z', 'b-zA-yB-ZA-Y').gsub(/([aeiou])/) { |match| (match.ord + 2).chr }.gsub(/([AEIOU])/) { |match| (match.ord + 2).chr }
end