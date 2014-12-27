module ActsAsCardHolder
  
  BLACKJACK_AMOUNT = 21
  
  attr_accessor :cards_held
    
  def initialize(*)
    @cards_held = []  
  end
  
  def receive_card(card)
    cards_held << card
  end
  
  def clear_hand
    self.cards_held = []
  end
  
  def aces
    cards_held.select(&:ace?)
  end
  
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
  
  def bust?
    hand_total > BLACKJACK_AMOUNT
  end
  
  def blackjack?
    hand_total == BLACKJACK_AMOUNT
  end
  
end
