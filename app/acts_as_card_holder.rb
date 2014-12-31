# This module replaces the Hand and HandTotal modules from before.
# Including this module in a class gives it the "CardHolder" duck-type; a user who may
# hold and play with Cards.
module ActsAsCardHolder
  
  # The total hand value required to win the Game
  BLACKJACK_AMOUNT = 21

  attr_writer :cards_held
  
  # The Cards held by this CardHolder.
  #
  # Returns an Array
  def cards_held
    @cards_held ||= []
  end
  
  # Adds a Card to the CardHolder's hand.
  def receive_card(card)
    cards_held << card
  end
  
  # Sets the CardHolder's hand back to empty.
  def clear_hand
    self.cards_held = []
  end
  
  # The Cards in the CardHolder's hand that are Aces.
  def aces
    cards_held.select(&:ace?)
  end
  
  # The total value of the Card's in the CardHolder's hand.
  # If the total is above BLACKJACK_AMOUNT and the CardHolder has aces, treats the aces
  # as "1" to reduce the hand value. Otherwise, aces are high.
  #
  # Returns an Integer.
  def hand_total
    hand_total_value = cards_held.map(&:game_value).inject(&:+)
    return hand_total_value unless hand_total_value > BLACKJACK_AMOUNT and aces.any?

    aces_to_reduce = Array.new(aces.count, :ace) # => [:ace, :ace]
    while hand_total_value > BLACKJACK_AMOUNT && aces_to_reduce.any? do
      hand_total_value -= 9
      aces_to_reduce.pop
    end
    hand_total_value
  end
  
  # Is the CardHolder's hand greater than BLACKJACK_AMOUNT
  #
  # Returns true or false
  def bust?
    hand_total > BLACKJACK_AMOUNT
  end

  # Is the CardHolder's hand equal to BLACKJACK_AMOUNT  
  #
  # Returns true or false
  def blackjack?
    hand_total == BLACKJACK_AMOUNT
  end
  
end