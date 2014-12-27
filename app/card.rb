class Card
  
  SUITS  = ["\e[31m♥\e[0m", "\e[31m♦\e[0m", '♠', '♣']
  VALUES = [ 2, 3, 4, 5, 6, 7, 8, 9, 'J','Q','K','A']
  
  attr_reader :suit, :value
  
  # Convenience method. Creates a new, unturned card.
  def self.unturned
    new('*', '*')
  end
  
  def initialize(suit, value)
    @suit  = suit
    @value = value
  end 
  
  # The in-hand value of the Card. 
  #
  # Returns an Integer between 1 and 10
  def game_value
    [VALUES.index(value) + 2, 10].min
  end
  
  # Is this Card an Ace?
  #
  # Returns true or false
  def ace?
    value == 'A'
  end
  
end