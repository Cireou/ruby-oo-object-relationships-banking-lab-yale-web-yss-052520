class Transfer
  attr_reader :sender, :receiver
  attr_accessor :amount, :status, :lastAmount

  def initialize(sender, receiver, amount = 50)
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = "pending"

  end

  def valid?()
    self.sender.valid?() && self.receiver.valid?()
  end

  def execute_transaction()
    return if self.status == "complete"

    if (self.sender.balance >= amount && self.valid?())
      self.sender.balance -= amount
      self.receiver.balance += amount
      self.status = "complete"
      self.lastAmount = amount
    else
      self.status = "rejected"
      return "Transaction rejected. Please check your account balance."
    end
  end

  def reverse_transfer()
    return if self.status != "complete"

    self.sender.balance += self.lastAmount 
    self.receiver.balance -= self.lastAmount
    self.status = "reversed"
  end

end
