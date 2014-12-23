class Deck
  
  require_relative 'card'
  attr_reader :cards

  def initialize
    @cards = Card::SUITS.product(Card::VALUES)
  end

end