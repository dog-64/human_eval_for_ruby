
def decimal_to_binary(decimal)
  if decimal == 0
    return "db0db"
  end

  binary = ""
  while decimal > 0
    binary = (decimal % 2).to_s + binary
    decimal /= 2
  end

  "db" + binary + "db"
end
