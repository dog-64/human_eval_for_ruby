def encode(message)
  message.downcase!
  message.gsub!(/[aeiou]/, 'c')
  message.gsub!(/[AEIOU]/, 'C')
  message.gsub!(/[bcdfghjklmnpqrstvwxyz]/, 'x')
  message.gsub!(/[BCDFGHJKLMNPQRSTVWXYZ]/, 'X')
  return message
end