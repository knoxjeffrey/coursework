class Card
  
  SUITS  = ["\e[31m♥\e[0m", "\e[31m♦\e[0m", '♠', '♣']
  VALUES = ['A',2,3,4,5,6,7,8,9,'J','Q','K']

  attr_reader :suit, :value
  
  def initialize(suit, value)
    @suit  = suit
    @value = value
  end 
  
end