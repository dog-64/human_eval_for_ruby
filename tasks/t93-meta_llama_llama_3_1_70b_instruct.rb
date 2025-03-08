def encode(message)
  message.tr('aeiouAEIOU', 'cgywCGYW').swapcase
end