def encode(message)
  message.downcase!
  message.gsub!(/[aeiou]/, '\\1')
  return message
end