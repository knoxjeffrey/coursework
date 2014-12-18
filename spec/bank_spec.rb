require 'spec_helper'
require 'bank'

describe Bank do
  
  describe :initialize do
    
    it "should accept a numerical value and set the #bank attribute" do
      expect(Bank.new(100).bank).to eql(100)
    end
    
  end
  
  describe :deposit_money do
    
    it "should add the amount to the bank" do
      bank = Bank.new(100)
      bank.deposit_money(10)
      expect(bank.bank).to eql(110)
    end
  end
  
  describe :withdraw_money do
    
    it "should add the amount to the bank" do
      bank = Bank.new(100)
      bank.withdraw_money(10)
      expect(bank.bank).to eql(90)
    end
  end
end