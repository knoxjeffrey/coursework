class Game
   
  NUMBER_OF_DECKS_FOR_GAME = 3
  
  LOSING_MESSAGE = "Your account is empty...the house always wins!\nThanks for playing %s"
  
  attr_reader :player, :dealer, :blackjack_deck
  attr_accessor :bet_placed
  
  def initialize
    UI.clear
    @player = Player.new(player_name, 100)
    @dealer = Dealer.new('Kryton')
    @blackjack_deck = DeckHandler.new
    @bet_placed = 0
  end
  
  def play
    begin
      if player.amount_in_account == 0
        UI.tell(LOSING_MESSAGE % player.name )
        return
      end
      
      run_game_sequence
    end while UI.ask_yes_no("Would you like to play again?: Y or N") == 'y'
  
    UI.tell "Thanks for playing #{player.name}" 
  end
  
  
  private
  
  
  def show_cards_on_table(dealer_cards_held, player_cards_held)
    UI.tell "The dealers cards are:"
    blackjack_deck.display_cards(dealer_cards_held)
  
    UI.tell "#{player.name}'s cards are:"
    blackjack_deck.display_cards(player_cards_held)
  end
  
  def setup_game
    UI.tell "#{player.name} you have £#{player.amount_in_account} in your account. Let's play!"
    UI.clear
    fill_game_deck
    UI.clear
    player.clear_hand
    dealer.clear_hand
    take_player_bet
    UI.clear
    deal_initial_cards
    show_cards_on_table(dealer.hand_with_hole_card, player.cards_held)
  end
  
  def take_player_bet
    begin
      self.bet_placed = UI.ask("Place your bet! You have £#{player.amount_in_account} in your account")
    end while !MoneyChecker.correct_money_entered?(bet_placed, player.amount_in_account)
  end
  
  def deal_initial_cards
    2.times { player.receive_card(blackjack_deck.deal_card) }
    2.times { dealer.receive_card(blackjack_deck.deal_card) }
  end
  
  def blackjack_on_first_draw?
    if player.blackjack?
      UI.tell "Well done #{player.name}, you have won the game!"
      player.win_money(bet_placed.to_i)
      true 
    end
  end
  
  
  def player_round
    begin
      dealer.hand_with_hole_card
      show_cards_on_table(dealer.hand_with_hole_card, player.cards_held)
      break if player.bust?
      decision = UI.ask_yes_no("#{player.name}, would you like another card? Y or N")
      if decision == 'y'
        UI.clear
        player.receive_card(blackjack_deck.deal_card)
      end
    end while decision == 'y'
  end
  
  def dealer_round
    UI.clear
    loop do
      UI.tell "The dealer is playing..."
      show_cards_on_table(dealer.cards_held, player.cards_held)
      break if dealer.sticking?
      break if dealer.bust?
      sleep 2
      UI.clear

      dealer.receive_card(blackjack_deck.deal_card)
    end 
  end
  
  def declare_result(bet_placed)
    if player_wins?
      player.win_money(bet_placed)
      UI.tell "Congratulations #{player.name}, you have won the game!"
    elsif dealer_wins?
      player.lose_money(bet_placed)
      UI.tell "Sorry #{player.name}, the dealer has won the game."
    else
      UI.tell "It's a tie! Have a go at beating the dealer again #{player.name}."
    end
  end
  
  def dealer_wins?
    player.hand_total < dealer.hand_total
  end
  
  def player_wins?
    player.hand_total > dealer.hand_total
  end
  
  def run_game_sequence
    
    setup_game
    return if blackjack_on_first_draw?
  
    UI.clear
  
    player_round
    
    if player.bust?
      player.lose_money(bet_placed.to_i)
      UI.tell "#{player.name} is bust and has lost the game.  #{dealer.name} has won!"
      return
    end

    dealer_round
    
    if dealer.bust?
      player.win_money(bet_placed.to_i)
      UI.tell "The dealer is bust. #{player.name} has won!" 
      return
    end
      
    sleep 1
    UI.clear
    show_cards_on_table(dealer.cards_held, player.cards_held)
  
    declare_result(bet_placed.to_i)
  end
    
  def player_name
    UI.ask "Welcome to this game of Blackjack. Please enter your name:"
  end
  
  def fill_game_deck
    if blackjack_deck.game_deck.empty? || blackjack_deck.game_deck.size <= 30
      blackjack_deck.replenish_deck(NUMBER_OF_DECKS_FOR_GAME)
      UI.tell "...New deck is ready"
      sleep 2
    end
  end 
  
end