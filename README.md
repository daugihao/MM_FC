# Description
This repository contains the code for the PassCube puzzles used during Midnight Madness 2019. The cubes were fully charged before their first use, as per the instructions, in order to maximise their battery life.

# Firmware
Due to the number of custom scripts which were used (16 scripts, 10 of which were the Lost script to mask all games in other menus except the volume script and the transportation mode script), the original FW8.0 was not happy to run. An update to FW8.6 was supplied by Jan Kresja, which is contained in this repository. **It seems to be a bug free release, and has been tested thoroughly, so I would strongly suggest an update to FW8.6 before proceeding with the scripts.**

## Relevant Scripts
The *GangPuzzles* folder contains all relevant code and audio files:
- gang1_curators.amx (Rubiks cube puzzle)
- gang2_cybersecurity.amx (Prime number equations puzzle)
- gang3_synthesisers.amx (Musical sequence puzzle)
- gang4_bikers.amx (Map puzzle)
- gang5_sparkies.amx (Minesweeper-esque puzzle)

There are two other scripts included in this folder which may be of use:
- welcome_audio.amx (Introduction to how to use the cube)
- lost.amx (Audio to indicate that the cube is in the wrong state if the players have managed to get out of beginners mode and access one of the other menus)