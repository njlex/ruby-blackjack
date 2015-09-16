#!/usr/bin/ruby

require 'io/console'

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

def is_blackjack?(cards)
  # TODO: take into account the ace which is either 1 or 11
  total = 0

  cards.each do |card| 
    total += get_value(card)
  end

  total == 21 ? true : false
end

def clear_screen
    system "clear"
end

def show_welcome
  $last_key = 0

  while $last_key != ESC_KEY && $last_key != ENTER_KEY do
    clear_screen

    show_top_border

    print_center "Welcome to Blackjack game!"
    print_center "Press Enter to start or Esc to quit"
    print_center ""

    $last_key = STDIN.raw(&:getbyte)
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

  print_center "Player has: " + show_cards(player).to_s
  print_center "Dealer has: " + show_cards(dealer).to_s

  if is_blackjack?(player)
    puts "Congrats! You win!"
end

show_welcome

if $last_key == ENTER_KEY
  start_game
end

show_bottom_border
