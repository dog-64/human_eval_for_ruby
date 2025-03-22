def below_zero?(operations)
  balance = 0
  operations.each do |operation|
    balance += operation
    break if balance < 0
  end
  balance < 0
end