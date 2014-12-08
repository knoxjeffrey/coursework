CARD_VALUES = {'Ace' => [1,11], 'Jack' => 10, 'Queen' => 10, 'King' => 10}

DECK_OF_CARDS = {hearts: ['Ace',2,3,4,5,6,7,8,9,'Jack','Queen','King'], diamonds: ['Ace',2,3,4,5,6,7,8,9,'Jack','Queen','King'], 
                spades: ['Ace',2,3,4,5,6,7,8,9,'Jack','Queen','King'], clubs: ['Ace',2,3,4,5,6,7,8,9,'Jack','Queen','King']}
            
first_deck_of_cards = {}
second_deck_of_cards = {}
third_deck_of_cards = {}
game_deck = []
total_cards_played = 0

def valid_decision?(the_decision)
  if ['y', 'n'].include?(the_decision.downcase)
    true
  else
    print_string "You must enter Y or N. Please try again"
  end
end

def print_string(text)
  puts "\n==> #{text}"
end

#THIS IS IMPORTANT - can't just use '=' or 'clone' or 'Hash[DECK_OF_CARDS]' as they all create a shallow copy and changes propogates
#through to the DECK_OF_CARDS constant.  This solution serializes the object to a string and then de-serializes it into our new object. 
#This way breaks the chain of references  
def initiate_the_deck(deck_one, deck_two, deck_three)
  deck_one = Marshal.load(Marshal.dump(DECK_OF_CARDS))
  deck_two = Marshal.load(Marshal.dump(DECK_OF_CARDS))
  deck_three = Marshal.load(Marshal.dump(DECK_OF_CARDS))
  the_game_deck = [deck_one, deck_two, deck_three]
  return the_game_deck
end

#deals a random card from the game_deck.  That card is then removed from the game_deck array, stored as a hash and returned.
def deal_a_card(from_the_deck)
  deck_chosen_from = from_the_deck.sample
  key_chosen_from_deck = deck_chosen_from.keys.sample
  value_chosen_from_deck = deck_chosen_from[key_chosen_from_deck].sample
  
  remove_from_deck(deck_chosen_from, key_chosen_from_deck, value_chosen_from_deck)
  
  #delete any hash key with and empty array value
  if deck_chosen_from[key_chosen_from_deck].empty?
    deck_chosen_from.delete(key_chosen_from_deck)
  end
  
  picked_card = { key_chosen_from_deck => value_chosen_from_deck }
end

def remove_from_deck(which_deck, key, value)
  which_deck[key].delete(value)
end

#adds the dealt card to the player or dealer array and stored as an array
def dealer_and_player_getting_cards(from_the_deck, card_array)
  card_retrieved = deal_a_card(from_the_deck)
  card_array << [card_retrieved.keys[0], card_retrieved.values[0]]
end

#uses a recursive function to deal a default 2 cards at the start of the game. 2 cards will always be the case so when calling the method
#we don't need to issue the number of deals.
def initial_deal(number_of_deals=2, deck, player_card_array, dealer_card_array)
  dealer_and_player_getting_cards(deck, player_card_array)
  dealer_and_player_getting_cards(deck, dealer_card_array)
  initial_deal(number_of_deals=1, deck, player_card_array, dealer_card_array) if number_of_deals > 1
end

def cards_on_table(player_card_array, dealer_card_array, player_name)
  print_string "The dealers cards are:"
  dealer_card_array.each { |card_array| puts "#{card_array[1]} of #{card_array[0]}"}
  if card_total_array(dealer_card_array).size < 2
    print_string "The dealers total is #{card_total_array(dealer_card_array)[0]}"
  else
    print_string "The dealers total is #{card_total_array(dealer_card_array)[0]} or #{card_total_array(dealer_card_array)[1]}"
  end
  
  print_string "#{player_name}'s cards are:"
  player_card_array.each { |card_array| puts "#{card_array[1]} of #{card_array[0]}"}
  if card_total_array(player_card_array).size < 2
    print_string "#{player_name}'s total is #{card_total_array(player_card_array)[0]}"
  else
    print_string "#{player_name}'s total is #{card_total_array(player_card_array)[0]} or #{card_total_array(player_card_array)[1]}"
  end
end

