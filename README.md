Here is a pile of various designs implemented in HDL:

### 12_hour_clock.sv
This is a HH:MM:SS clock with AM/PM logic implemented using chained BCD counters and a 1-12 counter for the hour signal

### fulladder.sv
This is a simple full_adder derived from scratch. See HDL.pdf for my handwritten derivation using truth tables and boolean expressions.

### Conway_game_of_life.sv
This is a digital design capable of simulating Conway's game of life in parallel. If deployed, this design would execute much faster than a CPU.
The game is simulated on a 16x16 array where each cell follows the rules below:
- 0-1 neighbour: Cell becomes 0.
- 2 neighbours: Cell state does not change.
- 3 neighbours: Cell becomes 1.
- 4+ neighbours: Cell becomes 0.
