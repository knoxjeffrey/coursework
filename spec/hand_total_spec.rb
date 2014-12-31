require 'spec_helper'
require 'hand_total'

describe HandTotal do

  describe :card_total do
    it "should add up the value numbers" do
      card_array = [['♠',2], ['♠',7], ['♠',8]]
      expect(HandTotal.card_total(card_array)).to eq(17)
    end
    
    it "should count K,Q,J as 10 when adding up the values" do
      card_array = [['♠','K'], ['♠','Q'], ['♠','J']]
      expect(HandTotal.card_total(card_array)).to eq(30)
    end
    
    it "should count an ace as 11 if the total is 21 or less" do
      card_array = [['♠','A'], ['♠',8], ['♠',2]]
      expect(HandTotal.card_total(card_array)).to eq(21)
    end
    
    it "should count an ace as 1 if the total would be over 21 with an ace as 11" do
      card_array = [['♠','A'], ['♠','Q'], ['♠',3]]
      expect(HandTotal.card_total(card_array)).to eq(14)
    end
    
    it "should count subsequent aces as 1" do
      card_array = [['♠','A'], ['♠','A'], ['♠',5], ['♠',3]]
      expect(HandTotal.card_total(card_array)).to eq(20)
    end
    
  end
end