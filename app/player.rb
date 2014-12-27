class Player
  
  require_relative 'bank'
  require_relative 'acts_as_card_holder'

  include ActsAsCardHolder

  attr_reader :name, :account
  
  def initialize(name, amount_in_bank)
    @name = name
    @account = Bank.new(amount_in_bank)
  end
  
  def amount_in_account
    account.bank
  end
  
  def win_money(amount)
    account.deposit_money(amount)
  end
  
  def lose_money(amount)
    account.withdraw_money(amount)
  end
  
end