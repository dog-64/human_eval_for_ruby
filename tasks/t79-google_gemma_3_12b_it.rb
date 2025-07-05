def decimal_to_binary(decimal)
  return "db0db" if decimal == 0
  binary = decimal.to_s(2)
  "db#{binary}db"
end
