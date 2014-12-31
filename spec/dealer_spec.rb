require 'spec_helper'
require_relative '../app/hand'
require 'dealer'

describe Dealer do
  
  describe :initialize do
    
    it "should accept a name and set the #name attribute" do
      expect(Dealer.new('Kryton').name).to eql('Kryton')
    end
    
    it "should initialize with an empty array do" do
      expect(Dealer.new('Kryton').cards_held.empty?).to be true
    end
  end
  
  describe :sticking? do
    it "should return true if the dealer total is 18" do
      new_dealer = Dealer.new('Kryton')
      expect(new_dealer.sticking?(18)).to be true
    end
    
    it "should return true if the dealer total is 21" do
      new_dealer = Dealer.new('Kryton')
      expect(new_dealer.sticking?(21)).to be true
    end
    
    it "should return false if the dealer total is 17" do
      new_dealer = Dealer.new('Kryton')
      expect(new_dealer.sticking?(17)).to be false
    end
    
    it "should return true if the dealer total is 22" do
      new_dealer = Dealer.new('Kryton')
      expect(new_dealer.sticking?(22)).to be false
    end
  end
  
end