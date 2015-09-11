#!/usr/bin/ruby

require 'io/console'

# Game settings
WINDOW_WIDTH = 80

SUITS = ['♥', '♣', '♦', '♠']
CARDS = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']

deck = SUITS.product(CARDS);
deck.shuffle!

def deal_card_to(cards, deck)
  cards << deck.pop
end

def show_cards(cards)
  cards.map { |card| card.join(' ') }
end

def puts_center(message)
  puts message.center(WINDOW_WIDTH)
end

def print_center(message)
  print "|"
  print message.center(WINDOW_WIDTH)
  print "|"
  print "\n"
end

def show_top_border
  (WINDOW_WIDTH + 2).times { print '-' }
  print "\n"
end

def show_bottom_border
  (WINDOW_WIDTH + 2).times { print '-' }
  print "\n"
end

def show_welcome
  system "clear"

  show_top_border

  print_center "Welcome to Blackjack game!"
  print_center "Press Enter to start or Esc to quit"
  print_center ""
end

user_input = 0

# Esc key is 27 bytecode
while user_input != 27 do
  show_welcome

  user_input = STDIN.raw(&:getbyte)
end

player = [] 
dealer = [] 

# first turn
deal_card_to player, deck
deal_card_to dealer, deck

# second turn
deal_card_to player, deck
deal_card_to dealer, deck

print_center "Player has: " + show_cards(player).to_s
print_center "Dealer has: " + show_cards(dealer).to_s

show_bottom_border
