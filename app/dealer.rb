class Dealer
  
  require_relative 'acts_as_card_holder'

  include ActsAsCardHolder
  
  attr_reader :name
  
  def initialize(name)
    @name = name
  end
  
  # Is the Dealer going to "stick" with his current Cards?
  #
  # Returns true if the hand_total is between 18 and 21
  def sticking?
    hand_total.between?(18,21)
  end
  
  # A "hand" for the Dealer with an unturned Card
  #
  # Returns an Array of Cards
  def hand_with_hole_card 
    [Card.unturned, cards_held[1]]
  end
  
end

