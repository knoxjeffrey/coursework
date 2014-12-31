require 'spec_helper'
require_relative '../app/hand'
require 'player'

describe Player do
  
  describe :initialize do
    
    it "should accept a name and set the #name attribute" do
      expect(Player.new('Jeff', 100).name).to eql('Jeff')
    end
    
    it "should initialize with an empty array do" do
      expect(Player.new('Jeff', 100).cards_held.empty?).to be true
    end
  end
  
  describe :amount_in_account do
    
    it "should accept a numerical value and return that value" do
      expect(Player.new('Jeff', 100).amount_in_account).to eql(100)
    end
  end
  
  describe :win_money do
    
    it "should accept a numerical value and add that to the account" do
      new_player = Player.new('Jeff', 100)
      new_player.win_money(10)
      expect(new_player.amount_in_account).to eq(110)
    end
  end
  
  describe :lose_money do
    
    it "should accept a numerical value and subtract that from the account" do
      new_player = Player.new('Jeff', 100)
      new_player.lose_money(10)
      expect(new_player.amount_in_account).to eq(90)
    end
  end
  
end