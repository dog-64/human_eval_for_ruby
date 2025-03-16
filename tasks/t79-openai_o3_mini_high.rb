def decimal_to_binary(decimal)
  binary_string = decimal.to_s(2)
  "db#{binary_string}db"
end