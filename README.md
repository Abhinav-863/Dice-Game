# Dice-Game
Overview

This repository contains the Verilog code for a simple dice game implemented as a finite state machine (FSM). The game simulates the rolling of dice, evaluates the outcome, and determines if the player wins, loses, or needs to roll again based on the rules of the game.

Game Rules

First Roll:

If the sum of the dice is 7 or 11, the player wins.
If the sum is 2, 3, or 12, the player loses.
For any other sum, this value is set as the "point," and the player must roll again.

Subsequent Rolls:

The player continues to roll the dice.

If the player rolls the point value again, they win.

If the player rolls a 7, they lose.

For any other value, the game continues with the player rolling again.

Module Description

Inputs

rb : Roll button input. When high, initiates a roll.

reset : Resets the game to the initial state.

clk : Clock input for state synchronization.

sum : The sum of the dice, provided as a 4-bit input.

Outputs

roll : Indicates a roll operation.

win : Indicates a win.

lose : Indicates a loss.

Internal Signals

state : Current state of the FSM.

nextstate : Next state of the FSM.

point : The point value established after the first roll.

sp : A signal used to store the point value.

FSM States

WAIT: The initial state. Waits for the player to press the roll button (rb).

FIRST_ROLL: The state after the first roll. Determines if the player wins, loses, or sets a point.

WIN_STATE: The player has won the game.

LOSE_STATE: The player has lost the game.

ROLL_AGAIN: The player continues to roll until they win or lose.

