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

player = [] 
dealer = [] 

# first turn
deal_card_to player, deck
deal_card_to dealer, deck

# second turn
deal_card_to player, deck
deal_card_to dealer, deck

puts "Player has: " + show_cards(player).to_s
puts "Dealer has: " + show_cards(dealer).to_s
