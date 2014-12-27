class Dealer
  require_relative 'hand'
  include Hand
  
  attr_reader :name
  attr_accessor :cards_held
  
  def initialize(name)
    @name = name
    @cards_held = []
  end
  
  def sticking?(total)
    total.between?(18,21)
  end
end

