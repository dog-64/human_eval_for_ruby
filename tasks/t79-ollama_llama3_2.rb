def decimal_to_binary(decimal)
  binary = ''
  while decimal > 0
    binary << (decimal % 2).to_s
    decimal /= 2
  end
  'db' + binary + 'db'
end