#!/usr/bin/ruby

# @TODO:
# Check for tie blackjack

require 'io/console'
require 'pry'

# Game settings
WINDOW_WIDTH = 80
ESC_KEY = 27
H_KEY = 104
S_KEY = 115
ENTER_KEY = 13

$last_key = 0

SUITS = ['♥', '♣', '♦', '♠']
CARDS = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']

def shuffle_cards(deck)
  deck.shuffle!
end

def deal_card_to(cards, deck)
  cards << deck.pop
end

def show_cards(cards)
  cards.map { |card| card.join(' ') }
end

def puts_center(message)
  print "|"
  print message.center(WINDOW_WIDTH)
  print "|"
  print "\n"
  print "|"
  print "".center(WINDOW_WIDTH) 
  print "|"
  print "\n"
end

def print_center(message)
  print "|"
  print message.center(WINDOW_WIDTH)
  print "|"
  print "\n"
end

def show_top_border
  system 'clear'
  print "\n"
  (WINDOW_WIDTH + 2).times { print '~' }
  print "\n"
end

def show_bottom_border
  (WINDOW_WIDTH + 2).times { print '~' }
  print "\n"
end

def compare_cards(player, dealer, message = '')
  clear_screen

  puts_center message
  print_center "You have: " + show_cards(player).to_s
  puts_center "Total value: " + card_total(player).to_s

  print_center "Dealer has: " + show_cards(dealer).to_s
  puts_center "Total value: " + card_total(dealer).to_s
end

def get_value(card)
  # card[0] is the suit, card[1] is the value 2 - 10 and J, Q, K
  if card[1] == 'A'
    11
  elsif card[1].to_i == 0
    10
  else
    card[1].to_i
  end
end

def card_total(cards)
  total = 0

  cards.each do |card| 
    value = get_value(card)

    if value == 11 && ((total + value) > 21)
      total += 1
    else
      total += value
    end
  end

  total
end

def is_blackjack?(cards)
  card_total(cards) == 21
end

def is_busted?(cards)
  card_total(cards) > 21
end

def clear_screen
    system "clear"

    show_top_border
end

def wait_for_input
  show_bottom_border

  $last_key = STDIN.raw(&:getbyte)
end

def show_welcome
  $last_key = 0

  while $last_key != ESC_KEY && $last_key != ENTER_KEY do
    clear_screen

    puts_center "Welcome to Blackjack game!"

    print_center "= Keyboard Controls ="
    print_center "h for hit"
    puts_center "s for stay"

    print_center "= Credits ="
    puts_center "Copyright Noel Jarencio - Lexmark R&D"

    puts_center "Press Enter to begin playing or Esc to quit"

    wait_for_input
  end
end

def start_game
  # Game started
  clear_screen

  deck = SUITS.product(CARDS)

  shuffle_cards deck

  # Initialize both dealer and player
  player = [] 
  dealer = [] 

  # first deal
  deal_card_to player, deck
  deal_card_to dealer, deck

  # second deal
  deal_card_to player, deck
  deal_card_to dealer, deck

  # Player's turn first
  if is_blackjack?(player)
    compare_cards player, dealer, "Congrats! You win!"
  else
    players_turn = true
    dealers_turn = false

    while players_turn
      clear_screen

      puts_center "Please press h for hit or s to stay"

      print_center "You have: " + show_cards(player).to_s
      puts_center "Total value: " + card_total(player).to_s

      players_turn = wait_for_input == H_KEY

      # Player chooses hit
      if $last_key == H_KEY
        deal_card_to player, deck

        #clear_screen

        #print_center "You have: " + show_cards(player).to_s
        #puts_center "Total value: " + card_total(player).to_s

        if is_blackjack?(player)
          compare_cards player, dealer, "Congrats! You win!"
          players_turn = false
          break
        elsif is_busted?(player)
          compare_cards player, dealer, "You lose!"
          players_turn = false
          break
        end
      elsif $last_key == S_KEY
        players_turn = false
        dealers_turn = true
        break
      else
        players_turn = true
        dealers_turn = false
      end
    end
  end

  must_decide_winner = false

  # Dealer's turn
  if dealers_turn && card_total(dealer) < 17
    while card_total(dealer) < 17
      deal_card_to dealer, deck

      if is_blackjack?(dealer)
        compare_cards player, dealer, "You lose!"
        break
      elsif is_busted?(dealer)
        compare_cards player, dealer, "Dealer is busted! You win!"
        break
      elsif card_total(dealer) >= 17
        must_decide_winner = true
      end
    end
  elsif dealers_turn
    must_decide_winner = true
  end

  # Player and dealer's turn is finish, we must decide the winner by who's highest
  if must_decide_winner 
    # Hands down and compare cards
    if card_total(dealer) > card_total(player)
      message = "You lose!"
    else
      message = "Congrats! You win!"
    end

    compare_cards player, dealer, message
  end
end

show_welcome

while $last_key != ESC_KEY
  if $last_key == ENTER_KEY
    start_game
  end

  puts_center "Would you like to play again? Enter to continue or Esc to quit."

  wait_for_input

  clear_screen
end

if $last_key == ESC_KEY
  clear_screen
  print_center ""
  print_center "Thank you for playing!"
  print_center ""
end

show_bottom_border
