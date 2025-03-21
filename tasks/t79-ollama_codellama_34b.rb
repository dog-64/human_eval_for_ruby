
def decimal_to_binary(decimal)
    return "db0db" if decimal == 0
    binary = ""
    while decimal > 0
        binary = (decimal % 2).to_s + binary
        decimal /= 2
    end
    return "db" + binary + "db"
end