#returns an array with the total in it. If no Aces there is only one value in the array. With 1 ace or more there are 2 values in the array due
#to the ace being either a 1 or 11
def card_total_array(player_or_dealer_array)
  card_value_counter = 0
  number_of_aces = 0
  total_value = []
  player_or_dealer_array.each do |card_array|
    if card_array[1].is_a? Integer
      card_value_counter += card_array[1]
    elsif card_array[1] != 'Ace'
      card_value_counter += CARD_VALUES[card_array[1]]
    else
      number_of_aces += 1
    end
  end
  #only 1 ace can ever be used as 11 otherwise the total will be over 21. Therefore the last option below has all aces as 1 or 1 ace as 11 and 
  #the rest as 1
  if number_of_aces == 0
    return total_value << card_value_counter
  elsif number_of_aces == 1
    return total_value << (card_value_counter + CARD_VALUES['Ace'][0]) << (card_value_counter + CARD_VALUES['Ace'][1])
  else
    return total_value << (card_value_counter + (CARD_VALUES['Ace'][0]*number_of_aces)) << (card_value_counter + (CARD_VALUES['Ace'][0]*(number_of_aces-1)) + (CARD_VALUES['Ace'][1]))
  end
end

def player_game_logic(player_totals_array)
  if player_totals_array.size == 1
    if player_totals_array[0] > 21
      return :bust
    else
      return :can_play_on
    end
  else
    if (player_totals_array[0] > 21) && (player_totals_array[1] > 21)
      return :bust
    else (player_totals_array[0] <= 21) || (player_totals_array[1] <= 21)
      return :can_play_on
    end
  end
end

def dealer_game_logic(dealer_totals_array)
  if dealer_totals_array.size == 1
    if dealer_totals_array[0] == 21
      return :stick
    elsif dealer_totals_array[0] > 21
      return :bust
    elsif dealer_totals_array[0] < 17
      return :must_deal_again
    end
  else
    if (dealer_totals_array[0] == 21) || (dealer_totals_array[1] == 21)
      return :stick
    elsif (dealer_totals_array[0] > 21) && (dealer_totals_array[1] > 21)
      return :bust
    elsif (dealer_totals_array[0] <= 17) || (dealer_totals_array[1] <= 17)
      return :must_deal_again
    else
      return :stick
    end
  end
end

def declare_result(name, player_card_values, dealer_card_values)
  player_best_hand = player_card_values.select { |card_value| card_value <= 21 }
  dealer_best_hand = dealer_card_values.select { |card_value| card_value <= 21 }
  
  if player_best_hand.max > dealer_best_hand.max
    print_string "Congratulations #{name}, you have won the game!"
  elsif player_best_hand.max < dealer_best_hand.max
     print_string "Sorry #{name}, the dealer has won the game."
  else
    print_string "It's a tie! Have a go at beating the dealer again #{name}."
  end
end

def replenish_deck?(total_number_of_cards_played)
  if (total_number_of_cards_played > 136) || (total_number_of_cards_played == 0)
    true
  else
    false
  end
end

def blackjack(player_name, game_deck, player_cards, dealer_cards)
  puts `clear`
  initial_deal(game_deck, player_cards, dealer_cards)
  
  begin
    cards_on_table(player_cards, dealer_cards, player_name)
    player_totals_array = card_total_array(player_cards)
    any_more_deals = player_game_logic(player_totals_array)
    break if any_more_deals == :bust
  
    begin
      print_string "#{player_name}, would you like another card? Y or N"
      decision = gets.chomp
    end while !valid_decision?(decision)
  
    if decision.downcase == 'y'
      puts `clear`
      dealer_and_player_getting_cards(game_deck, player_cards)
    end
  
  end while decision.downcase == 'y'

  if (any_more_deals == :bust)
    print_string "#{player_name} is bust and has lost the game.  The dealer has won!"
    return
  end

  begin
    cards_on_table(player_cards, dealer_cards, player_name)
    dealer_totals_array = card_total_array(dealer_cards)
    any_more_deals = dealer_game_logic(dealer_totals_array)
    break if ((any_more_deals == :stick) || (any_more_deals == :bust))
    puts `clear`
    dealer_and_player_getting_cards(game_deck, dealer_cards)
  end while any_more_deals == :must_deal_again

  if (any_more_deals == :bust)
    print_string "The dealer is bust and has lost the game. #{player_name} has won!"
    return
  end
  
  declare_result(player_name, player_totals_array, dealer_totals_array)
end

puts `clear`
print_string "Welcome to this game of Blackjack.  Please enter your name:"
the_player_name = gets.chomp

begin
  puts `clear`
  if replenish_deck?(total_cards_played)
    game_deck = initiate_the_deck(first_deck_of_cards, second_deck_of_cards, third_deck_of_cards)
    total_cards_played = 0
    print_string "Getting the deck ready..."
    sleep 1
    print_string "waiting..."
    sleep 1
    print_string "Ready to play!"
  end
  
  player_cards = []
  dealer_cards = []
  blackjack(the_player_name, game_deck, player_cards, dealer_cards)

  total_cards_played = total_cards_played + player_cards.size + dealer_cards.size
  
  begin
    print_string "Would you like to play again?: Y or N"
    decision = gets.chomp
  end while !valid_decision?(decision)
end while decision.downcase == 'y'  