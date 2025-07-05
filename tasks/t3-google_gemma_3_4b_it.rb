class BankAccount
  def initialize
    @balance = 0
  end

  def below_zero?(operations)
    operations.each do |operation|
      @balance += operation
      return true if @balance < 0
    end
    false
  end
end
