def below_zero?(operations)
  balance = 0
  operations.each do |op|
    balance += op
    return true if balance < 0
  end
  false
end