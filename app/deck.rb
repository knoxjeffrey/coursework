class Deck
  
  require_relative 'card'
  attr_reader :cards

  def initialize
    suits_and_values = Card::SUITS.product(Card::VALUES)
    @cards = suits_and_values.map { |suit_and_value| Card.new(suit_and_value[0], suit_and_value[1]) }
  end

end