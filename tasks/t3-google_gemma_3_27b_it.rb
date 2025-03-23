
def below_zero?(operations)
  balance = 0
  operations.each do |operation|
    balance += operation
    return true if balance < 0
  end
  false
end
