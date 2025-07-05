def decimal_to_binary(decimal)
  if decimal == 0
    return "db0db"
  end
  binary = ""
  while decimal > 0
    remainder = decimal % 2
    binary = remainder.to_s + binary
    decimal = decimal / 2
  end
  return "db" + binary + "db"
end
