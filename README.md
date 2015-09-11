## A sample Blackjack game using Ruby Programming Language

### Pseudo Code

```Show welcome message
Start game
  Dealer shuffles cards
  Dealer deals 1 card to player
  Dealer deals 1 card to self
  Dealer deals another card to player
  Dealer deals another card to self

  if player cards total reached 21
    then blackjack! player wins
  else
    do while player's turn 
      Display message to let player choose "hit" or "stay"
      Wait for player input

      if player chooses hit
        dealer deals 1 card to player

        if player cards total reached 21
          then blackjack! player wins
          break loop
        else if player cards total is over 21
          then player is busted/lost
          break loop
        else
          continue loop, player's turn 
      else if player choose stay
        save total of cards
        break loop
    loop

  do while dealer cards total less than 17
    dealer deals 1 card to self

    if dealer cards total reached 21
      dealer wins
      break loop
    else if dealer cards total is over 21
      player wins
      break loop
  loop

  when dealer has reached 17 or more, 
  check if dealer cards total is greater than player cards total
    then dealer wins
  else
    player wins

  show play again message

  if player wants to play again
    start another game
```
