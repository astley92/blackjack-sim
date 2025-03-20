# Blackjack Simulator

A program that contains a bunch of common blackjack strategies and runs a simulation over a certain amount of hands,
plotting each strategies results.

Potentially, this could be the base of a game I'm thinking about where users submit their own strategies to take on
different deck configurations in order to make the most money or beat certain goals.

This project however, will not have the concept of other players and is purely a visualization tool of certain
strategies against different deck configurations.

# Notes

## Seat to Player to Hand relationship
A table has many seats
A seat is occupied by one player
A seat is dealt one hand
That hand can turn into multiple in the case of splits
Each hand is paid at the end

## Strategy setup
