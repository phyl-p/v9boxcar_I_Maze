# v9boxcar_I_Maze
A hippocampal CA3 model training on the I-Maze behavioral problem, Levy Lab

This file also contains a trace conditioning model that co-exists wth the I-Maze behavioral model. Before running I-Maze, be sure to switch "toggle_trace" in InitialiseParamters.m in the Initialise folder off, and like wise, "toggle_I_Maze" to be on.

The current version of this I-Maze does not have the necessary attractors implemented during either training or testing. The updates will be implemented today.

Setting up parameters for simulation:
Go to Initialise/InitialiseParameters.m, look through the parameters structure to see what you want to change about the either the hippocampal model or the behavioral training model.
