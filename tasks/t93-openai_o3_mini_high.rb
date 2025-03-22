def encode(message)
  message.swapcase.tr("AEIOUaeiou", "CGKQWcgkqw")
end