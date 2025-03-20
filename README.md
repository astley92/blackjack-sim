# Blackjack Simulator

A program that contains a bunch of common blackjack strategies and runs a simulation over a certain amount of hands,
plotting each strategies results.

Potentially, this could be the base of a game I'm thinking about where users submit their own strategies to take on
different deck configurations in order to make the most money or beat certain goals.

This project however, will not have the concept of other players and is purely a visualization tool of certain
strategies against different deck configurations.

# Notes

## Data Modelling

A table has a dealer
A dealer has a shoe
A shoe has many decks
A deck has many cards
A table has many players
A player has many hands
A hand has a bet

## Strategy setup

A strategy can take three forms
1. A simple ruby class that has switch statements
1. A lookup table based on the dealer card and player cards
1. A network of neurons and weights (AI)

## Visualisation

The ruby program should output a file that contains all information required for another program to build and display a
visualisation.

In order to ensure it outputs what is required, lets outline what we want to show:
1. A graph showing player balances over time
1. The total win/loss of each player
1. The win/loss rate of each player

# MVP

Let's get something built as a base to build out everything described above. It should:
1. Contain all game logic
    - Hand playing
    - Deck rebuilding at marker
    - Deck and table configurations
    - Dealer action logic
1. Visualisation data output
1. Visualisation display
1. Run 10k rounds
1. Two strategies
    - A simple ruby class sitter strategy
    - A lookup table standard theory strategy

