class Dealer
  
  require_relative 'acts_as_card_holder'
  include ActsAsCardHolder
  
  attr_reader :name
  
  def initialize(name)
    super
    @name = name
  end
  
  def sticking?
    hand_total.between?(18,21)
  end
  
  def hand_with_hole_card 
    [Card.unturned, cards_held[1]]
  end
  
end

