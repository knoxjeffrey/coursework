class Card
  
  SUITS  = ["\e[31m♥\e[0m", "\e[31m♦\e[0m", '♠', '♣']
  VALUES = [ 2, 3, 4, 5, 6, 7, 8, 9, 'J','Q','K','A']
  
  attr_reader :suit, :value
  
  def self.unturned
    new('*', '*')
  end
  
  def initialize(suit, value)
    @suit  = suit
    @value = value
  end 
  
  def game_value
    [VALUES.index(value) + 2, 10].min
  end
  
  def ace?
    value == 'A'
  end
  
end